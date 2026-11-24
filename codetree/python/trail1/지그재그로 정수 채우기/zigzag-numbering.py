n, m = map(int, input().split())

# n = 4, m = 2
answer = [[0 for _ in range(m)] for _ in range(n)]


num = 0
for i in range(m):
    if i % 2 == 0:
        for j in range(n):
            answer[j][i] = num
            num += 1
    else:
        for j in range(n - 1, -1, -1):
            answer[j][i] = num
            num += 1

# 출력
for row in answer:
    for elem in row:
        print(elem, end=" ")
    print()
