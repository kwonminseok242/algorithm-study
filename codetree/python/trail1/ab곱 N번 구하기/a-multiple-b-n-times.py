N = int(input())

for i in range(N):
    sum = 1
    a,b = map(int,input().split())
    for j in range(a,b+1):
        # print(f'j는 {j}입니다.')
        sum *= j
    print(sum)