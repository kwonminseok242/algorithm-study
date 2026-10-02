arr = []

for _ in range(4):
    a = list(map(int,input().split()))
    arr.append(a)

# [0,0]
# [1,0][1,2]
# [2,0][2,1][2,2]
# [3,0][3,1][3,2][3,3]
sum = 0
for i in range(4):
    for j in range(0,i+1):
        sum += arr[i][j]
        # print(f"arr[{i}][{j}] = {arr[i][j]}")

print(sum)
