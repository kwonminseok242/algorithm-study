N = int(input())
cnt = 0
for i in range(N):
    if i % 2 == 0:
        for j in range(N):
            cnt +=1
            print(cnt, end=' ')

    else:
        for j in range(N):
            cnt+=2
            print(cnt,end=' ')
    print()
