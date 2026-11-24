arr = list(map(int, input().split()))

arr.sort()


sum_val = 0
for i in range(arr[0], arr[1]+1):
    if i % 5 == 0:
        sum_val += i

print(sum_val)
