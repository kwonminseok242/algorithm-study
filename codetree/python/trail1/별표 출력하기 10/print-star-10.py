N = int(input())
cnt1 = N+1
cnt2 = 0
for i in range(1,N*2+1):
    if i % 2 == 0: # 2, 4, 6, 8, 10
        cnt1 -= 1
        for j in range(cnt1):
            print("*", end=" ")
        print()
    else: # 1, 3, 5, 7,9
        cnt2 +=1
        for _ in range(cnt2):
            print("*", end=" ")
        print()
