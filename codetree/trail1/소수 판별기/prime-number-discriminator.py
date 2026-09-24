N = int(input())

satificat = True

for i in range(2, N):
    if N%i==0:
        satificat = False
        break

if satificat == True:
    print('P')
else:
    print('C')