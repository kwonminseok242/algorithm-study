import sys, io
sys.stdin = io.StringIO("""6
3
1 1 2 2 3 3""")

n = int(input())
k = int(input())
flower = list(map(int, input().split()))   # 한 줄에 n개

cnt = 0
cnt = 0
for i in range(1, n):
    if flower[i] == flower[i - 1]:
        for c in range(1, 4):
            if c != flower[i - 1] and (i + 1 >= n or c != flower[i + 1]):
                flower[i] = c
                cnt += 1
                break

print(cnt)



