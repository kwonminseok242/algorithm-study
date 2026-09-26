N = int(input())

for i in range(1,N+1):
    for j in range(N):
        print(N*i-j*i,end=' ')
    print()