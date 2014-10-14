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
