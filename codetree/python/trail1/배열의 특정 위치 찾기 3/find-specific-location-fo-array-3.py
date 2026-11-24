arr = list(map(int, input().split()))

for i in range(len(arr)):
    if arr[i] == 0:
        idx = i
        break

print(arr[idx - 1] + arr[idx - 2] + arr[idx - 3])