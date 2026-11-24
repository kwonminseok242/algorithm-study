n, m = map(int, input().split())
answer = [[0] * m for _ in range(n)]

num = 1                                 # ⚠️ 이 문제는 1부터 시작
for d in range(n + m - 1):              # 대각선 번호 0, 1, 2, ...
    for i in range(n):                  # 행을 전부 시도해 보고
        j = d - i                       # ⭐ 짝이 되는 열
        if 0 <= j < m:                  # ⚠️ 격자 안일 때만
            answer[i][j] = num
            num += 1

for row in answer:
    print(*row)