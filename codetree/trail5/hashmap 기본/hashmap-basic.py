n = int(input())
commands = {}
for _ in range(n):
    line = input().split()
    cmd = line[0]
    k = int(line[1])
    if cmd == "add":
        commands[k] = line[2]
    elif cmd == 'find':
        if k in commands:
            print(commands[k])
        else:
            print('None')
    elif cmd == 'remove':
        commands.pop(k)

# Please write your code here.
