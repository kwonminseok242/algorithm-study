N = int(input())
cnt = 1
for i in range(N,0,-1):
    for k in range(N-i):
        print(" ",end =' ')
    for j in range(i):
        print(cnt, end=" ")
        cnt += 1
        if cnt > 9:
            cnt = 1
    print()
