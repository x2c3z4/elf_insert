#!/usr/bin/env python
import struct
import os
import sys
import shutil
from elf_helper import *

class elf():
    """
    ELF data format class for BackdoorFactory.
    We don't need the ENTIRE format.
    """

    #setting linux header infomation
    e_ident = {"EI_MAG": "\x7f" + "ELF",
                "EI_CLASS": {0x01: "x86",
                             0x02: "x64"
                            },
                "EI_DATA_little": 0x01,
                "EI_DATA_big": 0x02,
                "EI_VERSION": 0x01,
                "EI_OSABI": {0x00: "System V",
                             0x01: "HP-UX",
                             0x02: "NetBSD",
                             0x03: "Linux",
                             0x06: "Solaris",
                             0x07: "AIX",
                             0x08: "IRIX",
                             0x09: "FreeBSD",
                             0x0C: "OpenBSD"
                             },
                "EI_ABIVERSION": 0x00,
                "EI_PAD": 0x07
                }

    e_type = {0x01: "relocatable",
              0x02: "executable",
              0x03: "shared",
              0x04: "core"
             }

    e_machine = {0x02: "SPARC",
                 0x03: "x86",
                 0x14: "PowerPC",
                 0x28: "ARM",
                 0x32: "IA-64",
                 0x3E: "x86-64",
                 0xB7: "AArch64"
                }
    e_version = 0x01
#end elf class

class elfbin():
    """
    This is the class handler for the elf binary format
    """
    def __init__(self, FILE):
        self.FILE = FILE
        self.bin_file = open(self.FILE, "r+b")
        self.text_section = -1
        self.gather_file_info()

    def get_section_name(self, section_offset):
        '''
        Get section names
        '''
        self.bin_file.seek(self.sec_hdr[self.e_shstrndx]['sh_offset']+section_offset,0)
        name = ''
        j = ''
        while True:
            j = self.bin_file.read(1)
            if hex(ord(j)) == '0x0':
                break
            else:
                name += j
        #print "name:", name
        return name


    def set_section_name(self):
        '''
        Set the section names
        '''
         #how to find name section specifically
        for i in range(0, self.e_shstrndx+1):
            self.sec_hdr[i]['name'] = self.get_section_name(self.sec_hdr[i]['sh_name'])
            if self.sec_hdr[i]['name'] == ".text":
                #print "Found text section"
                self.text_section =  i

    def get_section_offset(self,secname):
        for i in range(self.e_shnum):
            if self.sec_hdr[i]['name'] == ".text":
                return self.sec_hdr[i]['sh_offset']
        return None

    def gather_file_info(self):
        '''
        Gather info about the binary
        '''
        print "[*] Gathering file info"
        bin = self.bin_file
        bin.seek(0)
        EI_MAG = bin.read(4)
        self.EI_CLASS = struct.unpack("<B", bin.read(1))[0]
        self.EI_DATA = struct.unpack("<B", bin.read(1))[0]
        if self.EI_DATA == 0x01:
            #little endian
            self.endian = "<"
        else:
            #big self.endian
            self.endian = ">"
        self.EI_VERSION = bin.read(1)
        self.EI_OSABI = bin.read(1)
        self.EI_ABIVERSION = bin.read(1)
        self.EI_PAD = struct.unpack("<BBBBBBB", bin.read(7))[0]
        self.e_type = struct.unpack("<H", bin.read(2))[0]
        self.e_machine = struct.unpack(self.endian + "H", bin.read(2))[0]
        self.e_version = struct.unpack(self.endian + "I", bin.read(4))[0]
        #print "EI_Class", self.EI_CLASS
        if self.EI_CLASS == 0x01:
            #print "32 bit D:"
            self.e_entryLocOnDisk = bin.tell()
            self.e_entry = struct.unpack(self.endian + "I", bin.read(4))[0]
            #print hex(self.e_entry)
            self.e_phoff = struct.unpack(self.endian + "I", bin.read(4))[0]
            self.e_shoff = struct.unpack(self.endian + "I", bin.read(4))[0]
        else:
            #print "64 bit B:"
            self.e_entryLocOnDisk = bin.tell()
            self.e_entry = struct.unpack(self.endian + "Q", bin.read(8))[0]
            self.e_phoff = struct.unpack(self.endian + "Q", bin.read(8))[0]
            self.e_shoff = struct.unpack(self.endian + "Q", bin.read(8))[0]
        #print hex(self.e_entry)
        #print "e_phoff", self.e_phoff
        #print "e_shoff", self.e_shoff
        self.VrtStrtngPnt = self.e_entry
        self.e_flags = struct.unpack(self.endian + "I", bin.read(4))[0]
        self.e_ehsize = struct.unpack(self.endian + "H", bin.read(2))[0]
        self.e_phentsize = struct.unpack(self.endian + "H", bin.read(2))[0]
        self.e_phnum = struct.unpack(self.endian + "H", bin.read(2))[0]
        self.e_shentsize = struct.unpack(self.endian + "H", bin.read(2))[0]
        self.e_shnum = struct.unpack(self.endian + "H", bin.read(2))[0]
        self.e_shstrndx = struct.unpack(self.endian + "H", bin.read(2))[0]
        #self.e_version'] = struct.e_entry
        #section tables
        bin.seek(self.e_phoff,0)
        #header tables
        if self.e_shnum == 0:
            print "more than 0xFF00 sections, wtf?"
            #print "real number of section header table entries"
            #print "in sh_size."
            self.real_num_sections = self.sh_size
        else:
            #print "less than 0xFF00 sections, yay"
            self.real_num_sections = self.e_shnum
        #print "real_num_sections", self.real_num_sections

        bin.seek(self.e_phoff,0)
        self.prog_hdr = {}
        #print 'e_phnum', self.e_phnum
        for i in range(self.e_phnum):
            #print "i check e_phnum", i
            self.prog_hdr[i] = {}
            if self.EI_CLASS == 0x01:
                self.prog_hdr[i]['p_type'] = struct.unpack(self.endian + "I", bin.read(4))[0]
                self.prog_hdr[i]['p_offset'] = struct.unpack(self.endian + "I", bin.read(4))[0]
                self.prog_hdr[i]['p_vaddr'] = struct.unpack(self.endian + "I", bin.read(4))[0]
                self.prog_hdr[i]['p_paddr'] = struct.unpack(self.endian + "I", bin.read(4))[0]
                self.prog_hdr[i]['p_filesz'] = struct.unpack(self.endian + "I", bin.read(4))[0]
                self.prog_hdr[i]['p_memsz'] = struct.unpack(self.endian + "I", bin.read(4))[0]
                self.prog_hdr[i]['p_flags'] = struct.unpack(self.endian + "I", bin.read(4))[0]
                self.prog_hdr[i]['p_align'] = struct.unpack(self.endian + "I", bin.read(4))[0]
            else:
                self.prog_hdr[i]['p_type'] = struct.unpack(self.endian + "I", bin.read(4))[0]
                self.prog_hdr[i]['p_flags'] = struct.unpack(self.endian + "I", bin.read(4))[0]
                self.prog_hdr[i]['p_offset'] = struct.unpack(self.endian + "Q", bin.read(8))[0]
                self.prog_hdr[i]['p_vaddr'] = struct.unpack(self.endian + "Q", bin.read(8))[0]
                self.prog_hdr[i]['p_paddr'] = struct.unpack(self.endian + "Q", bin.read(8))[0]
                self.prog_hdr[i]['p_filesz'] = struct.unpack(self.endian + "Q", bin.read(8))[0]
                self.prog_hdr[i]['p_memsz'] = struct.unpack(self.endian + "Q", bin.read(8))[0]
                self.prog_hdr[i]['p_align'] = struct.unpack(self.endian + "Q", bin.read(8))[0]
            if self.prog_hdr[i]['p_type'] == 0x1 and self.prog_hdr[i]['p_vaddr'] < self.e_entry:
                self.offset_addr = self.prog_hdr[i]['p_vaddr']
                self.LocOfEntryinCode = self.e_entry - self.offset_addr
                #print "found the entry offset"

        bin.seek(self.e_shoff, 0)
        self.sec_hdr = {}
        for i in range(self.e_shnum):
            self.sec_hdr[i] = {}
            if self.EI_CLASS == 0x01:
                self.sec_hdr[i]['sh_name'] = struct.unpack(self.endian + "I", bin.read(4))[0]
                #print self.sec_hdr[i]['sh_name']
                self.sec_hdr[i]['sh_type'] = struct.unpack(self.endian + "I", bin.read(4))[0]
                self.sec_hdr[i]['sh_flags'] = struct.unpack(self.endian + "I", bin.read(4))[0]
                self.sec_hdr[i]['sh_addr'] = struct.unpack(self.endian + "I", bin.read(4))[0]
                self.sec_hdr[i]['sh_offset'] = struct.unpack(self.endian + "I", bin.read(4))[0]
                self.sec_hdr[i]['sh_size'] = struct.unpack(self.endian + "I", bin.read(4))[0]
                self.sec_hdr[i]['sh_link'] = struct.unpack(self.endian + "I", bin.read(4))[0]
                self.sec_hdr[i]['sh_info'] = struct.unpack(self.endian + "I", bin.read(4))[0]
                self.sec_hdr[i]['sh_addralign'] = struct.unpack(self.endian + "I", bin.read(4))[0]
                self.sec_hdr[i]['sh_entsize'] = struct.unpack(self.endian + "I", bin.read(4))[0]
            else:
                self.sec_hdr[i]['sh_name'] = struct.unpack(self.endian + "I", bin.read(4))[0]
                self.sec_hdr[i]['sh_type'] = struct.unpack(self.endian + "I", bin.read(4))[0]
                self.sec_hdr[i]['sh_flags'] = struct.unpack(self.endian + "Q", bin.read(8))[0]
                self.sec_hdr[i]['sh_addr'] = struct.unpack(self.endian + "Q", bin.read(8))[0]
                self.sec_hdr[i]['sh_offset'] = struct.unpack(self.endian + "Q", bin.read(8))[0]
                self.sec_hdr[i]['sh_size'] = struct.unpack(self.endian + "Q", bin.read(8))[0]
                self.sec_hdr[i]['sh_link'] = struct.unpack(self.endian + "I", bin.read(4))[0]
                self.sec_hdr[i]['sh_info'] = struct.unpack(self.endian + "I", bin.read(4))[0]
                self.sec_hdr[i]['sh_addralign'] = struct.unpack(self.endian + "Q", bin.read(8))[0]
                self.sec_hdr[i]['sh_entsize'] = struct.unpack(self.endian + "Q", bin.read(8))[0]
        #bin.seek(self.sec_hdr'][self.e_shstrndx']]['sh_offset'], 0)
        self.set_section_name()
        if self.e_type != 0x2:
            print "[!] Only supporting executable elf e_types, things may get wierd."
