s = list(input())

ex = s[0]
ex2 = s[1]
if s[0] == ex:
    s[0] = ex2
for i in range(1,len(s)):
    if s[i] == ex:
        s[i] = ex2
    elif s[i] == ex2:
        s[i] = ex
    







for i in s:
    print(i,end='')

        

        
        