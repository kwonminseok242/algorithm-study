M, D = map(int, input().split())

# Please write your code here.
max = [1,3,5,7,8,10,12]
min = [4,6,9,11]
if M in max:
    if D <= 31:
        print('Yes')
    else:
        print('No')
elif M in min:
    if D <= 30:
        print('Yes')
    else:
        print('No')
elif M == 2:
    if D <= 28:
        print('Yes')
    else:
        print('No')
else:
    print('No')




