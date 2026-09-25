N = int(input())

for i in range(2*N+1):
    for j in range(2*N+1):          # i와 똑같이 0부터
        if i % 2 == 0 or j % 2 == 0:
            print("*", end=" ")
        else:
            print(" ", end=" ")
    print()