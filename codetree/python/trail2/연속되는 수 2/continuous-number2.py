n = int(input())
arr = [int(input()) for _ in range(n)]

# Please write your code here.
cnt = 0
ex = arr[0]
maz = []
for i in arr:
    if ex == i:
        cnt+=1
    else:
        maz.append(cnt)
        cnt = 1
        ex = i
maz.append(cnt) 
if len(maz) == 0:
    print('1')
else:
    print(max(maz))

