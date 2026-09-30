N = int(input())
cnt = 1
for i in range(1,N+1): 
    for j in range(i):
        print(cnt, end=" ")
        cnt+=1
    print()
