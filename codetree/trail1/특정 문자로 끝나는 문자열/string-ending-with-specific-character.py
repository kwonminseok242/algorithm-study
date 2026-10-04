arr = [input() for _ in range(10)]
ex = input()
cnt = 0
for i in arr:
    if ex == i[-1]:
        print(i)
        cnt+=1
if cnt ==0:
    print('None')
