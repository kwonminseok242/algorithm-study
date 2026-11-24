n = int(input())

# Please write your code here.

arr = [[0]*n for _ in range(n)]

dxs,dys = [0,-1,0,1],[-1,0,1,0]
x, y, dir_num = n-1, n-1, 0

# 0부터 n*m - 1 까지 총 n*m번 반복
for i in range(n * n,0,-1):
    # i % 26을 통해 Z(90)를 넘어가면 다시 A(65)로 돌아오게 함
    arr[x][y] = i
    
    nx, ny = x + dxs[dir_num], y + dys[dir_num]
    
    if not (0 <= nx < n and 0 <= ny < n) or arr[nx][ny] != 0:
        dir_num = (dir_num + 1) % 4
        nx, ny = x + dxs[dir_num], y + dys[dir_num]

    x, y = nx, ny

for row in arr:
    print(*row)