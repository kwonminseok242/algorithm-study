N = int(input())
cnt = 0
for i in range(N,0,-1):
    for k in range(N-i):
        print(" ",end=" ")
    
    for j in range(i):
        print(chr(ord('A') + cnt), end=' ')
        if cnt == 25:
            cnt = 0
            continue
        cnt += 1

    print()
