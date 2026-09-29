N = int(input())

cnt = 2
for i in range(N):
    for j in range(1,N+1):
        print(cnt,end=" ")
        if cnt == 8:
            cnt = 0
        cnt += 2

    print()