N = int(input())

sum = 0
for i in range(N):
    ex = int(input())
    sum += ex
sum = str(sum)
sum = str(sum[1:]+sum[0])
print(sum)