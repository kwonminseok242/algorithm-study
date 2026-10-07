a, b = map(int, input().split())

# Please write your code here.

def sosu_condition(i):
    cnt = 0
    for j in range(1,i+1):
        if i % j == 0:
            cnt +=1
    if cnt == 2:
        return True
    else:
        return False

def even_numver(i):
    ex = str(i)
    if len(ex) == 2:
        ex0 = ex[0]
        ex1 = ex[1]
        if (int(ex0)+int(ex1))%2 == 0:
            return True
    elif ex == '100':
        ex0 = ex[0]
        ex1 = ex[1]
        ex2 = ex[2]
        if (int(ex0)+int(ex1)+int(ex2))%2 == 0:
            return True
    else:
        ex0 = ex[0]
        if int(ex0)%2 == 0:
            return True
    return False
cnt = 0
for i in range(a,b+1):
    if sosu_condition(i) and even_numver(i):
        cnt+=1
print(cnt)


