N = int(input())

arr = map(str,input().split())
cnt = 0
ex = ''
for i in arr:
    ex += i

for i in ex:
    cnt +=1
    if cnt %5 ==0:
        print(i,end='')
        print()
    else:
        print(i,end='')


