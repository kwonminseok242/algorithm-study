N = int(input())

for i in range(N):
    for j in range(N):
        print(chr(ord('A') + i * N + j), end='')
    print()
