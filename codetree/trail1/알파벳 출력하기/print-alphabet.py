N = int(input())
cnt = 0
for i in range(1,N+1):
    for j in range(i):
        print(chr(ord('A') +cnt), end='')
        if cnt == 25:
            cnt = 0
            continue
        cnt +=1
    print()
