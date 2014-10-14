$ python main.py -f samples/exp5/vxWorks -I samples/exp5/hookFs.nasm
         Author:    Feng,Li
         Email:     lifeng1519@gmail.com

{'read_ebp': {'opcode': ['\\x55', '\\x89\\xe5', '\\x89\\xe8', '\\x89\\xec', '\\x5d', '\\xc3'], 'offset': '00000011'}, 'dosFsOpen': {'opcode': ['\\x55', '\\x89\\xe5', '\\x83\\xec\\x1c', '\\xe8\\x0f\\x00\\x00\\x00', '\\x68\\xf6\\x39\\x37\\x00', '\\xc3'], 'offset': '00000000'}, '__hook_dosFsOpen': {'opcode': ['\\x55', '\\x89\\xe5', '\\x83\\xec\\x08', '\\xe8\\xec\\xff\\xff\\xff', '\\x83\\xec\\x04', '\\x8b\\x00', '\\x8b\\x50\\x10', '\\x6a\\x00', '\\x6a\\x0a', '\\x6a\\x73', '\\x68\\x25\\x73\\x3a\\x25', '\\x89\\xe0', '\\x6a\\x00', '\\x68\\x6f\\x70\\x65\\x6e', '\\x89\\xe1', '\\x52', '\\x51', '\\x50', '\\xb8\\x80\\x4b\\x38\\x00', '\\xff\\xd0', '\\x89\\xec', '\\x5d', '\\xc3'], 'offset': '0000001a'}}
[*] Gathering file info
[*] Patching Binary
[+] Found text segment
[!] Patching Complete
[+] entry: 0x308000 inject_point: 0x3d6186 base offset: 0x307fa0
[+] prolog_instrument: 'push 0x3d6186\nret'
[+] injecting prolog: \x68\x86\x61\x3d\x00\xc3
[+] write:\x55\x89\xe5\x83\xec\x1c => \x68\x86\x61\x3d\x0\xc3

[+] func: dosFsOpen
          offset: 0x3739f0
          file_offset: 0x6ba50
          jmp_addr: 0x3d6186
[+] Done! Output: samples/exp5/vxWorks.patched
$ python main.py --help
         Author:    Feng,Li
         Email:     lifeng1519@gmail.com

Usage: main.py [options]

inject tool.-t -s -I,please choose one,but -I is the best

Options:
  -h, --help            show this help message and exit
  -f FILE, --file=FILE  [must] File to patch
  -t OBJECT_FILE, --object_file=OBJECT_FILE
                        Get text section and  add it to out file
  -s SHELLCODE, --shellcode=SHELLCODE
                        User supplied shellcode, place it in text section,make
                        sure that it matches the architecture that you are
                        targeting.
  -I INJECT_NASM_FILE, --inject_nasm_file=INJECT_NASM_FILE
                        nasm file to inject
  -o OUTPUT, --output-file=OUTPUT
                        The output file
  -i INJECT_INS, --inject_ins=INJECT_INS
                        [deprecated] inject instruction into func's prolog.use
                        --inject_nasm_file instead
  -F FUNC_NAME, --func_name=FUNC_NAME
                        [deprecated] where inject.using --inject_nasm_file
                        instead
  -v, --verbose         For debug information output.
