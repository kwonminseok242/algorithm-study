n, s = input().split()
n = int(n)
cnt = 0
for i in range(n):
    ex = input()
    if ex == s:
        cnt +=1

print(cnt)