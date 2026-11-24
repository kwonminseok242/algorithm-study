N = int(input())
arr = list(map(int,input().split()))

cnt = 0
c = 0
while cnt < 3:
    if arr[c] == 2:
        cnt +=1
    c +=1

print(c)

     