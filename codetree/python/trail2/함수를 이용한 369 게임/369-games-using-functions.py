def count_369(a, b):
    cnt = 0
    for num in range(min(a, b), max(a, b) + 1):
        s = str(num)
        if num % 3 == 0 or '3' in s or '6' in s or '9' in s:
            cnt += 1
    return cnt


a, b = map(int, input().split())
print(count_369(a, b))
