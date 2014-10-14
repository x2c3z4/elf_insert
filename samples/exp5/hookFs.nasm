global _start
section .text
hook_dosFsOpen:
  push ebp
  mov ebp, esp
  sub esp,0x1c
  call __hook_dosFsOpen
  push 0x3739f6
  ret

read_ebp:
  push   ebp
  mov    ebp,esp
  mov    eax,ebp
  mov    esp,ebp
  pop    ebp
  ret    
 

__hook_dosFsOpen:
  push   ebp
  mov    ebp,esp
  sub    esp,0x8
  call   read_ebp
  sub    esp,0x4
  mov    eax,[eax]
  mov    edx,[eax+0x10]

  push 0x0
  push 0x0a
  push 0x73
  push 0x253a7325

  mov eax,esp
 
  push 0x00
  push 0x6e65706f
  mov ecx,esp

  push   edx
  push   ecx
  push   eax

  mov eax,384b80h
  call eax

  mov    esp,ebp
  pop    ebp
  ret    
