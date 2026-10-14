n, m = map(int, input().split())

# Please write your code here.

map = [[0]*m for _ in range(n)]

# direction = ['N','E','S','W']
# 방향이 남 동 북 서 니까 그에 맞게 배열의 값을 맞춰준다.
dxs,dys = [1,0,-1,0],[0,1,0,-1]
x,y,dir_num = 0,0,0

# 값을 넣어줄 숫자 반복문을 만든다.
for i in range(1,n*m+1):
    map[x][y] = i
    nx, ny = x+dxs[dir_num],y+dys[dir_num]
    if not(0 <= nx <n and 0<= ny <m) or map[nx][ny] != 0:
        dir_num = (dir_num+1)%4
        nx, ny = x + dxs[dir_num], y + dys[dir_num]

    x,y = nx,ny

for i in map:
    print(*i)    
    
    



