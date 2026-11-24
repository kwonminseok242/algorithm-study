N = int(input())

arr = list(map(int, input().split()))

reverse_arr = arr[::-1]

for i in reverse_arr:
    if i % 2 == 0:
        print(i, end=' ')

