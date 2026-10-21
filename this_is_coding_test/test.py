from collections import deque
import sys, io
sys.stdin = io.StringIO("""10
1 1 1 0 0 0 0 1 1 1
1 1 1 1 0 0 0 0 1 1
1 0 1 1 0 0 0 0 1 1
0 0 1 1 1 0 0 0 0 1
0 0 0 1 0 0 0 0 0 1
0 0 0 0 0 0 0 0 0 1
0 0 0 0 0 0 0 0 0 0
0 0 0 0 1 1 0 0 0 0
0 0 0 0 1 1 1 0 0 0
0 0 0 0 0 0 0 0 0 0""")
n = int(input())
sea_map = [list(map(int, input().split())) for _ in range(n)]
q = deque()

def island_range(x,y):
    return 0<= x <= n-1 and 0<= y <= n-1 and sea_map[x][y] == 1 # 가장앞에 격자 범위가 나오고 뒤에 1(땅)인지 확인

def num_island_bfs():
    dxs,dys = [0,0,1,-1],[1,-1,0,0] 
    while q: # 큐가 있으면 계속 반복한다.
        x,y,num = q.popleft() # 큐에서 꺼내온다.
        for dx,dy in zip(dxs,dys): # 상하좌우를 확인한다.
            nx,ny = x+dx,y+dy
            if island_range(nx,ny): # 다음 곳으로 갈 수 있는지 확인한다.
                q.append((nx,ny,num)) # 갈 수 있다면 큐에 넣어준다.
                sea_map[nx][ny] = num # 섬을 그 섬의 번호로 채워준다.
    
# 먼저 모든 맵을 0,0부터 시작하면서 1이 나오는지 확인후 1이 나오는 순간 거기를 시작점으로 1이 있는 지점을 하나의 섬번호로 다채워넣는다. 어차피 섬은 떨어져있기때문에
# 0을 만나면 알아서 큐가 비워지고 while문이 종료되게 된다.

# 반복문
num = 1 # 섬은 따로 세기
for x in range(n): # 1번 반복할때 숫자를 같이 넘겨준다. 1로 넣었을때 1을 찾아나가기 때문에 중복된 곳에 다시 갈 수 있으니 2부터 시작하도록 한다.
    for y in range(n):
        if sea_map[x][y] == 1: # 0,0부터 시작하면서 1이 나오는지 확인
            num += 1
            q.append((x,y,num)) # 나왔다면 큐(deque)에 넣어준다
            sea_map[x][y] = num # 미리 그 섬의 번호로 넣어준다.
            num_island_bfs()
    
for row in sea_map:
    print(*row)

def bridge(k):                          # k번 섬에서 출발
    dist = [[-1] * n for _ in range(n)] # 미방문을 표시하기위해 없는 숫자 -1로 채워넣음
    q = deque()
    for i in range(n): # K인 섬을 큐에 다 넣어줌
        for j in range(n):
            if sea_map[i][j] == k:   # ① k번 섬의 칸이면
                dist[i][j] = 0
                q.append((i, j))

    dxs, dys = [0, 0, 1, -1], [1, -1, 0, 0]
    while q: 
        x, y = q.popleft()
        for dx, dy in zip(dxs, dys):
            nx, ny = x + dx, y + dy
            if not (0 <= nx < n and 0 <= ny < n): # 범위 확인
                continue
            if sea_map[nx][ny] != 0 and sea_map[nx][ny] != k:    # ② 다른 섬의 땅이면
                return dist[x][y] # 현재 
            if sea_map[nx][ny] == 0 and dist[nx][ny] == -1:    # ③ 아직 안 간 바다면
                dist[nx][ny] = dist[x][y] + 1 # 거리를 표시해주기위해서 1을 늘려준다. 근데 1부터 시작해야하지않나 위애서 -1로 다채워서 0이 될거같은데 1칸은
                q.append((nx, ny))
    return float('inf') # 무한대를 반환한다. 실패시 코드

print(min(bridge(k) for k in range(2, num + 1)))