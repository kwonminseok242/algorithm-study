arr = list(map(int, input().split()))

result = []
cnt = 0
for x in arr:            # ⭐ 앞에서부터 읽는다
    if x == 0:
        break            # 0을 만나면 여기서 끝
    result.append(x)
    cnt +=1

print(f"{sum(result)} {sum(result)/cnt:.1f}")     # 담은 다음에 뒤집어서 출력
