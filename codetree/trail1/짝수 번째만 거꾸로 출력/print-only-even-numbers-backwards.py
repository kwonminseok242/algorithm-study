a = input()
arr = []


cnt = 1
for i in a:
    if cnt % 2 == 0:
        arr.append(i)
    cnt +=1

print(*arr[::-1], sep='')



