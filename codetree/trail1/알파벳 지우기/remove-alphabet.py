a = input()
b = input()
A = ''
B = ''
for i in a:
    if 'a' >= i:
        A +=i
for i in b:
    if 'a' >= i:
        B += i

print(int(A)+int(B))

