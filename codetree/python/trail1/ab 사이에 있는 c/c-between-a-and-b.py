a, b, c = map(int,input().split())
t = False
for i in range(a,b+1):
    if i%c == 0:
        t = True
        break

if t == False:
    print('NO')
else:
    print('YES')