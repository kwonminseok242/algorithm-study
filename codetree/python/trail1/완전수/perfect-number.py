start, end = map(int, input().split())

# Please write your code here.
cnt = 0
for i in range(start, end +1):
    arr = []
    for j in range(1,i):
        if i % j == 0:
            arr.append(j)
    if i == sum(arr):
        cnt +=1
    else:
        continue

print(cnt)
