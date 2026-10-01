N = int(input())

arr = [1,N]
arr_1 = 0
arr_2 = 1
while True:
    if (arr[arr_1]+arr[arr_2]) >= 100:
        arr.append(arr[arr_1]+arr[arr_2])
        break
    else:
        arr.append(arr[arr_1]+arr[arr_2])
    arr_1 +=1
    arr_2 +=1

print(*arr)


