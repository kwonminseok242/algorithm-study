N = int(input())

sum_val = 0
for _ in range(N):
    i = int(input())
    if i%2 != 0 and i%3==0:
        sum_val += i

print(sum_val)
