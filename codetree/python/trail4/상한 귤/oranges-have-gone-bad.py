from collections import deque

n, k = map(int, input().split())
grid = [list(map(int, input().split())) for _ in range(n)]
dist = [[-1] * n for _ in range(n)]       # -1 = 아직 안 상함
q = deque()

def in_range(x, y):
    return 0 <= x < n and 0 <= y < n

def can_go(x, y):
    return in_range(x, y) and grid[x][y] == 1 and dist[x][y] == -1

def bfs():
    dxs, dys = [0, 0, 1, -1], [1, -1, 0, 0]
    while q:
        x, y = q.popleft()
        for dx, dy in zip(dxs, dys):
            nx, ny = x + dx, y + dy
            if can_go(nx, ny):
                dist[nx][ny] = dist[x][y] + 1
                q.append((nx, ny))

for i in range(n):                        # 상한 귤 전부 시작점으로
    for j in range(n):
        if grid[i][j] == 2:
            dist[i][j] = 0
            q.append((i, j))

bfs()

for i in range(n):                        # 출력 규칙대로 변환
    row = []
    for j in range(n):
        if grid[i][j] == 0:
            row.append(-1)
        elif dist[i][j] == -1:            # 귤인데 끝까지 안 상함
            row.append(-2)
        else:
            row.append(dist[i][j])
    print(*row)