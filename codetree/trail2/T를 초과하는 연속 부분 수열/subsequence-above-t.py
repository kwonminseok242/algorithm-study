n, t = map(int, input().split())
arr = list(map(int, input().split()))

# Please write your code here.

# cnt = 1
# count = []

# if n <= 1:
#     print(n)
# else:
#     cnt = 1
#     kk = []
#     for i in range(n - 1):
#         if arr[i+1] > arr[i] and arr[i] > t:
#             cnt += 1
#         else:
#             kk.append(cnt)
#             cnt = 1
# kk.append(cnt)


# print(max(kk))
best = cnt = 0
for x in arr:
    if x > t:
        cnt += 1
    else:
        cnt = 0
    best = max(best, cnt)
print(best)