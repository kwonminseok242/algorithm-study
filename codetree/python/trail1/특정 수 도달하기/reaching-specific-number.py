arr = list(map(int,input().split()))

sum = 0
cnt = 0
for i in arr:
    if i >= 250:
        break
    cnt+=1
    sum += i

print(f"{sum} {sum/cnt:.1f}")