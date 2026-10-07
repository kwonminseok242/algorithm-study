Y, M, D = map(int, input().split())

# Please write your code here.
def condition(y):
    # 400의 배수이거나, (4의 배수이면서 100의 배수가 아닌 경우)
    if (y % 4 == 0 and y % 100 != 0) or (y % 400 == 0):
        return True
    return False

def is_reality(Y,M,D):
    max = [1,3,5,7,8,10,12]
    min = [4,6,9,11]
    if condition(Y):
        if M in max:
            if D <= 31:
                return True
            else:
                return False
        elif M in min:
            if D <= 30:
                return True
            else:
                return False
        elif M == 2:
            if D <= 29:
                return True
            else:
                return False
        else:
            return False
    else:
        if M in max:
            if D <= 31:
                return True
            else:
                return False
        elif M in min:
            if D <= 30:
                return True
            else:
                return False
        elif M == 2:
            if D <= 28:
                return True
            else:
                return False
        else:
            return False

if is_reality(Y,M,D):
    if 3 <= M <=5:
        print('Spring') 
    elif 6 <= M <= 8:
        print('Summer')
    elif 9 <= M <= 11:
        print('Fall')
    else:
        print('Winter')
else:
    print('-1')





