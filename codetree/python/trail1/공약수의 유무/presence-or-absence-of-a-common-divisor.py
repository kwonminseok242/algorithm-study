A, B = map(int, input().split())

it = False
for i in range(A, B+1):
    if 1920%i == 0 and 2880%i == 0 or 1920%i==0 and 2880%i==0:
        it = True
        break

if it == True:
    print('1')
else:
    print('0')