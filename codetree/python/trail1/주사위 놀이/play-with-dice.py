arr = list(map(int, input().split()))

arr_cnt = [0 for _ in range(6)]

for i in arr:
    arr_cnt[i-1] += 1

cnt = 1
for i in arr_cnt:
    print(f"{cnt} - {i}")
    cnt +=1