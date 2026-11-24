s = list(input())
ex = s[0]
ex1 = s[1]

for i in range(len(s)):
    if s[i] == ex1:
        s[i] = ex

for i in s:
    print(i,end='')

