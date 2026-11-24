n = int(input())

if  n < 8 and n%2 != 0:
    print('31')
elif n>=8 and n%2 == 0:
    print('31')
elif n == 2:
    print('28')
else:
    print('30')

