n = int(input())
moves = [tuple(input().split()) for _ in range(n)]
dir = [move[0] for move in moves]
dist = [int(move[1]) for move in moves]

# Please write your code here.
dx = 0
dy = 0
for i in range(n):
    if dir[i] == 'N':
        dx, dy = dx+0, dy + dist[i]
    elif dir[i] == 'E':
        dx, dy = dx + dist[i], dy+0 
    elif dir[i] == 'W':
        dx, dy = dx - dist[i], dy+0
    elif dir[i] == 'S':
        dx, dy = dx+0, dy -dist[i]

print(dx,dy)