N = int(input())
moves = [tuple(input().split()) for _ in range(N)]
dir = [move[0] for move in moves]
dist = [int(move[1]) for move in moves]

# Please write your code here.
dxs = [0,1,0,-1]
dys = [1,0,-1,0]
x,y = 0,0

mapper = {'S':0,'E':1,'N':2,'W':3}
time = 0
answer = -1

for i in range(N):
    dis_num = mapper[dir[i]]
    for _ in range(dist[i]):
        x, y = x+dxs[dis_num], y+dys[dis_num]
        time+=1
        if x == 0 and y == 0:
            answer = time
            break
    if answer != -1:   # 답을 찾았으면 바깥 루프도 종료
        break

print(answer)








