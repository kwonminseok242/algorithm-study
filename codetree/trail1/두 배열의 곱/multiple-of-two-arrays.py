arr = []

for i in range(7):
    a = list(map(int,input().split()))
    arr.append(a)

answer = [[0 for i in range(3)] for j in range(3)]
for i in range(3):
    for j in range(3):
        b = arr[i][j]*arr[i+4][j]
        answer[i][j] = b

for i in answer:
    print(*i)


    