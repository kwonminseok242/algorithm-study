n = int(input())
A = list(map(int, input().split()))
B = list(map(int, input().split()))

# Please write your code here.
a = True
for i in A:
    if i in B:
        continue
    else:
        a = False
        print('No')
        break

if a == True:
    print('Yes')