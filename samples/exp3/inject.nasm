global _start
section .text
_start:
    push ebp
    mov ebp,esp
    sub    esp,0x38
    call foo 
    push 0x314536
    ret

foo:
    push   ebp
    mov    ebp,esp
    sub    esp,0x18
    push   0x316f6f66 ;foo1
    ;lea    eax,[esp]
    ;push   eax
    push   esp
    ;mov    eax,0x00384b80 ;printf addr
    mov    eax,0x003b7de0 ;exit addr
    call   eax
    leave
    ret
