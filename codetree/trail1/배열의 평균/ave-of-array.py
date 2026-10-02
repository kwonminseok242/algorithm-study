
arr = []

for i in range(2):
    a = list(map(int,input().split()))
    arr.append(a)

print(f"{sum(arr[0])/4:.1f} {sum(arr[1])/4:.1f}")


for j in range(4):
    sum = 0
    sum += arr[0][j] + arr[1][j]
    print(f"{sum/2:.1f}", end =' ')
print()

sum = 0
for i in range(2):
    for j in range(4):
        sum += arr[i][j]

print(f"{sum/8:.1f}")





