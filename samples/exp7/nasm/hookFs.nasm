
./hook_src/hookFs.o-i386


Disassembly of section .text:

read_ebp:
   	push   ebp
   	mov    ebp,esp
   	mov    eax,ebp
   	mov    esp,ebp
   	pop    ebp
   	ret    
   	lea    esi,[esi+0x0]

pathcmp:
  	push   ebp
  	mov    ebp,esp
  	sub    esp,0xc
  	push   edi
  	xor    edi,edi
  	push   esi
  	mov    esi,DWORD[ebp+0xc]
  	push   ebx
  	mov    ebx,DWORD[ebp+0x8]
  	sub    esp,0xc
  	push   ebx
  	call   0x26 
  	add    esp,0x10
  	cmp    BYTE[eax+ebx*1-0x1],0x2f
  	je     0x62 
  	sub    esp,0xc
  	push   ebx
  	call   0x39 
  	add    esp,0x10
  	sub    esp,0xc
  	mov    BYTE[eax+ebx*1],0x2f
  	push   ebx
  	call   0x49 
  	mov    BYTE[eax+ebx*1+0x1],0x0
  	jmp    0x62 
  	lea    esi,[esi+0x0]
  	lea    edi,[edi+0x0]
  	inc    ebx
  	inc    esi
  	cmp    BYTE[ebx],0x0
  	je     0x75 
  	xor    edx,edx
  	mov    dl,BYTE[ebx]
  	xor    eax,eax
  	mov    al,BYTE[esi]
  	mov    edi,edx
  	sub    edi,eax
  	je     0x60 
  	test   edi,edi
  	jns    80 
  	or     eax,0xffffffff
  	jmp    0x92 
  	mov    esi,esi
  	cmp    edi,0x0
  	jle    90 
  	mov    eax,0x1
  	jmp    0x92 
  	lea    esi,[esi+0x0]
  	xor    eax,eax
  	lea    esp,[ebp-0x18]
  	pop    ebx
  	pop    esi
  	pop    edi
  	mov    esp,ebp
  	pop    ebp
  	ret    
  	lea    esi,[esi+0x0]

traverse:
  	push   ebp
  	mov    ebp,esp
  	sub    esp,0x4ac
  	lea    eax,[ebp-0x49a]
  	mov    BYTE[ebp-0x4],0x25
  	push   edi
  	mov    edi,DWORD[ebp+0xc]
  	push   esi
  	mov    DWORD[ebp-0x4a4],eax
  	push   ebx
  	mov    ebx,DWORD[ebp+0x8]
  	mov    BYTE[ebp-0x3],0x73
  	mov    BYTE[ebp-0x2],0x0
  	mov    BYTE[ebp-0x49a],0x9
  	test   ebx,ebx
  	mov    BYTE[eax+0x1],0x0
  	mov    BYTE[ebp-0x8],0xd
  	mov    BYTE[ebp-0x7],0xa
  	mov    BYTE[ebp-0x6],0x0
  	je     0x1de 
  	lea    eax,[ebp-0x48]
  	lea    esi,[ebp-0x498]
  	mov    DWORD[ebp-0x4a0],eax
  	nop
  	lea    esi,[esi+0x0]
 	sub    esp,0x8
 	push   ebx
 	push   edi
 	call   0x106 
 	add    esp,0x10
 	test   eax,eax
 	je     0x126 
 	sub    esp,0x8
 	push   edi
 	push   ebx
 	call   0x117 
 	add    esp,0x10
 	test   eax,eax
 	jne    0x1d0 
 	sub    esp,0x4
 	mov    eax,DWORD[ebp-0x4a0]
 	push   0x40
 	push   0x0
 	push   eax
 	call   0x135 
 	add    esp,0x10
 	sub    esp,0x4
 	push   0x450
 	push   0x0
 	push   esi
 	call   0x148 
 	add    esp,0x10
 	mov    eax,DWORD[ebp+0x10]
 	sub    esp,0x8
 	push   eax
 	push   esi
 	call   0x158 
 	add    esp,0x10
 	mov    eax,DWORD[ebp-0x4a4]
 	sub    esp,0x8
 	push   eax
 	push   esi
 	call   0x16b 
 	add    esp,0x10
 	sub    esp,0x8
 	push   edi
 	push   esi
 	call   0x178 
 	add    esp,0x10
 	lea    eax,[ebp-0x49a]
 	sub    esp,0x8
 	push   eax
 	push   esi
 	call   0x18b 
 	add    esp,0x10
 	mov    eax,DWORD[ebp-0x4a0]
 	sub    esp,0x8
 	push   eax
 	push   esi
 	call   0x19e 
 	add    esp,0x10
 	lea    eax,[ebp-0x8]
 	sub    esp,0x8
 	push   eax
 	push   esi
 	call   0x1ae 
 	add    esp,0x10
 	lea    eax,[ebp-0x4]
 	sub    esp,0x8
 	push   esi
 	push   eax
 	call   0x1be 
 	jmp    0x1de 
 	lea    esi,[esi+0x0]
 	lea    edi,[edi+0x0]
 	mov    ebx,DWORD[ebx+0x400]
 	test   ebx,ebx
 	jne    0x100 
 	lea    esp,[ebp-0x4b8]
 	pop    ebx
 	pop    esi
 	pop    edi
 	mov    esp,ebp
 	pop    ebp
 	ret    
 	push   0x5f6b6f6f
 	outs   dx,DWORDfs:[esi]
 	jae    23a 
 	jae    245 
 	jo     25d 
 	add    BYTE[ebp+0xb6],cl
	...

hook_dosFsOpen:
 	push   ebp
 	mov    ebp,esp
 	sub    esp,0x410
 	test   eax,eax
 	push   esi
 	push   ebx
 	je     0x25d 
 	mov    esi,DWORD[eax+0x400]
 	test   esi,esi
 	je     0x25d 
 	sub    esp,0x4
 	lea    ebx,[ebp-0x400]
 	push   0x400
 	push   0x0
 	push   ebx
 	call   0x230 
 	add    esp,0x10
 	call   0x238 
 	sub    esp,0x8
 	mov    eax,DWORD[eax]
 	mov    edx,DWORD[eax+0x10]
 	push   edx
 	push   ebx
 	call   0x247 
 	add    esp,0x10
 	sub    esp,0x4
 	push   0x1eb
 	push   ebx
 	push   esi
 	call   0x259 
 	lea    esp,[ebp-0x418]
 	pop    ebx
 	pop    esi
 	mov    esp,ebp
 	pop    ebp
 	ret    
 	push   0x5f6b6f6f
 	outs   dx,DWORDfs:[esi]
 	jae    2b8 
 	jae    2b7 
 	jb     2db 
 	popa   
 	je     0x2de 
 	add    BYTE[ebp+0xb6],cl
	...

hook_dosFsCreate:
 	push   ebp
 	mov    ebp,esp
 	sub    esp,0x410
 	test   eax,eax
 	push   esi
 	push   ebx
 	je     0x2dd 
 	mov    esi,DWORD[eax+0x400]
 	test   esi,esi
 	je     0x2dd 
 	sub    esp,0x4
 	lea    ebx,[ebp-0x400]
 	push   0x400
 	push   0x0
 	push   ebx
 	call   0x2b0 
 	add    esp,0x10
 	call   0x2b8 
 	sub    esp,0x8
 	mov    eax,DWORD[eax]
 	mov    edx,DWORD[eax+0x10]
 	push   edx
 	push   ebx
 	call   0x2c7 
 	add    esp,0x10
 	sub    esp,0x4
 	push   0x269
 	push   ebx
 	push   esi
 	call   0x2d9 
 	lea    esp,[ebp-0x418]
 	pop    ebx
 	pop    esi
 	mov    esp,ebp
 	pop    ebp
 	ret    
 	push   0x5f6b6f6f
 	outs   dx,DWORDfs:[esi]
 	jae    338 
 	jae    346 
 	gs
 	popa   
 	add    BYTEfs:[eax+0x26b48d],dl
 	add    BYTE[eax],al
	...

hook_dosFsRead:
 	push   ebp
 	mov    ebp,esp
 	sub    esp,0x40c
 	test   eax,eax
 	push   edi
 	push   esi
 	push   ebx
 	je     0x377 
 	mov    edi,DWORD[eax+0x400]
 	test   edi,edi
 	je     0x377 
 	sub    esp,0x4
 	lea    esi,[ebp-0x400]
 	push   0x400
 	push   0x0
 	push   esi
 	call   0x331 
 	add    esp,0x10
 	call   0x339 
 	call   0x33e 
 	sub    esp,0xc
 	mov    ebx,DWORD[eax+0x8]
 	push   ebx
 	call   0x34a 
 	mov    eax,DWORD[ebx]
 	add    esp,0x10
 	sub    esp,0x8
 	mov    eax,DWORD[eax+0x78]
 	add    eax,0xf0
 	push   eax
 	push   esi
 	call   0x361 
 	add    esp,0x10
 	sub    esp,0x4
 	push   0x2e9
 	push   esi
 	push   edi
 	call   0x373 
 	lea    esp,[ebp-0x418]
 	pop    ebx
 	pop    esi
 	pop    edi
 	mov    esp,ebp
 	pop    ebp
 	ret    
 	push   0x5f6b6f6f
 	outs   dx,DWORDfs:[esi]
 	jae    3d3 
 	jae    3e6 
 	jb     3fa 
 	je     0x3f8 
 	add    BYTE[ebp+0xb6],cl
 	add    BYTE[ebp+0xbf],cl
	...

hook_dosFsWrite:
 	push   ebp
 	mov    ebp,esp
 	sub    esp,0x40c
 	test   eax,eax
 	push   edi
 	push   esi
 	push   ebx
 	je     0x417 
 	mov    edi,DWORD[eax+0x400]
 	test   edi,edi
 	je     0x417 
 	sub    esp,0x4
 	lea    esi,[ebp-0x400]
 	push   0x400
 	push   0x0
 	push   esi
 	call   0x3d1 
 	add    esp,0x10
 	call   0x3d9 
 	call   0x3de 
 	sub    esp,0xc
 	mov    ebx,DWORD[eax+0x8]
 	push   ebx
 	call   0x3ea 
 	mov    eax,DWORD[ebx]
 	add    esp,0x10
 	sub    esp,0x8
 	mov    eax,DWORD[eax+0x78]
 	add    eax,0xf0
 	push   eax
 	push   esi
 	call   0x401 
 	add    esp,0x10
 	sub    esp,0x4
 	push   0x384
 	push   esi
 	push   edi
 	call   0x413 
 	lea    esp,[ebp-0x418]
 	pop    ebx
 	pop    esi
 	pop    edi
 	mov    esp,ebp
 	pop    ebp
 	ret    
 	push   0x5f6b6f6f
 	outs   dx,DWORDfs:[esi]
 	jae    473 
 	jae    472 
 	ins    BYTEes:[edi],dx
 	jae    498 
 	add    BYTE[ebp+0xb6],cl
 	add    BYTE[ebp+0xbf],cl
	...

hook_dosFsClose:
 	push   ebp
 	mov    ebp,esp
 	sub    esp,0x40c
 	test   eax,eax
 	push   edi
 	push   esi
 	push   ebx
 	je     0x4b4 
 	mov    edi,DWORD[eax+0x400]
 	test   edi,edi
 	je     0x4b4 
 	sub    esp,0x4
 	lea    esi,[ebp-0x400]
 	push   0x400
 	push   0x0
 	push   esi
 	call   0x471 
 	add    esp,0x10
 	call   0x479 
 	sub    esp,0xc
 	mov    eax,DWORD[eax]
 	mov    ebx,DWORD[eax+0x8]
 	push   ebx
 	call   0x487 
 	mov    eax,DWORD[ebx]
 	add    esp,0x10
 	sub    esp,0x8
 	mov    eax,DWORD[eax+0x78]
 	add    eax,0xf0
 	push   eax
 	push   esi
 	call   0x49e 
 	add    esp,0x10
 	sub    esp,0x4
 	push   0x424
 	push   esi
 	push   edi
 	call   0x4b0 
 	lea    esp,[ebp-0x418]
 	pop    ebx
 	pop    esi
 	pop    edi
 	mov    esp,ebp
 	pop    ebp
 	ret    
 	push   0x5f6b6f6f
 	outs   dx,DWORDfs:[esi]
 	jae    510 
 	jae    510 
 	gs
 	ins    BYTEes:[edi],dx
 	gs
 	je     0x536 
 	add    BYTE[ebp+0x26b4],cl
 	add    BYTE[eax],al
 	lea    edi,[edi+0x0]

hook_dosFsDelete:
 	push   ebp
 	mov    ebp,esp
 	sub    esp,0x410
 	test   eax,eax
 	push   esi
 	push   ebx
 	je     0x540 
 	mov    esi,DWORD[eax+0x400]
 	test   esi,esi
 	je     0x540 
 	sub    esp,0x4
 	lea    ebx,[ebp-0x400]
 	push   0x400
 	push   0x0
 	push   ebx
 	call   0x510 
 	add    esp,0x10
 	call   0x518 
 	call   0x51d 
 	sub    esp,0x8
 	mov    edx,DWORD[eax+0x8]
 	push   edx
 	push   ebx
 	call   0x52a 
 	add    esp,0x10
 	sub    esp,0x4
 	push   0x4c1
 	push   ebx
 	push   esi
 	call   0x53c 
 	lea    esp,[ebp-0x418]
 	pop    ebx
 	pop    esi
 	mov    esp,ebp
 	pop    ebp
 	ret    
_hook_dosFsOpen:
  push ebp
  mov ebp,esp
  sub esp,xxh

  call hook_dosFsOpen

  push xxxxxxh
  ret 

_hook_dosFsClose:
  push ebp
  mov ebp,esp
  sub esp,xxh

  call hook_dosFsClose

  push xxxxxxh
  ret 


_hook_dosFsCreate:
  push ebp
  mov ebp,esp
  sub esp,xxh

  call hook_dosFsCreate

  push xxxxxxh
  ret 


_hook_dosFsDelete:
  push ebp
  mov ebp,esp
  sub esp,xxh

  call hook_dosFsDelete

  push xxxxxxh
  ret 


_hook_dosFsRead:
  push ebp
  mov ebp,esp
  sub esp,xxh

  call hook_dosFsRead

  push xxxxxxh
  ret 


_hook_dosFsWrite:
  push ebp
  mov ebp,esp
  sub esp,xxh

  call hook_dosFsWrite

  push xxxxxxh
  ret 
