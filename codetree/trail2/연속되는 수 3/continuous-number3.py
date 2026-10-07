N = int(input())
arr = [int(input()) for _ in range(N)]

# Please write your code here.
sign = []
for i in arr:
    if i < 0:
        sign.append('m')
    else:
        sign.append('p')
cnt = 0
count = []
ex = sign[0]

for i in sign:
    if ex == i:
        cnt+=1
    else:
        count.append(cnt)
        cnt = 1
        ex = i
count.append(cnt)
if len(count) == 0:
    print('1')
else:
    print(max(count))





