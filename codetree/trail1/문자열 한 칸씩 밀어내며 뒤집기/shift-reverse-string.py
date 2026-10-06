s, q = input().split()
q = int(q)
queries = [int(input()) for _ in range(q)]

# Please write your code here.
for i in queries:
    if i == 1:
        s = s[1:] + s[0]
        print(s)
    elif i == 2:
        s = s[-1] + s[:-1]
        print(s)

    elif i == 3:
        s = s[::-1]
        print(s)




