arr = list(map(int, input().split()))

result = []
for x in arr:            # ⭐ 앞에서부터 읽는다
    if x == 0:
        break            # 0을 만나면 여기서 끝
    result.append(x)

print(*result[::-1])     # 담은 다음에 뒤집어서 출력
