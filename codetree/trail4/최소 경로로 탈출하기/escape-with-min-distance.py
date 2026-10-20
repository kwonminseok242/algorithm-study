from collections import deque
n, m = map(int, input().split()) # n 은 행 m 은 열
grid = [list(map(int, input().split())) for _ in range(n)]
visited = [[False]*m for _ in range(n)]
q = deque()

def in_range(x,y):
    return 0<= x <=n-1 and 0<= y <=m-1

def dangerous(x,y):
    if grid[x][y] == 0:
        return False
    else:
        return True

def can_go(x,y):
    return in_range(x,y) and dangerous(x,y) and not visited[x][y]

def bfs():
    dxs,dys = [0,0,-1,1],[1,-1,0,0]
    while q:
        x,y,s = q.popleft()
        if x == n-1 and y == m-1:
            return s

        for nx, ny in zip(dxs,dys):
            nx,ny = x+nx,y+ny
            if can_go(nx,ny):
                q.append((nx,ny,s+1))
                visited[nx][ny] = s
    return -1
q.append((0,0,0))
visited[0][0] = True
print(bfs())





