n = int(input())

def hellow(n):
    print('HelloWorld')
    if n <= 1:
        return
    n -= 1
    return hellow(n)

hellow(n)


    