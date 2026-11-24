arr = list(map(int, input().split()))
arr_cnt = [0 for _ in range(10)]
for i in arr:
    if i == 0:
        break
    arr_cnt[i//10] += 1

for i in range(1,10):
    print(f"{i} - {arr_cnt[i]}")
