a = input()
e = int(input())
cnt = 0
for i in a[::-1]:
    print(i,end='')
    cnt +=1
    if cnt == e:
        break