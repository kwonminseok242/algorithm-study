jung = list(map(int,input().split()))

if jung[0] == min(jung):
    print('1',end = " ")
else:
    print('0',end = " ")

if jung[0] == jung[1] == jung[2]:
    print('1',end = " ")
else:
    print('0',end = " ")
