n = int(input())
a = list(map(int, input().split()))

cnt = 0
for i in a:
    if min(a) == i:
        cnt +=1

print(min(a),cnt)
