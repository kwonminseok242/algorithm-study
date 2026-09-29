N = int(input())
cnt = 1
for i in range(N): 
    if i % 2 == 0:
        for j in range(N):
            print(cnt, end=" ")
            cnt +=1
        cnt += N-1
            
    else:
        
        for j in range(N):
            print(cnt, end=" ")
            cnt -=1
        cnt += N+1
    

    print()


