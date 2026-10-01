n = int(input())
price = list(map(int, input().split()))

# Please write your code here.
max = 0

for i in range(n-1):
    for j in range(i+1,n):
        if max < price[j] - price[i]:
            max = price[j] - price[i]
print(max)

