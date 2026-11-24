sum = 0
cnt = 0
while True:
    n = int(input())
    if n < 20 or n >= 30:
        break
    cnt +=1
    sum += n
print(f'{sum/cnt:.2f}')

    