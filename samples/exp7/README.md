#what's here?
##AIM
- hook 6 fs functions.
- printf time and path only. 

##FILES
###create-nasm

####It can:
- a shell script,used to create nasm file from hookFs.o file.
- the script first disassemble the .o file and modify the nasm file to suitable format
- then patch 6 proxy

####It cannot:
- the script cannot delete the spare instructions after ret within each function.
- cannot relocate 


###hook_src
- hookFs.c .o and .h

###nasm
- proxy.nasm : includes 6 proxy

- hookFs0.nasm : from objdump -d, not modified
- hookFs.nasm : created by create-nasm

- test.nasm : spare instructions(after ret) deleted manually. It can be used by genshellcode.py. But not relocated.
