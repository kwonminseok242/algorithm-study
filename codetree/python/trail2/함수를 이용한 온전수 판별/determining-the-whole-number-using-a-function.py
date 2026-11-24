a, b = map(int, input().split())

# Please write your code here.
def condition(i):
    if i % 2 == 0 or i%3 ==0 and i %9!=0 or i % 10 == 5:
        return False
    return True
cnt = 0
for i in range(a,b+1):
    if condition(i):
        cnt+=1
print(cnt)

