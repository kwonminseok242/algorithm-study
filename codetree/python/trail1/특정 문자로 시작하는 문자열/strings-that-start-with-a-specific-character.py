N = int(input())

arr = [input() for _ in range(N)]

ex = input()
cnt = 0
sum = 0
for i in arr:
    if ex == i[0]:
        cnt+=1
        sum += len(i)

print(f"{cnt} {sum/cnt:.2f}")


