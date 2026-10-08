commands = input()

# L = 왼쪽 90도 | R = 오른쪽 90도 | F = 한칸 이동
x, y = 0,0
dir_num = 0
dxs, dys = [0,1,0,-1],[1,0,-1,0]
mapper = {"L":3, "R":1, 'F':dir_num}
time = 0
answer = -1
for cmd in commands:
    if cmd == 'F':
        x, y = x + dxs[dir_num], y + dys[dir_num]
        time += 1
        if x == 0 and y == 0:
            answer = time
            break
    else:
        dir_num = (dir_num + mapper[cmd]) % 4
        time += 1

print(answer)

    

     




