n = int(input())
a = list(map(int, input().split()))

# Please write your code here.

while len(a) >= 1 :
    print(a.index(max(a))+1,end=' ')
    a = a[:a.index(max(a))]


