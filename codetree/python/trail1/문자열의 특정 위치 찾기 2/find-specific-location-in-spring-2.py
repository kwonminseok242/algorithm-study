ex = input()

exes = ['apple','banana','grape','blueberry','orange']
cnt = 0
for i in exes:
    if ex == i[2] or ex == i[3]:
        cnt+=1
        print(i)

print(cnt)
