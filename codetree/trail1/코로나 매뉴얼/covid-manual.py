sick0, temp0 = input().split()
sick1, temp1 = input().split()
sick2, temp2 = input().split()

list_all = []
list_all.append(sick0)
list_all.append(sick1)
list_all.append(sick2)
list_all.append(int(temp0))
list_all.append(int(temp1))
list_all.append(int(temp2))

Count = 0

for i in range(0,3):
    if list_all[i] == 'Y' and list_all[i+3] >= 37:
        Count +=1

if Count >=2:
    print('E')
else:
    print('N')

