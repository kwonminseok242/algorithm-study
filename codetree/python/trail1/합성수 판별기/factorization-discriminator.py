N = int(input())
a = False
for i in range(2,N):
    if N%i==0:
        a = True
        break

if a == True:
    print('C')
else:
    print('N')
        