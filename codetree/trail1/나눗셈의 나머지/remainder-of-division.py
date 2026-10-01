A, B = map(int,input().split())
arr = []
while A > 1:
    arr.append(A%B)
    A = A//B

arr_cnt = [0 for _ in range(10)]
for i in arr:
    arr_cnt[i] += 1
sum = 0
for i in range(0,10):
    if arr_cnt[i] != 0:
        sum += arr_cnt[i]**2

print(sum)

    
