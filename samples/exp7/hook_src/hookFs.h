#define DECLAR_HOOK_FS(name) \
  void hookFs##name()

DECLAR_HOOK_FS(Open);
DECLAR_HOOK_FS(Create);
DECLAR_HOOK_FS(Read);
DECLAR_HOOK_FS(Write);
DECLAR_HOOK_FS(Close);
DECLAR_HOOK_FS(Delete);
