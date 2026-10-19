n = int(input())
commands = []
x = []
for _ in range(n):
    cmd, val = input().split()
    commands.append(cmd)
    x.append(int(val))

# Please write your code here.
s = set()

for i in range(n):
    if commands[i] == 'add':
        s.add(x[i])
    elif commands[i] == 'remove':
        s.remove(x[i])
    elif commands[i] == 'find':
        print('true' if x[i] in s else 'false')
