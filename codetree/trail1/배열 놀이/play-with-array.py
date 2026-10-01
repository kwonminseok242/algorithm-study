N, Q = map(int,input().split())

arr = list(map(int, input().split()))

for i in range(Q):
    arr1 = list(map(int,input().split()))
    if arr1[0] == 1:
        print(arr[arr1[1]-1])

    elif arr1[0] == 2:
        if arr1[1] not in arr:
            print('0')
        else:
            print(arr.index(arr1[1])+1)

    elif arr1[0] == 3:
        for i in range(arr1[1]-1,arr1[2]):
            print(arr[i],end=' ')
        print()
