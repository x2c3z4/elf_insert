#!/usr/bin/env python

import sys
import os
import signal
import time
from optparse import OptionParser
from elfpatch import elfpatch
from elf_helper import *
from genshellcode import *


def signal_handler(signal, frame):
    print '\nProgram Exit'
    sys.exit(0)
def basicDiscovery(FILE):
    testBinary = open(FILE, 'rb')
    header = testBinary.read(4)
    testBinary.close()
    if 'MZ' in header:
        return 'PE'
    elif 'ELF' in header:
        return 'ELF'
    else:
        'Only support ELF formats'
        return None

MAGIC_PREFIX_INJECT="hook_"
def main():
    author = """\
         Author:    Feng,Li
         Email:     lifeng1519@gmail.com
         """
    print author

    signal.signal(signal.SIGINT, signal_handler)

    parser = OptionParser(usage='%prog [options]',description="inject tool."
                      "-t -s -I,please choose one,but -I is the best")

    parser.add_option("-f", "--file", dest="FILE", action="store",
                      type="string",
                      help="[must] File to patch")
    parser.add_option("-t", "--object_file", default=False,
                      dest="OBJECT_FILE", action="store",
                      help="Get text section and  add it to out file")
    parser.add_option("-s", "--shellcode", type="string",
                      dest="SHELLCODE", action="store",
                      help="User supplied shellcode, place it in text section,"
                      "make sure that it matches"
                      " the architecture that you are targeting.")
    parser.add_option("-I", "--inject_nasm_file", type="string", action="store",
                      help="nasm file to inject")
    parser.add_option("-o", "--output-file", default=None, dest="OUTPUT",
                      action="store", type="string",
                      help="The output file")
    """ ---deprecated----"""
    parser.add_option("-i", "--inject_ins", type="string",
                      dest="INJECT_INS", action="store",
                      help="[deprecated] inject instruction into func's prolog."
                      "use --inject_nasm_file instead")
    """ ---deprecated----"""
    parser.add_option("-F", "--func_name", help="[deprecated] where inject."
                      "using --inject_nasm_file instead")

    parser.add_option("-v", "--verbose", default=False, dest="VERBOSE",
                      action="store_true",
                      help="For debug information output.")

    (options, args) = parser.parse_args()
    if not options.FILE or (not options.SHELLCODE and \
        not options.OBJECT_FILE and not options.inject_nasm_file):

        parser.print_help()
        sys.exit(1)

    if options.INJECT_INS or options.func_name:
        print "option has deprecated!!!"
        parser.print_help()
        sys.exit(1)

    if not options.OUTPUT:
        options.OUTPUT = options.FILE + ".patched"

    is_supported = basicDiscovery(options.FILE)
    if is_supported != 'ELF':
        print >>sys.stderr,"[-] file not supported!\n"
        sys.exit(1)

    """
    parse inject nasm file to a dict
    """
    if options.inject_nasm_file:
      '''
      1. compile the .nasm to .o
      2. disassemble .o to get a dict
      3. fix the dict's key to our injection pointer
      eg: hook_FsOpen --->  FsOpen
      '''
      options.SHELLCODE = encode(compile_nasm_file(options.inject_nasm_file,"elf"))
      inject_o = options.inject_nasm_file.replace(".nasm", ".o")
      inject_funcs = parse_text_section(inject_o)
      for k in inject_funcs:
        if len(k) > 5 and k[0:5] == MAGIC_PREFIX_INJECT:
          inject_funcs[k[5:]] = inject_funcs.pop(k)
      print inject_funcs

    """
    parse elf and patch our shellcode to elf
    """
    elfp = elfpatch(options.FILE,
                options.OUTPUT,
                options.SHELLCODE,
                options.OBJECT_FILE)
    (entry,inject_point) = elfp.patch_elf()
    offset_base = offset_file_vaddr(options.OUTPUT)
    print "[+] entry: {0:#x} inject_point: {1:#x} "\
      "base offset: {2:#x}".format(entry,inject_point,offset_base)

    """
    insert jump instrument at the beginning of patched elf
    1. disassemble elf to get a dict.
    2. travel the inject_funcs to compute the file offset.
    3. inject a 'push xxxx\nret' to inject func point.
    """
    funcs = parse_text_section(options.OUTPUT)
    for k in inject_funcs:
      if not k in funcs:
        #print "[*] {0} not exist!".format(k)
        continue
      offset = int(funcs[k]['offset'],16)
      inject_offset = int(inject_funcs[k]['offset'],16)
      file_offset = offset - offset_base
      jmp_addr = inject_point + inject_offset
      prolog_instrument = "push {0:#x}\nret".format(jmp_addr)
      pro_shellcode = compile_instruction(prolog_instrument,"elf")
      print "[+] prolog_instrument: {0}".format(repr(prolog_instrument))
      print "[+] injecting prolog: {0}".format(pro_shellcode)
      write_str_elf(options.OUTPUT,file_offset,to_binary_code(pro_shellcode))

      print """[+] func: {0}
          offset: {1:#x}
          file_offset: {2:#x}
          jmp_addr: {3:#x}""".format(k,offset, file_offset, jmp_addr)
    print "[+] Done! Output: {0}".format(options.OUTPUT)

if __name__ == "__main__":
    main()
