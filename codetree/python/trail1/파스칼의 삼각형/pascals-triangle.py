N = int(input())

arr = [[0]*N for _ in range(N)]
cnt = 0
for i in range(N):
    arr[i][0] = 1
    arr[i][cnt] = 1
    cnt +=1

for i in range(2,N):
    for j in range(1,N):
        arr[i][j] = arr[i-1][j-1] + arr[i-1][j]
answer = []

for i in arr:
    k = []
    for j in i:
        if j != 0:
            k.append(j)
        else:
            continue
    answer.append(k)


for i in answer:
    print(*i)