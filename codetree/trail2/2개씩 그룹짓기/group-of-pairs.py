n = int(input())
nums = list(map(int, input().split()))

# Please write your code here.
max_sum = 0
nums.sort()

for i in range(n):
    group_sum = nums[i] + nums[-(i+1)]
    if group_sum > max_sum:
        max_sum = group_sum

print(max_sum)
