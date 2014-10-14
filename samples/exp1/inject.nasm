global _start
section .text
_start:
    push ebp
    mov ebp,esp
    and esp,0xfffffff0
    mov eax,0x804844c
    call eax
    push 0x8048466
    ret
