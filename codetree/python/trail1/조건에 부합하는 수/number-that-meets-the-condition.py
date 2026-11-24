n = int(input())
cnt = []
for i in range(1, n + 1):
    if i%2==0 and i%4!=0:
        continue
    elif (i//8)%2 ==0:
        continue
    elif i%7 < 4:
        continue
    else:
        cnt.append(i)
for i in cnt:
    print(i, end=' ')
        