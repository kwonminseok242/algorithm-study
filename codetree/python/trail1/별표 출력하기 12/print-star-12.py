N = int(input())

for i in range(1,N+1):
    for j in range(1,N+1):          # i와 똑같이 0부터
        if  i <= j and j%2==0 or i ==1 :
            print("*", end=" ")
        else:
            print(" ", end=" ")
    print()