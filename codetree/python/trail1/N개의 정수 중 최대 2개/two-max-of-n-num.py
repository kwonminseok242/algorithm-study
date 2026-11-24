n = int(input())
a = list(map(int, input().split()))

# Please write your code here.
answer = []
for i in sorted(a)[::-1]:
    answer.append(i)

print(answer[0],answer[1])

