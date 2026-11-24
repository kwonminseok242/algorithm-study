N = int(input())

arr = list(map(int,input().split()))

arr_cnt = [0 for _ in range(0,9)]

for i in arr:
    arr_cnt[i-1] +=1

for i in arr_cnt:
    print(i)

