s = input()

ss = list(s)

ss[1] = 'a'

ss[-2] = 'a'

for i in ss:
    print(i,end='')