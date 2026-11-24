n1, n2 = map(int, input().split())
a = list(map(int, input().split()))
b = list(map(int, input().split()))

# Please write your code here.

ans = 'No'

if n1 >= n2:
    for i in range(n1-n2+1):
        if a[i:i+n2] == b:
            ans='Yes'
            break
    print(ans)
else:
    print(ans)