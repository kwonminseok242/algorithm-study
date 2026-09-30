N = int(input())
result = []
for i in range(2,N+1):
    arr = []
    for j in range(1,i+1):
        if i % j == 0:
            arr.append(j)
    if len(arr) <= 2:
        result.append(i)
print(*result)
