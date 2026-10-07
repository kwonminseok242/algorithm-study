y = int(input())

def condition(y):
    # 400의 배수이거나, (4의 배수이면서 100의 배수가 아닌 경우)
    if (y % 4 == 0 and y % 100 != 0) or (y % 400 == 0):
        return True
    return False

if condition(y):
    print('true')
else:
    print('false')