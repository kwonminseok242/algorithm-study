from collections import deque

n, k = map(int, input().split())
grid = [list(map(int, input().split())) for _ in range(n)] # n은 행
points = [tuple(map(int, input().split())) for _ in range(k)]
visited = [[False]*n for _ in range(n)]
q = deque()

# k개의 시작점으로부터 상하좌우 인접한 곳으로만 이동하여 도달 가능한 칸의 수를 구하는 프로그램
def in_range(x,y):
    return 0<=x<=n-1 and 0<=y<=n-1

def dangerous(x,y):
    if grid[x][y] == 0:
        return True
    else:
        return False

def can_go(x,y):
    return in_range(x,y) and dangerous(x,y) and not visited[x][y]

def bfs():
    dxs, dys = [0,0,1,-1],[1,-1,0,0]
    while q:
        x,y = q.popleft()
        for ex,ey in zip(dxs,dys):
            nx, ny = x+ex, y+ey
            if can_go(nx,ny):
                q.append((nx,ny))
                visited[nx][ny] = True

for r, c in points:
    r, c = r - 1, c - 1
    if not visited[r][c]:
        visited[r][c] = True
        q.append((r, c))
        bfs()

print(sum(row.count(True) for row in visited))


     



