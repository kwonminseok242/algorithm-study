arr = list(map(int,input().split()))
k = []
cnt = 0
for i in arr:
    if i == 0:
        break
    elif i % 2 == 0:
        k.append(i)
        cnt +=1

print(cnt, sum(k))