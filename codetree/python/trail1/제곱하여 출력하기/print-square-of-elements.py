N = int(input())

arr = list(map(int, input().split()))
arr_ = [i**2 for i in arr]

print(*arr_)