import string

for i in range(5):
    arr = list(map(str,input().split())) # 26+
    for i in range(3):
        print(arr[i].upper(),end = ' ')
    print()