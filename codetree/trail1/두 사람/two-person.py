age, gender = input().split()
age2, gender2 = input().split()

if int(age) >= 19 and gender == 'M' or int(age2)>=19 and gender2 == 'M':
    print('1')
else:
    print('0')