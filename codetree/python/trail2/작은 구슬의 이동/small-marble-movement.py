n, t = map(int, input().split())
r, c, d = input().split()
x, y = int(r) - 1, int(c) - 1

#       오른쪽 아래 왼쪽 위
dxs = [0, 1,  0, -1]
dys = [1, 0, -1,  0]
mapper = {'R': 0, 'D': 1, 'L': 2, 'U': 3}
dir_num = mapper[d]

def in_range(x, y):
    return 0 <= x < n and 0 <= y < n

for _ in range(t):
    nx, ny = x + dxs[dir_num], y + dys[dir_num]
    if in_range(nx, ny):
        x, y = nx, ny
    else:
        dir_num = (dir_num + 2) % 4  # 반대 방향, 이번 1초는 제자리

print(x + 1, y + 1)