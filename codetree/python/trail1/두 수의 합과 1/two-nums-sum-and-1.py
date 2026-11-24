a, b = input().split()

sum = int(a)+int(b)
cnt = 0
for i in str(sum):
    if i == '1':
        cnt +=1

print(cnt)