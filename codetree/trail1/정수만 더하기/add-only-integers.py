s = input().lower()          # ⭐ 먼저 소문자로 통일 → 볼 구간이 하나로 줄어든다

a = 0
for c in s:
    if '0' <= c <= '9':    # ⭐ 남길 것만 통과
        a += int(c)

print(a)
