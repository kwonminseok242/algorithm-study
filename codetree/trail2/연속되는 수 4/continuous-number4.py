n = int(input())
arr = [int(input()) for _ in range(n)]

cnt = 0
count = []

# for i in range(0,len(arr)-1):

#     if (arr[i+1] - arr[i]) >= 1 :
#         cnt+=1
#     else:
#         count.append(cnt)
#         cnt = 1
# count.append(cnt)
# if len(arr) == 1:
#     print('1')
# else:
#     print(max(count))
if n <= 1:
    print(n)
else:
    cnt = 1
    max_cnt = 1
    for i in range(n - 1):
        if arr[i+1] > arr[i]:
            cnt += 1
        else:
            cnt = 1
        if cnt > max_cnt:
            max_cnt = cnt
    print(max_cnt)




