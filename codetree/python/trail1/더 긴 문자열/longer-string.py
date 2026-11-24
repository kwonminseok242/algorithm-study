a = list(input().split())

if len(a[0]) > len(a[1]):
    print(f"{a[0]} {len(a[0])}")
elif len(a[0]) < len(a[1]):
    print(f"{a[1]} {len(a[1])}")
else:
    print('same')
