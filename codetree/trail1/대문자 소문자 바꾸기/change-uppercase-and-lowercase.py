s = input()
a = ''
for i in s:
    if 'a' <= i <= 'z':
        a += i.upper()
    elif 'A' <= i <= 'Z':
        a += i.lower()

print(a) 
