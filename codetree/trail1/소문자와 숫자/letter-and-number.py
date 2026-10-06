s = input().lower()          # ⭐ 먼저 소문자로 통일 → 볼 구간이 하나로 줄어든다

a = ''
for c in s:
    if 'a' <= c <= 'z' or '0' <= c <= '9':    # ⭐ 남길 것만 통과
        a += c

print(a)
