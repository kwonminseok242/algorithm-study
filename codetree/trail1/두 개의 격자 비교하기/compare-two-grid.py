N, M = map(int,input().split())

arr = []

for i in range(N*2):
    a = list(map(int,input().split()))
    arr.append(a)

answer = [[0 for i in range(M)] for j in range(N)]
for i in range(N):
    for j in range(M):
        if arr[i][j] == arr[i+N][j]:
            answer[i][j] = 0
        else:
            answer[i][j] = 1

for i in answer:
    print(*i)
