n = int(input())
words = [input() for _ in range(n)]

# Please write your code here.
kk = {}
for i, elem in enumerate(words):
    if elem not in kk:
        kk[elem] = 1
    else:
        kk[elem] += 1

print(max(kk.values()))
    

