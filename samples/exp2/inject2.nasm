global _start
section .text
_start:
    push ebp
    mov ebp,esp
    and esp,0xfffffff0

    call foo 

    push 0x8048412
    ret

foo:
    push   ebp
    mov    ebp,esp
    sub    esp,0x18
    push   0x316f6f66 ;foo1
    ;lea    eax,[esp]
    ;push   eax
    push   esp
    mov    eax,0x80482f0
    call   eax
    leave
    ret
