N = int(input())

for i in range(N): 
    if i % 2 == 0:
        for j in range(N):
            print(j + 1, end="")
    else:
        for j in range(0,N):
            print(N - j, end="")
    print()
