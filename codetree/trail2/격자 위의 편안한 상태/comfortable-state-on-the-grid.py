n, m = map(int, input().split())
points = [tuple(map(int, input().split())) for _ in range(m)]

# Please write your code here.

map = [['F']*n for _ in range(n)]
dxs = [0,1,0,-1]
dys = [1,0,-1,0]
def in_range(x,y):
    return x < n and y >= 0 and y < n and x >= 0

for r,c in points:
    map[r-1][c-1] = 'T'
    cnt = 0
    for dx, dy in zip(dxs,dys):
        if in_range(r-1+dx, c-1+dy) and map[r-1+dx][c-1+dy] == 'T':
            cnt +=1
    if cnt == 3:
        print('1')
    else:
        print('0')





    