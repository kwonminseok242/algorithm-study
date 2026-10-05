s = list(input())

while len(s) > 1:
    i = int(input())
    if i >= len(s):
        s.pop(-1)
        print(*s,sep='')
    else:
        s.pop(i)
        print(*s,sep='')
