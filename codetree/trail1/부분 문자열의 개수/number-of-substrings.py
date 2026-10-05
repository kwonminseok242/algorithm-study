A = input()
B = input()
cnt = 0
for i in range(0,len(A)-1):
    if B == A[i:i+2]:
        cnt +=1

print(cnt)