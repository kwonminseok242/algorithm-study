ex = input()
this = input()

n = len(ex)
ans = -1

if len(ex) == len(this):
    for k in range(1, n + 1):        # ⭐ N > 0 이므로 1부터
        if ex[-k:] + ex[:-k] == this:   # 오른쪽으로 k번 민 결과
            ans = k
            break

print(ans)
