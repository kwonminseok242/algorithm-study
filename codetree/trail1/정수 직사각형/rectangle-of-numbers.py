N, M = map(int,input().split())

arr = [[0 for _ in range(M)] for _ in range(N)]

k = 1
for i in range(N):
    for j in range(M):
        arr[i][j] = k
        k += 1

for i in arr:
    print(*i) 