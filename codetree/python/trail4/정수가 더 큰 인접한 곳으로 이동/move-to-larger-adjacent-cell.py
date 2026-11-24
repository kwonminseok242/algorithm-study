n, r, c = map(int, input().split())
a = [list(map(int, input().split())) for _ in range(n)]

curr_x, curr_y = r - 1, c - 1

# 정답을 담아둘 리스트 (시작 위치의 값을 먼저 넣어둡니다)
result = [a[curr_x][curr_y]]

def inRange(x, y):
    return 0 <= x < n and 0 <= y < n

while True:
    # 상, 하, 좌, 우 우선순위
    dxs, dys = [-1, 1, 0, 0], [0, 0, -1, 1]
    moved = False  # 이번 턴에 이동했는지 확인하는 변수
    
    for dx, dy in zip(dxs, dys):
        next_x, next_y = curr_x + dx, curr_y + dy
        
        # 격자 안이면서, '현재 위치의 숫자보다 큰 곳'을 찾았다면!
        if inRange(next_x, next_y) and a[next_x][next_y] > a[curr_x][curr_y]:
            curr_x, curr_y = next_x, next_y
            result.append(a[curr_x][curr_y])
            moved = True
            break  # ★ 핵심: 조건에 맞는 곳을 찾았으니 남은 방향은 무시하고 바로 턴을 넘깁니다.
            
    # 4방향을 모두 확인했는데도 이동하지 못했다면 (주변에 더 큰 숫자가 없다면) 종료
    if not moved:
        break

# 결과 배열의 요소를 공백으로 구분하여 한 줄로 출력
print(*result)