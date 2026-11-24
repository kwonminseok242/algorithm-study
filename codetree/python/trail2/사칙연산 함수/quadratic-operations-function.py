a, o, c = input().split()
a = int(a)
c = int(c)

# Please write your code here.

def add(a,c):
    return a+c

def minus(a,c):
    return a-c

def sque(a,c):
    return a*c

def div(a,c):
    return a//c

if o == '+':
    print(f"{a} {o} {c} = {add(a,c)}")
elif o == '-':
    print(f"{a} {o} {c} = {minus(a,c)}")
    
elif o == '*':
    print(f"{a} {o} {c} = {sque(a,c)}")
    
elif o == '/':
    print(f"{a} {o} {c} = {div(a,c)}")
    
else:
    print('False')


