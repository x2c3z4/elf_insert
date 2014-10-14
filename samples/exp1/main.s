
main:     file format elf32-i386


Disassembly of section .init:

080482e0 <_init>:
 80482e0: 55                    push   %ebp
 80482e1: 89 e5                 mov    %esp,%ebp
 80482e3: 53                    push   %ebx
 80482e4: 83 ec 04              sub    $0x4,%esp
 80482e7: e8 00 00 00 00        call   80482ec <_init+0xc>
 80482ec: 5b                    pop    %ebx
 80482ed: 81 c3 d0 13 00 00     add    $0x13d0,%ebx
 80482f3: 8b 93 fc ff ff ff     mov    -0x4(%ebx),%edx
 80482f9: 85 d2                 test   %edx,%edx
 80482fb: 74 05                 je     8048302 <_init+0x22>
 80482fd: e8 3e 00 00 00        call   8048340 <__gmon_start__@plt>
 8048302: 58                    pop    %eax
 8048303: 5b                    pop    %ebx
 8048304: c9                    leave  
 8048305: c3                    ret    

Disassembly of section .plt:

08048310 <printf@plt-0x10>:
 8048310: ff 35 c0 96 04 08     pushl  0x80496c0
 8048316: ff 25 c4 96 04 08     jmp    *0x80496c4
 804831c: 00 00                 add    %al,(%eax)
  ...

08048320 <printf@plt>:
 8048320: ff 25 c8 96 04 08     jmp    *0x80496c8
 8048326: 68 00 00 00 00        push   $0x0
 804832b: e9 e0 ff ff ff        jmp    8048310 <_init+0x30>

08048330 <puts@plt>:
 8048330: ff 25 cc 96 04 08     jmp    *0x80496cc
 8048336: 68 08 00 00 00        push   $0x8
 804833b: e9 d0 ff ff ff        jmp    8048310 <_init+0x30>

08048340 <__gmon_start__@plt>:
 8048340: ff 25 d0 96 04 08     jmp    *0x80496d0
 8048346: 68 10 00 00 00        push   $0x10
 804834b: e9 c0 ff ff ff        jmp    8048310 <_init+0x30>

08048350 <__libc_start_main@plt>:
 8048350: ff 25 d4 96 04 08     jmp    *0x80496d4
 8048356: 68 18 00 00 00        push   $0x18
 804835b: e9 b0 ff ff ff        jmp    8048310 <_init+0x30>

Disassembly of section .text:

08048360 <_start>:
 8048360: 31 ed                 xor    %ebp,%ebp
 8048362: 5e                    pop    %esi
 8048363: 89 e1                 mov    %esp,%ecx
 8048365: 83 e4 f0              and    $0xfffffff0,%esp
 8048368: 50                    push   %eax
 8048369: 54                    push   %esp
 804836a: 52                    push   %edx
 804836b: 68 80 84 04 08        push   $0x8048480
 8048370: 68 90 84 04 08        push   $0x8048490
 8048375: 51                    push   %ecx
 8048376: 56                    push   %esi
 8048377: 68 60 84 04 08        push   $0x8048460
 804837c: e8 cf ff ff ff        call   8048350 <__libc_start_main@plt>
 8048381: f4                    hlt    
 8048382: 90                    nop
 8048383: 90                    nop
 8048384: 90                    nop
 8048385: 90                    nop
 8048386: 90                    nop
 8048387: 90                    nop
 8048388: 90                    nop
 8048389: 90                    nop
 804838a: 90                    nop
 804838b: 90                    nop
 804838c: 90                    nop
 804838d: 90                    nop
 804838e: 90                    nop
 804838f: 90                    nop

08048390 <deregister_tm_clones>:
 8048390: b8 e3 96 04 08        mov    $0x80496e3,%eax
 8048395: 2d e0 96 04 08        sub    $0x80496e0,%eax
 804839a: 83 f8 06              cmp    $0x6,%eax
 804839d: 77 02                 ja     80483a1 <deregister_tm_clones+0x11>
 804839f: f3 c3                 repz ret 
 80483a1: b8 00 00 00 00        mov    $0x0,%eax
 80483a6: 85 c0                 test   %eax,%eax
 80483a8: 74 f5                 je     804839f <deregister_tm_clones+0xf>
 80483aa: 55                    push   %ebp
 80483ab: 89 e5                 mov    %esp,%ebp
 80483ad: 83 ec 18              sub    $0x18,%esp
 80483b0: c7 04 24 e0 96 04 08  movl   $0x80496e0,(%esp)
 80483b7: ff d0                 call   *%eax
 80483b9: c9                    leave  
 80483ba: c3                    ret    
 80483bb: 90                    nop
 80483bc: 8d 74 26 00           lea    0x0(%esi,%eiz,1),%esi

080483c0 <register_tm_clones>:
 80483c0: b8 e0 96 04 08        mov    $0x80496e0,%eax
 80483c5: 2d e0 96 04 08        sub    $0x80496e0,%eax
 80483ca: c1 f8 02              sar    $0x2,%eax
 80483cd: 89 c2                 mov    %eax,%edx
 80483cf: c1 ea 1f              shr    $0x1f,%edx
 80483d2: 01 d0                 add    %edx,%eax
 80483d4: d1 f8                 sar    %eax
 80483d6: 75 02                 jne    80483da <register_tm_clones+0x1a>
 80483d8: f3 c3                 repz ret 
 80483da: ba 00 00 00 00        mov    $0x0,%edx
 80483df: 85 d2                 test   %edx,%edx
 80483e1: 74 f5                 je     80483d8 <register_tm_clones+0x18>
 80483e3: 55                    push   %ebp
 80483e4: 89 e5                 mov    %esp,%ebp
 80483e6: 83 ec 18              sub    $0x18,%esp
 80483e9: 89 44 24 04           mov    %eax,0x4(%esp)
 80483ed: c7 04 24 e0 96 04 08  movl   $0x80496e0,(%esp)
 80483f4: ff d2                 call   *%edx
 80483f6: c9                    leave  
 80483f7: c3                    ret    
 80483f8: 90                    nop
 80483f9: 8d b4 26 00 00 00 00  lea    0x0(%esi,%eiz,1),%esi

08048400 <__do_global_dtors_aux>:
 8048400: 80 3d e0 96 04 08 00  cmpb   $0x0,0x80496e0
 8048407: 75 13                 jne    804841c <__do_global_dtors_aux+0x1c>
 8048409: 55                    push   %ebp
 804840a: 89 e5                 mov    %esp,%ebp
 804840c: 83 ec 08              sub    $0x8,%esp
 804840f: e8 7c ff ff ff        call   8048390 <deregister_tm_clones>
 8048414: c6 05 e0 96 04 08 01  movb   $0x1,0x80496e0
 804841b: c9                    leave  
 804841c: f3 c3                 repz ret 
 804841e: 66 90                 xchg   %ax,%ax

08048420 <frame_dummy>:
 8048420: a1 c4 95 04 08        mov    0x80495c4,%eax
 8048425: 85 c0                 test   %eax,%eax
 8048427: 74 1e                 je     8048447 <frame_dummy+0x27>
 8048429: b8 00 00 00 00        mov    $0x0,%eax
 804842e: 85 c0                 test   %eax,%eax
 8048430: 74 15                 je     8048447 <frame_dummy+0x27>
 8048432: 55                    push   %ebp
 8048433: 89 e5                 mov    %esp,%ebp
 8048435: 83 ec 18              sub    $0x18,%esp
 8048438: c7 04 24 c4 95 04 08  movl   $0x80495c4,(%esp)
 804843f: ff d0                 call   *%eax
 8048441: c9                    leave  
 8048442: e9 79 ff ff ff        jmp    80483c0 <register_tm_clones>
 8048447: e9 74 ff ff ff        jmp    80483c0 <register_tm_clones>

0804844c <test>:
 804844c: 55                    push   %ebp
 804844d: 89 e5                 mov    %esp,%ebp
 804844f: 83 ec 18              sub    $0x18,%esp
 8048452: c7 04 24 10 85 04 08  movl   $0x8048510,(%esp)
 8048459: e8 c2 fe ff ff        call   8048320 <printf@plt>
 804845e: c9                    leave  
 804845f: c3                    ret    

08048460 <main>:
 8048460: 55                    push   %ebp
 8048461: 89 e5                 mov    %esp,%ebp
 8048463: 83 e4 f0              and    $0xfffffff0,%esp
 8048466: 83 ec 10              sub    $0x10,%esp
 8048469: c7 04 24 15 85 04 08  movl   $0x8048515,(%esp)
 8048470: e8 bb fe ff ff        call   8048330 <puts@plt>
 8048475: c9                    leave  
 8048476: c3                    ret    
 8048477: 90                    nop
 8048478: 90                    nop
 8048479: 90                    nop
 804847a: 90                    nop
 804847b: 90                    nop
 804847c: 90                    nop
 804847d: 90                    nop
 804847e: 90                    nop
 804847f: 90                    nop

08048480 <__libc_csu_fini>:
 8048480: 55                    push   %ebp
 8048481: 89 e5                 mov    %esp,%ebp
 8048483: 5d                    pop    %ebp
 8048484: c3                    ret    
 8048485: 8d 74 26 00           lea    0x0(%esi,%eiz,1),%esi
 8048489: 8d bc 27 00 00 00 00  lea    0x0(%edi,%eiz,1),%edi

08048490 <__libc_csu_init>:
 8048490: 55                    push   %ebp
 8048491: 89 e5                 mov    %esp,%ebp
 8048493: 57                    push   %edi
 8048494: 56                    push   %esi
 8048495: 53                    push   %ebx
 8048496: e8 4f 00 00 00        call   80484ea <__i686.get_pc_thunk.bx>
 804849b: 81 c3 21 12 00 00     add    $0x1221,%ebx
 80484a1: 83 ec 1c              sub    $0x1c,%esp
 80484a4: e8 37 fe ff ff        call   80482e0 <_init>
 80484a9: 8d bb 04 ff ff ff     lea    -0xfc(%ebx),%edi
 80484af: 8d 83 00 ff ff ff     lea    -0x100(%ebx),%eax
 80484b5: 29 c7                 sub    %eax,%edi
 80484b7: c1 ff 02              sar    $0x2,%edi
 80484ba: 85 ff                 test   %edi,%edi
 80484bc: 74 24                 je     80484e2 <__libc_csu_init+0x52>
 80484be: 31 f6                 xor    %esi,%esi
 80484c0: 8b 45 10              mov    0x10(%ebp),%eax
 80484c3: 89 44 24 08           mov    %eax,0x8(%esp)
 80484c7: 8b 45 0c              mov    0xc(%ebp),%eax
 80484ca: 89 44 24 04           mov    %eax,0x4(%esp)
 80484ce: 8b 45 08              mov    0x8(%ebp),%eax
 80484d1: 89 04 24              mov    %eax,(%esp)
 80484d4: ff 94 b3 00 ff ff ff  call   *-0x100(%ebx,%esi,4)
 80484db: 83 c6 01              add    $0x1,%esi
 80484de: 39 fe                 cmp    %edi,%esi
 80484e0: 72 de                 jb     80484c0 <__libc_csu_init+0x30>
 80484e2: 83 c4 1c              add    $0x1c,%esp
 80484e5: 5b                    pop    %ebx
 80484e6: 5e                    pop    %esi
 80484e7: 5f                    pop    %edi
 80484e8: 5d                    pop    %ebp
 80484e9: c3                    ret    

080484ea <__i686.get_pc_thunk.bx>:
 80484ea: 8b 1c 24              mov    (%esp),%ebx
 80484ed: c3                    ret    
 80484ee: 90                    nop
 80484ef: 90                    nop

Disassembly of section .fini:

080484f0 <_fini>:
 80484f0: 55                    push   %ebp
 80484f1: 89 e5                 mov    %esp,%ebp
 80484f3: 53                    push   %ebx
 80484f4: 83 ec 04              sub    $0x4,%esp
 80484f7: e8 00 00 00 00        call   80484fc <_fini+0xc>
 80484fc: 5b                    pop    %ebx
 80484fd: 81 c3 c0 11 00 00     add    $0x11c0,%ebx
 8048503: 59                    pop    %ecx
 8048504: 5b                    pop    %ebx
 8048505: c9                    leave  
 8048506: c3                    ret    
