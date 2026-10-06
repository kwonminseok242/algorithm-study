A = input()

arr = list(input())

for i in arr:
    if i == 'L':
        A = A[1:] + A[0]
    elif i == 'R':
        A = A[-1] + A[:-1]

print(A)




