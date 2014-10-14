1. elfbin.py
===========
elfbin.py 包含基本的elf解析，如section，program headers...

2. elf_helper.py
================
包含使用readelf和objdump的一个辅助函数，使用例子如下：

```
$ python elf_helper.py test/foo.o test/main
[*] Gathering file info
[!] Only supporting executable elf e_types, things may get wierd.
[{'name': 'puts', 'offset': 14}]
{'<foo>': {'opcode': '\\x55\\x89\\xe5\\x83\\xec\\x18\\xc7\\x04\\x24\\x00\\x00\\x00\\x00\\xe8\\xfc\\xff\\xff\\xff\\xc9\\xc3', 'offset': 0}}
14->0x80482e0

fix:0xfffffffc->0x80482e0

{'<foo>': {'opcode': '\\x55\\x89\\xe5\\x83\\xec\\x18\\xc7\\x04\\x24\\x00\\x00\\x00\\x00\\xe8\\xe0\\x82\\x04\\x08\\xc9\\xc3', 'offset': 0}}
```

输入参数分别为o文件，和elf可执行文件。

```
[{'name': 'puts', 'offset': 14}]
```

这行输出显示o文件的需要重定位的符号信息。

后面一行为o文件里的函数信息。

再下面是将o文件里的puts符号的位置填上解析出的值，这个值从elf里获得。

最后一行展示patch完elf后text段的结果，可以发现elf的修改成功了。

