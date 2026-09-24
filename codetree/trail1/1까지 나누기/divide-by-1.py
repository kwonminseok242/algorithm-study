N = int(input())
sum_val = 0
sum = N
for i in range(1, N+1):
    if sum <= 1:
        print(sum_val)
        break
    sum = sum // i
    sum_val +=1

