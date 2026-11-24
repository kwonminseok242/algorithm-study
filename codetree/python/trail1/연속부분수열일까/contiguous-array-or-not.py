N1, N2 = map(int,input().split())

arrN1 = list(map(int,input().split()))
arrN2 = list(map(int,input().split()))
answer = 0
for i in range(0,len(arrN1)+1):
    for j in range(1,len(arrN1)+1):
        if arrN2 == arrN1[i:j]:
            answer = 1
            break
        if answer == 1:
            break

if answer == 1:
    print('Yes')
else:
    print('No')

            
