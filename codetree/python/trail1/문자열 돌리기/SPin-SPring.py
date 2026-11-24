s = input()

for i in range(len(s)+1):
    print(s)
    s = s[-1] + s[:-1]

