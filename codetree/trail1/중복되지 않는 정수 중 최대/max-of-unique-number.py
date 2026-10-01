n = int(input())
nums = list(map(int, input().split()))

# Please write your code here.
answer = [0 for _ in range(1001)]
for i in nums:
    answer[i] +=1
max = -1
for i in range(1,1001):
    if answer[i] == 1:
        if max <= i:
            max = i



print(max)
