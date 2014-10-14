str='foo1'
str = str + '\x00' * ((4-len(str)%4)%4)
print "C:"
print '\tprintf("foo1");'
print "assmble:"
for i in range(len(str)-4,-1,-4):
  print '\t push %s ;%s'%(hex(ord(str[i])|ord(str[i+1])<<8|ord(str[i+2])<<16|ord(str[i+3])<<24),str[i:i+4])
print '\t push name'
print '\t push path'
print '\t push [esp+8]'
