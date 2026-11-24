N, M = map(int,input().split())

arr = [[0]*N for _ in range(N)]
cnt = 1
for i in range(M):
    a,b = map(int,input().split())
    arr[a-1][b-1] = cnt
    cnt += 1

for i in arr:
    print(*i)
