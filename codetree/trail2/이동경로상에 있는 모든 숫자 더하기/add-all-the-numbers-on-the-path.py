n, t = map(int, input().split())
commands = input().strip() # L, R, F로 이루어진 문자열
arr = [list(map(int, input().split())) for _ in range(n)]

# 북, 동, 남, 서 (시계방향)
dxs, dys = [-1, 0, 1, 0], [0, 1, 0, -1]

# 시작 위치는 정가운데, 시작 방향은 북쪽(0)
x, y = n // 2, n // 2
dir_num = 0

# 시작 위치의 값을 정답에 먼저 더해둠
ans = arr[x][y]

for cmd in commands:
    if cmd == 'L':
        dir_num = (dir_num - 1) % 4
    elif cmd == 'R':
        dir_num = (dir_num + 1) % 4
    elif cmd == 'F':
        nx, ny = x + dxs[dir_num], y + dys[dir_num]
        
        # 격자의 범위를 벗어나지 않을 때만 이동
        if 0 <= nx < n and 0 <= ny < n:
            x, y = nx, ny
            ans += arr[x][y]

print(ans)