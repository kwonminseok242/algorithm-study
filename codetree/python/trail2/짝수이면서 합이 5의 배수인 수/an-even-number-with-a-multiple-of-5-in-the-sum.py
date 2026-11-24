n = int(input())

# Please write your code here.

def is_magic_number(n):
    n = str(n)
    n1 = n[0]
    n2 = n[1]
    return int(n) % 2 == 0 and (int(n1) + int(n2)) % 5 == 0

if is_magic_number(n):
    print('Yes')
else:
    print('No')

