from collections import deque

n, m = map(int,input().split()) # n이 행 m이 열
grid = [list(map(int,input().split())) for _ in range(n)]
visited = [[False]*m for _ in range(n)]
q = deque()
ex, ey = n-1,m-1

def in_range(x,y): # 갈수있는곳인지
    return 0<= x <= n-1 and 0 <= y <= m-1 

def dangerous(x,y):
    if grid[x][y] == 0:
        return False
    else:
        return True

def if_can_go(x,y): # 위에 두개 합친거랑 간곳인지 확인하는것
    return in_range(x,y) and dangerous(x,y) and not visited[x][y]

def bfs():
    dxs, dys = [1,0,-1,0],[0,-1,0,1]
    while q:
        x, y = q.popleft()
        if (x, y) == (ex, ey):         # 도착점을 꺼냈으면
            return True  
        for dx, dy in zip (dxs,dys):
            nx, ny = x+dx, y+dy
            if if_can_go(nx,ny):
                visited[nx][ny] = True
                q.append((nx,ny))
    return False
q.append((0,0))
visited[0][0] = True
if bfs():
    print(1)
else:
    print(0)

