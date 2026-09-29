N = int(input())

cnt = 1
for i in range(N): 
    for j in range(N):
        print(cnt, end="")
        if cnt == 9:
            cnt = 0
        cnt += 1
    print()
