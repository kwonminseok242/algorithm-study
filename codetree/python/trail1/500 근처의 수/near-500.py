arr = list(map(int,input().split()))

arr500down = []
arr500up = []

for i in arr:
    if i < 500:
        arr500down.append(i)
    else:
        arr500up.append(i)
    
print(max(arr500down),min(arr500up))