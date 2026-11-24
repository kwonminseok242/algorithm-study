N = int(input())
cnt = 1
cnt1 = N
for i in range(N):
    for j in range(N):
        if j%2 == 0:
            print(cnt,end='')
        else:
            print(cnt1,end='')
            
    cnt1-=1
    cnt+=1
    print()