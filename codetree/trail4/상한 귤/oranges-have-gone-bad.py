# N * N 격자 0,1,2로만 이루어짐
# 0초에 K개의 상한 귤로부터 시작해서 1초에 한번씩 모든 상한 귤로부터 상하좌우 인접한 귤이 모두 상할때
# 귤마다 최초로 상하게되는 시간을 구하는 프로그램 구하기

# 1은 귤이 놓여져있는것이고, 2는 해당칸에 상한귤이 처음부터 놓여있음 의미
from collections import deque

n, k = map(int, input().split())
grid = [list(map(int,input().split())) for _ in range(n)]
q = deque()

# 그러면 0이 못가는곳(뱀이있는곳) 1은 갈수있는곳이고 한칸마다 1초니까 그거 세면 될듯 bfs로

def in_range(x,y):
    return 0<=x<=n-1 and 0<=y<=n-1
    
def can_go(x,y):
    if grid[x][y] == 1:
        return True
    else:
        return False

def bfs():
    dxs, dys = [0,0,1,-1],[1,-1,0,0]
    while q:
        x, y, s = q.popleft()
        for nx, ny in zip(dxs,dys):
            x,y = nx+x,ny+y
            if in_range(x,y) and grid[x][y] == 0:
                grid[x][y] = -1

            if in_range(x,y) and can_go(x,y):
                s +=1
                q.append((x,y,s))
                grid[x][y] = s

start = []
for i in range(n):
    for j in range(n):
        if grid[i][j] == 2:
            start.append((i,j))
        else:
            continue

for i,j in start:
    q.append((i,j,0))

bfs()
print(grid)




