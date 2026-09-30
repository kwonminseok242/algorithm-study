A,B = map(int,input().split())

for i in range(1,10): 
    for j in range(B, A-1,-1):
        if j %2 == 0:
            print(f"{j} * {i} = {j * i}", end=" ")
        if j > A and j %2 == 0:
            print("/",end =" ")
    print()
