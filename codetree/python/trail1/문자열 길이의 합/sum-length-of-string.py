N = int(input())

arr = [input() for _ in range(N)]

cnt = 0
sum = 0
for i in arr:
    sum += len(i)
    if 'a' == i[0]:
        cnt+=1
print(f"{sum} {cnt}")