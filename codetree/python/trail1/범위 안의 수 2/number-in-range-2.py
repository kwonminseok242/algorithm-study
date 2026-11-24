sum_val = 0
cnt = 0
for i in range(10):
    j = int(input())
    if j>=0 and j<=200:
        sum_val +=j
        cnt += 1

print(f"{sum_val} {sum_val/cnt:.1f}")