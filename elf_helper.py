#!/usr/bin/env python

import commands
import sys
import shutil
import struct
import subprocess

def to_binary_code(shellcode):
    hex_list = shellcode.split('\\x')[1:]
    return ''.join([struct.pack('<B',int(t,16)) for t in hex_list])

def to_shellcode(binary):
    shellcode = ''.join([ '\\x{0:x}'.format(struct.unpack('<B',t)[0]) for t in binary])
    return shellcode
'''
def get_text_section(object_file):
    """format into a shellcode string of bytes"""
    tmp = commands.getoutput("objdump -d %s" % (object_file))
    opcodes = ''
    for line in tmp.split('\n')[7:]:
      tmp = line.split(':',1)
      if len(tmp) > 1 and len(tmp[1]) > 0: tmp = tmp[1]
      else: continue
      # split on tab to get opcodes
      tmp = ''.join(tmp).split('\t')
      if len(tmp) > 1: tmp = tmp[1].strip().replace(' ','')
      if '<' in tmp: continue
      opcodes += tmp
    formatted_codes = ''.join(["\\x"+opcodes[idx]+opcodes[idx+1] for idx in range(0,len(opcodes)-1,2)])
    print >>sys.stderr,"text_section:{0}\n".format(formatted_codes)
    return formatted_codes
'''

def parse_text_section(obj):
    '''
    return a dict like this,{'name':'foo','offset':'00ff','opcode':\x90\x90...}
    only support .o file
    '''

    '''
    if line like this:#080484a0 <_fini>:
    return (offset,name)
    '''
    def get_func_title(line):
      t = line.split(':',1)
      if len(t) == 2 and t[1] == '' and len(t[0].split()) == 2:
        (offset,name) = t[0].split(' ')
        if name[0] == '<' and name [-1] == '>':
          name = name[1:-1]
        return (offset,name)
      return None

    def get_opcode(line):
      opcodes = line.split(':')[1].split('\t')[1].strip().replace(' ','') 
      return ''.join(["\\x"+opcodes[idx]+opcodes[idx+1] for idx in range(0,len(    opcodes)-1,2)])
    def find_invalid(line):
      if line.startswith('Disassembly') or '...' in line or '' == line:
        return True
      return False


    out = commands.getoutput("objdump -d {0}".format(obj)).split('\n')[6:]
    funcs = []
    func = {}
    (func['offset'],func['name']) = get_func_title(out[0])
    func['opcode'] = []
    for line in out[1:]:
      if find_invalid(line) == True:
        continue
      if get_func_title(line) != None:
        funcs.append(func)
        func = {}
        (func['offset'],func['name']) = get_func_title(line)
        func['opcode'] = []
        continue
      func['opcode'].append(get_opcode(line)) 
    funcs.append(func)
    funcs_ = {}
    for i in funcs:
      funcs_[i['name']] = {'offset':i['offset'],
          'opcode':i['opcode']}
    return funcs_

def get_func_addr(elf,func):
    tmp = commands.getoutput("objdump -d {0} | grep {1}".format(elf,func))
    if len(tmp) == 0:
        print >>sys.stderr,"{0} not exits in {1}\n".format(elf,func)
        return
    # need packed
    return int(tmp.split('\n')[0].split()[0],16)

def write_str_elf(elf,offset,value):
    #output = "{0}.tmp"
    #shutil.copy2(elf, output)
    old = ''
    with open(elf,'r+') as f:
      st ='<'
      for i in value:
        st += 'B'
      #print st,value
      f.seek(offset,0)
      #old += struct.unpack(st,f.read(len(to_binary_code(value))))[0]
      old = f.read(len(value))
      f.seek(offset,0)
      f.write(value)
    #shutil.move(output,elf)
    print "[+] write:{0} => {1}\n".format(to_shellcode(old),to_shellcode(value))


def write_addr_elf(elf,output,offset,value):
    shutil.copy2(elf, output)
    with open(output,'r+') as f:
        f.seek(offset,0)
        old = struct.unpack('<I',f.read(4))[0]
        f.seek(offset,0)
        f.write(struct.pack('<I', value))
    print "fix:{0:#x}->{1:#x}\n".format(old,value)

def get_relocate_text(obj):
    tmp = commands.getoutput("readelf -r {0}".format(obj)).split('\n')[3:]
    symbs = []
    for t in tmp:
      if t == '':
        break
      if not t.split()[4].startswith('.'):
          item = {}
          item['offset'] = int(t.split()[0],16)
          item['name'] = t.split()[4]
          symbs.append(item)
    return symbs

def run_cmd(cmd):
    """
    execute cmd and return stdout,ignore stderr
    """
    tmp = subprocess.Popen(cmd, shell=True,stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE).communicate()[0]
    return tmp

def offset_file_vaddr(elf):
    """
    1. Get virtual addr of LOAD from segment table
    2. Get offset of LOAD from segment table
    3. Return addr - offset 
    """
    cmd = "readelf -l {0} | grep LOAD | tr -s ' ' | cut -d ' ' -f 4".format(elf)
    tmp = run_cmd(cmd)
    vaddr = tmp.split('\n')[0]

    cmd = "readelf -l {0} | grep LOAD | tr -s ' ' | cut -d ' ' -f 3".format(elf)
    tmp = run_cmd(cmd)
    offset = tmp.split('\n')[0]

    return int(vaddr,16) - int(offset,16)

if __name__ == '__main__':
    from elfbin import elfbin
    elfp = elfbin(sys.argv[1]) #object file
    text_base = elfp.get_section_offset(".text")
    #print ".text offset:{0:#x}\n".format(text_base)
    unsolved = get_relocate_text(sys.argv[1])
    print unsolved
    funcs = parse_text_section(sys.argv[1])
    output = "{0}.fixed".format(sys.argv[1])
    src = sys.argv[1]

    for s in unsolved:
        addr = get_func_addr(sys.argv[2],s['name'])
        if addr == None:
          print "%s can not be solved"%(s['name'])
          continue
        print "{0}->{1:#x}\n".format(s['offset'],addr)
        write_elf(src,output,text_base + s['offset'],addr)
        src=output

