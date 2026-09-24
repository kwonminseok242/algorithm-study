N = int(input())
sum_val = 0
for i in range(1,N):
    if N%i == 0:
        sum_val += i
if N == sum_val:
    print('P')
else:
    print('N')
