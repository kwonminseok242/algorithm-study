N =int(input())
sum_val = 0
cnt = 0
for i in range(N):
    j = int(input())
    sum_val += j
    cnt +=1

print(f"{sum_val} {sum_val/cnt:.1f}")
