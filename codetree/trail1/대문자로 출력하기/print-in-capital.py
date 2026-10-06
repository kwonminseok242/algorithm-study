s = list(input())
a = ''
for i in s:
    if 'A' <= i <= 'Z' or 'a' <= i <= 'z':    # ⭐ or 로 두 구간
        a += i

print(a.upper())