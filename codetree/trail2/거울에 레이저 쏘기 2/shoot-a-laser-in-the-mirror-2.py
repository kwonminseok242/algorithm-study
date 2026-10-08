n = int(input())
grid = [list(input()) for _ in range(n)]
k = int(input())

# covert k to start position and direction
x, y = 0,0
mapper = {}
for i in range(1,2*n+1):
    if i <= n:
        mapper[i] = [[x,y],'N']
        y += 1
        if i ==n:
            y = y-1
    else:
        mapper[i] = [[x,y],'W']
        x += 1
x, y = n-1,n-1
for i in range(2*n+1,4*n+1):
    if i <= 3*n:
        mapper[i] = [[x,y],'S']
        y -= 1
    else:
        mapper[i] = [[x,0],'E']
        x -= 1
# print(mapper)
# This function is the codition to end the code
def in_range(x,y):
    return x >= 0 and y >= 0 and x < n and y < n

# This is first grid postion
dxdy, direction = mapper[k]
x = dxdy[0]
y = dxdy[1]
cnt = 0

# defines
dxs = [-1,0,1,0]
dys = [0,1,0,-1]
wapper = {'S':0,'E':1,'N':2,'W':3}

# This function defines the slash operation.
def right_slash(x,y,direction):
    if direction == "W":
        direction = 'N'
        x = x + dxs[wapper['N']]
        y = y + dys[wapper['N']]
    elif direction == "E":
        direction = 'S'
        x = x + dxs[wapper['S']]
        y = y + dys[wapper['S']]
    elif direction == "S":
        direction = 'E'
        x = x + dxs[wapper['E']]
        y = y + dys[wapper['E']]
    elif direction == "N":
        direction = 'W'
        x = x + dxs[wapper['W']]
        y = y + dys[wapper['W']]
    return x,y,direction
    
def left_slash(x,y,direction):
    if direction == "W":
        direction = 'S'
        x = x + dxs[wapper['S']]
        y = y + dys[wapper['S']]
    elif direction == "E":
        direction = 'N'
        x = x + dxs[wapper['N']]
        y = y + dys[wapper['N']]
    elif direction == "S":
        direction = 'W'
        x = x + dxs[wapper['W']]
        y = y + dys[wapper['W']]
    elif direction == "N":
        direction = 'E'
        x = x + dxs[wapper['E']]
        y = y + dys[wapper['E']]
    return x,y,direction


while in_range(x,y):
    if grid[x][y] == '\\':
        cnt +=1
        x, y, direction = left_slash(x, y, direction)
        
    elif grid[x][y] == '/':
        right_slash(x,y,direction)
        cnt+=1
        x, y, direction = right_slash(x, y, direction)
        

print(cnt)



            

