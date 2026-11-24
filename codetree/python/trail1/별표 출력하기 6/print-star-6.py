N = int(input())

for i in range(N,0,-1):
    for k in range(N-i):
        print(" ",end=' ')

    for j in range(2*i-1):
        print("*",end=' ') 
    print()

for i in range(2,N+1):
    for j in range(N-i):
        print(" ",end=' ')

    for k in range(2*i-1):
        print("*",end=' ')
    print()
    