N = int(input())
for i in range(1,N+1):
    for j in range(1,N+2-i):
        print(f"{i} * {j} = {i*j}", end=" ")
        if j < N+1-i:
            print("/ ",end="")
    print()