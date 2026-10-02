n = int(input())
answer = [
    [0 for _ in range(n)]
    for _ in range(n)
]
cnt = 1
for i in range(n):
    sum = 3
    for j in range(n):
        answer[i][j] += cnt+n*j
    cnt +=1

for i in answer:
    print(*i)


