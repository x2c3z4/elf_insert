
./hook_src/hookFs.o:     file format elf32-i386


Disassembly of section .text:

00000000 <read_ebp>:
   0:	55                   	push   ebp
   1:	89 e5                	mov    ebp,esp
   3:	89 e8                	mov    eax,ebp
   5:	89 ec                	mov    esp,ebp
   7:	5d                   	pop    ebp
   8:	c3                   	ret    
   9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

00000010 <pathcmp>:
  10:	55                   	push   ebp
  11:	89 e5                	mov    ebp,esp
  13:	83 ec 0c             	sub    esp,0xc
  16:	57                   	push   edi
  17:	31 ff                	xor    edi,edi
  19:	56                   	push   esi
  1a:	8b 75 0c             	mov    esi,DWORD PTR [ebp+0xc]
  1d:	53                   	push   ebx
  1e:	8b 5d 08             	mov    ebx,DWORD PTR [ebp+0x8]
  21:	83 ec 0c             	sub    esp,0xc
  24:	53                   	push   ebx
  25:	e8 fc ff ff ff       	call   26 <pathcmp+0x16>
  2a:	83 c4 10             	add    esp,0x10
  2d:	80 7c 18 ff 2f       	cmp    BYTE PTR [eax+ebx*1-0x1],0x2f
  32:	74 2e                	je     62 <pathcmp+0x52>
  34:	83 ec 0c             	sub    esp,0xc
  37:	53                   	push   ebx
  38:	e8 fc ff ff ff       	call   39 <pathcmp+0x29>
  3d:	83 c4 10             	add    esp,0x10
  40:	83 ec 0c             	sub    esp,0xc
  43:	c6 04 18 2f          	mov    BYTE PTR [eax+ebx*1],0x2f
  47:	53                   	push   ebx
  48:	e8 fc ff ff ff       	call   49 <pathcmp+0x39>
  4d:	c6 44 18 01 00       	mov    BYTE PTR [eax+ebx*1+0x1],0x0
  52:	eb 0e                	jmp    62 <pathcmp+0x52>
  54:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
  5a:	8d bf 00 00 00 00    	lea    edi,[edi+0x0]
  60:	43                   	inc    ebx
  61:	46                   	inc    esi
  62:	80 3b 00             	cmp    BYTE PTR [ebx],0x0
  65:	74 0e                	je     75 <pathcmp+0x65>
  67:	31 d2                	xor    edx,edx
  69:	8a 13                	mov    dl,BYTE PTR [ebx]
  6b:	31 c0                	xor    eax,eax
  6d:	8a 06                	mov    al,BYTE PTR [esi]
  6f:	89 d7                	mov    edi,edx
  71:	29 c7                	sub    edi,eax
  73:	74 eb                	je     60 <pathcmp+0x50>
  75:	85 ff                	test   edi,edi
  77:	79 07                	jns    80 <pathcmp+0x70>
  79:	83 c8 ff             	or     eax,0xffffffff
  7c:	eb 14                	jmp    92 <pathcmp+0x82>
  7e:	89 f6                	mov    esi,esi
  80:	83 ff 00             	cmp    edi,0x0
  83:	7e 0b                	jle    90 <pathcmp+0x80>
  85:	b8 01 00 00 00       	mov    eax,0x1
  8a:	eb 06                	jmp    92 <pathcmp+0x82>
  8c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
  90:	31 c0                	xor    eax,eax
  92:	8d 65 e8             	lea    esp,[ebp-0x18]
  95:	5b                   	pop    ebx
  96:	5e                   	pop    esi
  97:	5f                   	pop    edi
  98:	89 ec                	mov    esp,ebp
  9a:	5d                   	pop    ebp
  9b:	c3                   	ret    
  9c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]

000000a0 <traverse>:
  a0:	55                   	push   ebp
  a1:	89 e5                	mov    ebp,esp
  a3:	81 ec ac 04 00 00    	sub    esp,0x4ac
  a9:	8d 85 66 fb ff ff    	lea    eax,[ebp-0x49a]
  af:	c6 45 fc 25          	mov    BYTE PTR [ebp-0x4],0x25
  b3:	57                   	push   edi
  b4:	8b 7d 0c             	mov    edi,DWORD PTR [ebp+0xc]
  b7:	56                   	push   esi
  b8:	89 85 5c fb ff ff    	mov    DWORD PTR [ebp-0x4a4],eax
  be:	53                   	push   ebx
  bf:	8b 5d 08             	mov    ebx,DWORD PTR [ebp+0x8]
  c2:	c6 45 fd 73          	mov    BYTE PTR [ebp-0x3],0x73
  c6:	c6 45 fe 00          	mov    BYTE PTR [ebp-0x2],0x0
  ca:	c6 85 66 fb ff ff 09 	mov    BYTE PTR [ebp-0x49a],0x9
  d1:	85 db                	test   ebx,ebx
  d3:	c6 40 01 00          	mov    BYTE PTR [eax+0x1],0x0
  d7:	c6 45 f8 0d          	mov    BYTE PTR [ebp-0x8],0xd
  db:	c6 45 f9 0a          	mov    BYTE PTR [ebp-0x7],0xa
  df:	c6 45 fa 00          	mov    BYTE PTR [ebp-0x6],0x0
  e3:	0f 84 f5 00 00 00    	je     1de <traverse+0x13e>
  e9:	8d 45 b8             	lea    eax,[ebp-0x48]
  ec:	8d b5 68 fb ff ff    	lea    esi,[ebp-0x498]
  f2:	89 85 60 fb ff ff    	mov    DWORD PTR [ebp-0x4a0],eax
  f8:	90                   	nop
  f9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
 100:	83 ec 08             	sub    esp,0x8
 103:	53                   	push   ebx
 104:	57                   	push   edi
 105:	e8 fc ff ff ff       	call   106 <traverse+0x66>
 10a:	83 c4 10             	add    esp,0x10
 10d:	85 c0                	test   eax,eax
 10f:	74 15                	je     126 <traverse+0x86>
 111:	83 ec 08             	sub    esp,0x8
 114:	57                   	push   edi
 115:	53                   	push   ebx
 116:	e8 fc ff ff ff       	call   117 <traverse+0x77>
 11b:	83 c4 10             	add    esp,0x10
 11e:	85 c0                	test   eax,eax
 120:	0f 85 aa 00 00 00    	jne    1d0 <traverse+0x130>
 126:	83 ec 04             	sub    esp,0x4
 129:	8b 85 60 fb ff ff    	mov    eax,DWORD PTR [ebp-0x4a0]
 12f:	6a 40                	push   0x40
 131:	6a 00                	push   0x0
 133:	50                   	push   eax
 134:	e8 fc ff ff ff       	call   135 <traverse+0x95>
 139:	83 c4 10             	add    esp,0x10
 13c:	83 ec 04             	sub    esp,0x4
 13f:	68 50 04 00 00       	push   0x450
 144:	6a 00                	push   0x0
 146:	56                   	push   esi
 147:	e8 fc ff ff ff       	call   148 <traverse+0xa8>
 14c:	83 c4 10             	add    esp,0x10
 14f:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
 152:	83 ec 08             	sub    esp,0x8
 155:	50                   	push   eax
 156:	56                   	push   esi
 157:	e8 fc ff ff ff       	call   158 <traverse+0xb8>
 15c:	83 c4 10             	add    esp,0x10
 15f:	8b 85 5c fb ff ff    	mov    eax,DWORD PTR [ebp-0x4a4]
 165:	83 ec 08             	sub    esp,0x8
 168:	50                   	push   eax
 169:	56                   	push   esi
 16a:	e8 fc ff ff ff       	call   16b <traverse+0xcb>
 16f:	83 c4 10             	add    esp,0x10
 172:	83 ec 08             	sub    esp,0x8
 175:	57                   	push   edi
 176:	56                   	push   esi
 177:	e8 fc ff ff ff       	call   178 <traverse+0xd8>
 17c:	83 c4 10             	add    esp,0x10
 17f:	8d 85 66 fb ff ff    	lea    eax,[ebp-0x49a]
 185:	83 ec 08             	sub    esp,0x8
 188:	50                   	push   eax
 189:	56                   	push   esi
 18a:	e8 fc ff ff ff       	call   18b <traverse+0xeb>
 18f:	83 c4 10             	add    esp,0x10
 192:	8b 85 60 fb ff ff    	mov    eax,DWORD PTR [ebp-0x4a0]
 198:	83 ec 08             	sub    esp,0x8
 19b:	50                   	push   eax
 19c:	56                   	push   esi
 19d:	e8 fc ff ff ff       	call   19e <traverse+0xfe>
 1a2:	83 c4 10             	add    esp,0x10
 1a5:	8d 45 f8             	lea    eax,[ebp-0x8]
 1a8:	83 ec 08             	sub    esp,0x8
 1ab:	50                   	push   eax
 1ac:	56                   	push   esi
 1ad:	e8 fc ff ff ff       	call   1ae <traverse+0x10e>
 1b2:	83 c4 10             	add    esp,0x10
 1b5:	8d 45 fc             	lea    eax,[ebp-0x4]
 1b8:	83 ec 08             	sub    esp,0x8
 1bb:	56                   	push   esi
 1bc:	50                   	push   eax
 1bd:	e8 fc ff ff ff       	call   1be <traverse+0x11e>
 1c2:	eb 1a                	jmp    1de <traverse+0x13e>
 1c4:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
 1ca:	8d bf 00 00 00 00    	lea    edi,[edi+0x0]
 1d0:	8b 9b 00 04 00 00    	mov    ebx,DWORD PTR [ebx+0x400]
 1d6:	85 db                	test   ebx,ebx
 1d8:	0f 85 22 ff ff ff    	jne    100 <traverse+0x60>
 1de:	8d a5 48 fb ff ff    	lea    esp,[ebp-0x4b8]
 1e4:	5b                   	pop    ebx
 1e5:	5e                   	pop    esi
 1e6:	5f                   	pop    edi
 1e7:	89 ec                	mov    esp,ebp
 1e9:	5d                   	pop    ebp
 1ea:	c3                   	ret    
 1eb:	68 6f 6f 6b 5f       	push   0x5f6b6f6f
 1f0:	64 6f                	outs   dx,DWORD PTR fs:[esi]
 1f2:	73 46                	jae    23a <hook_dosFsOpen+0x3a>
 1f4:	73 4f                	jae    245 <hook_dosFsOpen+0x45>
 1f6:	70 65                	jo     25d <hook_dosFsOpen+0x5d>
 1f8:	6e                   	outs   dx,BYTE PTR ds:[esi]
 1f9:	00 8d b6 00 00 00    	add    BYTE PTR [ebp+0xb6],cl
	...

00000200 <hook_dosFsOpen>:
 200:	55                   	push   ebp
 201:	a1 00 00 00 00       	mov    eax,ds:0x0
 206:	89 e5                	mov    ebp,esp
 208:	81 ec 10 04 00 00    	sub    esp,0x410
 20e:	85 c0                	test   eax,eax
 210:	56                   	push   esi
 211:	53                   	push   ebx
 212:	74 49                	je     25d <hook_dosFsOpen+0x5d>
 214:	8b b0 00 04 00 00    	mov    esi,DWORD PTR [eax+0x400]
 21a:	85 f6                	test   esi,esi
 21c:	74 3f                	je     25d <hook_dosFsOpen+0x5d>
 21e:	83 ec 04             	sub    esp,0x4
 221:	8d 9d 00 fc ff ff    	lea    ebx,[ebp-0x400]
 227:	68 00 04 00 00       	push   0x400
 22c:	6a 00                	push   0x0
 22e:	53                   	push   ebx
 22f:	e8 fc ff ff ff       	call   230 <hook_dosFsOpen+0x30>
 234:	83 c4 10             	add    esp,0x10
 237:	e8 fc ff ff ff       	call   238 <hook_dosFsOpen+0x38>
 23c:	83 ec 08             	sub    esp,0x8
 23f:	8b 00                	mov    eax,DWORD PTR [eax]
 241:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
 244:	52                   	push   edx
 245:	53                   	push   ebx
 246:	e8 fc ff ff ff       	call   247 <hook_dosFsOpen+0x47>
 24b:	83 c4 10             	add    esp,0x10
 24e:	83 ec 04             	sub    esp,0x4
 251:	68 eb 01 00 00       	push   0x1eb
 256:	53                   	push   ebx
 257:	56                   	push   esi
 258:	e8 fc ff ff ff       	call   259 <hook_dosFsOpen+0x59>
 25d:	8d a5 e8 fb ff ff    	lea    esp,[ebp-0x418]
 263:	5b                   	pop    ebx
 264:	5e                   	pop    esi
 265:	89 ec                	mov    esp,ebp
 267:	5d                   	pop    ebp
 268:	c3                   	ret    
 269:	68 6f 6f 6b 5f       	push   0x5f6b6f6f
 26e:	64 6f                	outs   dx,DWORD PTR fs:[esi]
 270:	73 46                	jae    2b8 <hook_dosFsCreate+0x38>
 272:	73 43                	jae    2b7 <hook_dosFsCreate+0x37>
 274:	72 65                	jb     2db <hook_dosFsCreate+0x5b>
 276:	61                   	popa   
 277:	74 65                	je     2de <hook_dosFsCreate+0x5e>
 279:	00 8d b6 00 00 00    	add    BYTE PTR [ebp+0xb6],cl
	...

00000280 <hook_dosFsCreate>:
 280:	55                   	push   ebp
 281:	a1 00 00 00 00       	mov    eax,ds:0x0
 286:	89 e5                	mov    ebp,esp
 288:	81 ec 10 04 00 00    	sub    esp,0x410
 28e:	85 c0                	test   eax,eax
 290:	56                   	push   esi
 291:	53                   	push   ebx
 292:	74 49                	je     2dd <hook_dosFsCreate+0x5d>
 294:	8b b0 00 04 00 00    	mov    esi,DWORD PTR [eax+0x400]
 29a:	85 f6                	test   esi,esi
 29c:	74 3f                	je     2dd <hook_dosFsCreate+0x5d>
 29e:	83 ec 04             	sub    esp,0x4
 2a1:	8d 9d 00 fc ff ff    	lea    ebx,[ebp-0x400]
 2a7:	68 00 04 00 00       	push   0x400
 2ac:	6a 00                	push   0x0
 2ae:	53                   	push   ebx
 2af:	e8 fc ff ff ff       	call   2b0 <hook_dosFsCreate+0x30>
 2b4:	83 c4 10             	add    esp,0x10
 2b7:	e8 fc ff ff ff       	call   2b8 <hook_dosFsCreate+0x38>
 2bc:	83 ec 08             	sub    esp,0x8
 2bf:	8b 00                	mov    eax,DWORD PTR [eax]
 2c1:	8b 50 10             	mov    edx,DWORD PTR [eax+0x10]
 2c4:	52                   	push   edx
 2c5:	53                   	push   ebx
 2c6:	e8 fc ff ff ff       	call   2c7 <hook_dosFsCreate+0x47>
 2cb:	83 c4 10             	add    esp,0x10
 2ce:	83 ec 04             	sub    esp,0x4
 2d1:	68 69 02 00 00       	push   0x269
 2d6:	53                   	push   ebx
 2d7:	56                   	push   esi
 2d8:	e8 fc ff ff ff       	call   2d9 <hook_dosFsCreate+0x59>
 2dd:	8d a5 e8 fb ff ff    	lea    esp,[ebp-0x418]
 2e3:	5b                   	pop    ebx
 2e4:	5e                   	pop    esi
 2e5:	89 ec                	mov    esp,ebp
 2e7:	5d                   	pop    ebp
 2e8:	c3                   	ret    
 2e9:	68 6f 6f 6b 5f       	push   0x5f6b6f6f
 2ee:	64 6f                	outs   dx,DWORD PTR fs:[esi]
 2f0:	73 46                	jae    338 <hook_dosFsRead+0x38>
 2f2:	73 52                	jae    346 <hook_dosFsRead+0x46>
 2f4:	65                   	gs
 2f5:	61                   	popa   
 2f6:	64 00 90 8d b4 26 00 	add    BYTE PTR fs:[eax+0x26b48d],dl
 2fd:	00 00                	add    BYTE PTR [eax],al
	...

00000300 <hook_dosFsRead>:
 300:	55                   	push   ebp
 301:	a1 00 00 00 00       	mov    eax,ds:0x0
 306:	89 e5                	mov    ebp,esp
 308:	81 ec 0c 04 00 00    	sub    esp,0x40c
 30e:	85 c0                	test   eax,eax
 310:	57                   	push   edi
 311:	56                   	push   esi
 312:	53                   	push   ebx
 313:	74 62                	je     377 <hook_dosFsRead+0x77>
 315:	8b b8 00 04 00 00    	mov    edi,DWORD PTR [eax+0x400]
 31b:	85 ff                	test   edi,edi
 31d:	74 58                	je     377 <hook_dosFsRead+0x77>
 31f:	83 ec 04             	sub    esp,0x4
 322:	8d b5 00 fc ff ff    	lea    esi,[ebp-0x400]
 328:	68 00 04 00 00       	push   0x400
 32d:	6a 00                	push   0x0
 32f:	56                   	push   esi
 330:	e8 fc ff ff ff       	call   331 <hook_dosFsRead+0x31>
 335:	83 c4 10             	add    esp,0x10
 338:	e8 fc ff ff ff       	call   339 <hook_dosFsRead+0x39>
 33d:	e8 fc ff ff ff       	call   33e <hook_dosFsRead+0x3e>
 342:	83 ec 0c             	sub    esp,0xc
 345:	8b 58 08             	mov    ebx,DWORD PTR [eax+0x8]
 348:	53                   	push   ebx
 349:	e8 fc ff ff ff       	call   34a <hook_dosFsRead+0x4a>
 34e:	8b 03                	mov    eax,DWORD PTR [ebx]
 350:	83 c4 10             	add    esp,0x10
 353:	83 ec 08             	sub    esp,0x8
 356:	8b 40 78             	mov    eax,DWORD PTR [eax+0x78]
 359:	05 f0 00 00 00       	add    eax,0xf0
 35e:	50                   	push   eax
 35f:	56                   	push   esi
 360:	e8 fc ff ff ff       	call   361 <hook_dosFsRead+0x61>
 365:	83 c4 10             	add    esp,0x10
 368:	83 ec 04             	sub    esp,0x4
 36b:	68 e9 02 00 00       	push   0x2e9
 370:	56                   	push   esi
 371:	57                   	push   edi
 372:	e8 fc ff ff ff       	call   373 <hook_dosFsRead+0x73>
 377:	8d a5 e8 fb ff ff    	lea    esp,[ebp-0x418]
 37d:	5b                   	pop    ebx
 37e:	5e                   	pop    esi
 37f:	5f                   	pop    edi
 380:	89 ec                	mov    esp,ebp
 382:	5d                   	pop    ebp
 383:	c3                   	ret    
 384:	68 6f 6f 6b 5f       	push   0x5f6b6f6f
 389:	64 6f                	outs   dx,DWORD PTR fs:[esi]
 38b:	73 46                	jae    3d3 <hook_dosFsWrite+0x33>
 38d:	73 57                	jae    3e6 <hook_dosFsWrite+0x46>
 38f:	72 69                	jb     3fa <hook_dosFsWrite+0x5a>
 391:	74 65                	je     3f8 <hook_dosFsWrite+0x58>
 393:	00 8d b6 00 00 00    	add    BYTE PTR [ebp+0xb6],cl
 399:	00 8d bf 00 00 00    	add    BYTE PTR [ebp+0xbf],cl
	...

000003a0 <hook_dosFsWrite>:
 3a0:	55                   	push   ebp
 3a1:	a1 00 00 00 00       	mov    eax,ds:0x0
 3a6:	89 e5                	mov    ebp,esp
 3a8:	81 ec 0c 04 00 00    	sub    esp,0x40c
 3ae:	85 c0                	test   eax,eax
 3b0:	57                   	push   edi
 3b1:	56                   	push   esi
 3b2:	53                   	push   ebx
 3b3:	74 62                	je     417 <hook_dosFsWrite+0x77>
 3b5:	8b b8 00 04 00 00    	mov    edi,DWORD PTR [eax+0x400]
 3bb:	85 ff                	test   edi,edi
 3bd:	74 58                	je     417 <hook_dosFsWrite+0x77>
 3bf:	83 ec 04             	sub    esp,0x4
 3c2:	8d b5 00 fc ff ff    	lea    esi,[ebp-0x400]
 3c8:	68 00 04 00 00       	push   0x400
 3cd:	6a 00                	push   0x0
 3cf:	56                   	push   esi
 3d0:	e8 fc ff ff ff       	call   3d1 <hook_dosFsWrite+0x31>
 3d5:	83 c4 10             	add    esp,0x10
 3d8:	e8 fc ff ff ff       	call   3d9 <hook_dosFsWrite+0x39>
 3dd:	e8 fc ff ff ff       	call   3de <hook_dosFsWrite+0x3e>
 3e2:	83 ec 0c             	sub    esp,0xc
 3e5:	8b 58 08             	mov    ebx,DWORD PTR [eax+0x8]
 3e8:	53                   	push   ebx
 3e9:	e8 fc ff ff ff       	call   3ea <hook_dosFsWrite+0x4a>
 3ee:	8b 03                	mov    eax,DWORD PTR [ebx]
 3f0:	83 c4 10             	add    esp,0x10
 3f3:	83 ec 08             	sub    esp,0x8
 3f6:	8b 40 78             	mov    eax,DWORD PTR [eax+0x78]
 3f9:	05 f0 00 00 00       	add    eax,0xf0
 3fe:	50                   	push   eax
 3ff:	56                   	push   esi
 400:	e8 fc ff ff ff       	call   401 <hook_dosFsWrite+0x61>
 405:	83 c4 10             	add    esp,0x10
 408:	83 ec 04             	sub    esp,0x4
 40b:	68 84 03 00 00       	push   0x384
 410:	56                   	push   esi
 411:	57                   	push   edi
 412:	e8 fc ff ff ff       	call   413 <hook_dosFsWrite+0x73>
 417:	8d a5 e8 fb ff ff    	lea    esp,[ebp-0x418]
 41d:	5b                   	pop    ebx
 41e:	5e                   	pop    esi
 41f:	5f                   	pop    edi
 420:	89 ec                	mov    esp,ebp
 422:	5d                   	pop    ebp
 423:	c3                   	ret    
 424:	68 6f 6f 6b 5f       	push   0x5f6b6f6f
 429:	64 6f                	outs   dx,DWORD PTR fs:[esi]
 42b:	73 46                	jae    473 <hook_dosFsClose+0x33>
 42d:	73 43                	jae    472 <hook_dosFsClose+0x32>
 42f:	6c                   	ins    BYTE PTR es:[edi],dx
 430:	6f                   	outs   dx,DWORD PTR ds:[esi]
 431:	73 65                	jae    498 <hook_dosFsClose+0x58>
 433:	00 8d b6 00 00 00    	add    BYTE PTR [ebp+0xb6],cl
 439:	00 8d bf 00 00 00    	add    BYTE PTR [ebp+0xbf],cl
	...

00000440 <hook_dosFsClose>:
 440:	55                   	push   ebp
 441:	a1 00 00 00 00       	mov    eax,ds:0x0
 446:	89 e5                	mov    ebp,esp
 448:	81 ec 0c 04 00 00    	sub    esp,0x40c
 44e:	85 c0                	test   eax,eax
 450:	57                   	push   edi
 451:	56                   	push   esi
 452:	53                   	push   ebx
 453:	74 5f                	je     4b4 <hook_dosFsClose+0x74>
 455:	8b b8 00 04 00 00    	mov    edi,DWORD PTR [eax+0x400]
 45b:	85 ff                	test   edi,edi
 45d:	74 55                	je     4b4 <hook_dosFsClose+0x74>
 45f:	83 ec 04             	sub    esp,0x4
 462:	8d b5 00 fc ff ff    	lea    esi,[ebp-0x400]
 468:	68 00 04 00 00       	push   0x400
 46d:	6a 00                	push   0x0
 46f:	56                   	push   esi
 470:	e8 fc ff ff ff       	call   471 <hook_dosFsClose+0x31>
 475:	83 c4 10             	add    esp,0x10
 478:	e8 fc ff ff ff       	call   479 <hook_dosFsClose+0x39>
 47d:	83 ec 0c             	sub    esp,0xc
 480:	8b 00                	mov    eax,DWORD PTR [eax]
 482:	8b 58 08             	mov    ebx,DWORD PTR [eax+0x8]
 485:	53                   	push   ebx
 486:	e8 fc ff ff ff       	call   487 <hook_dosFsClose+0x47>
 48b:	8b 03                	mov    eax,DWORD PTR [ebx]
 48d:	83 c4 10             	add    esp,0x10
 490:	83 ec 08             	sub    esp,0x8
 493:	8b 40 78             	mov    eax,DWORD PTR [eax+0x78]
 496:	05 f0 00 00 00       	add    eax,0xf0
 49b:	50                   	push   eax
 49c:	56                   	push   esi
 49d:	e8 fc ff ff ff       	call   49e <hook_dosFsClose+0x5e>
 4a2:	83 c4 10             	add    esp,0x10
 4a5:	83 ec 04             	sub    esp,0x4
 4a8:	68 24 04 00 00       	push   0x424
 4ad:	56                   	push   esi
 4ae:	57                   	push   edi
 4af:	e8 fc ff ff ff       	call   4b0 <hook_dosFsClose+0x70>
 4b4:	8d a5 e8 fb ff ff    	lea    esp,[ebp-0x418]
 4ba:	5b                   	pop    ebx
 4bb:	5e                   	pop    esi
 4bc:	5f                   	pop    edi
 4bd:	89 ec                	mov    esp,ebp
 4bf:	5d                   	pop    ebp
 4c0:	c3                   	ret    
 4c1:	68 6f 6f 6b 5f       	push   0x5f6b6f6f
 4c6:	64 6f                	outs   dx,DWORD PTR fs:[esi]
 4c8:	73 46                	jae    510 <hook_dosFsDelete+0x30>
 4ca:	73 44                	jae    510 <hook_dosFsDelete+0x30>
 4cc:	65                   	gs
 4cd:	6c                   	ins    BYTE PTR es:[edi],dx
 4ce:	65                   	gs
 4cf:	74 65                	je     536 <hook_dosFsDelete+0x56>
 4d1:	00 8d b4 26 00 00    	add    BYTE PTR [ebp+0x26b4],cl
 4d7:	00 00                	add    BYTE PTR [eax],al
 4d9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

000004e0 <hook_dosFsDelete>:
 4e0:	55                   	push   ebp
 4e1:	a1 00 00 00 00       	mov    eax,ds:0x0
 4e6:	89 e5                	mov    ebp,esp
 4e8:	81 ec 10 04 00 00    	sub    esp,0x410
 4ee:	85 c0                	test   eax,eax
 4f0:	56                   	push   esi
 4f1:	53                   	push   ebx
 4f2:	74 4c                	je     540 <hook_dosFsDelete+0x60>
 4f4:	8b b0 00 04 00 00    	mov    esi,DWORD PTR [eax+0x400]
 4fa:	85 f6                	test   esi,esi
 4fc:	74 42                	je     540 <hook_dosFsDelete+0x60>
 4fe:	83 ec 04             	sub    esp,0x4
 501:	8d 9d 00 fc ff ff    	lea    ebx,[ebp-0x400]
 507:	68 00 04 00 00       	push   0x400
 50c:	6a 00                	push   0x0
 50e:	53                   	push   ebx
 50f:	e8 fc ff ff ff       	call   510 <hook_dosFsDelete+0x30>
 514:	83 c4 10             	add    esp,0x10
 517:	e8 fc ff ff ff       	call   518 <hook_dosFsDelete+0x38>
 51c:	e8 fc ff ff ff       	call   51d <hook_dosFsDelete+0x3d>
 521:	83 ec 08             	sub    esp,0x8
 524:	8b 50 08             	mov    edx,DWORD PTR [eax+0x8]
 527:	52                   	push   edx
 528:	53                   	push   ebx
 529:	e8 fc ff ff ff       	call   52a <hook_dosFsDelete+0x4a>
 52e:	83 c4 10             	add    esp,0x10
 531:	83 ec 04             	sub    esp,0x4
 534:	68 c1 04 00 00       	push   0x4c1
 539:	53                   	push   ebx
 53a:	56                   	push   esi
 53b:	e8 fc ff ff ff       	call   53c <hook_dosFsDelete+0x5c>
 540:	8d a5 e8 fb ff ff    	lea    esp,[ebp-0x418]
 546:	5b                   	pop    ebx
 547:	5e                   	pop    esi
 548:	89 ec                	mov    esp,ebp
 54a:	5d                   	pop    ebp
 54b:	c3                   	ret    
