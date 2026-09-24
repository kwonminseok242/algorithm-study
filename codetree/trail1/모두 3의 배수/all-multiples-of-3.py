satificate = True
for _ in range(5):
    n = int(input())
    if n%3 !=0:
        satificate = False
        break

if satificate == True:
    print('1')
else:
    print('0')
