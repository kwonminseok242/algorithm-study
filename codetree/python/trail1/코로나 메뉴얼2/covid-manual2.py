arr = [0 for i in range(4)]
for i in range(3):
    answer, temp = input().split()
    if answer == 'Y' and int(temp) >= 37:
        arr[0] += 1
    elif answer == 'N' and int(temp) >= 37:
        arr[1] += 1
    elif answer == 'Y' and int(temp) < 37:
        arr[2] +=1
    else:
        arr[3] +=1


for i in arr:
    print(i,end=' ')


if arr[0] >= 2:
    print('E')

