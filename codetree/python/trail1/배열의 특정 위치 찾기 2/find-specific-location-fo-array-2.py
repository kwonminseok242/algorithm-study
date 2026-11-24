arr = list(map(int, input().split()))

hol = []
jack = []
for i in arr[0::2]:
    hol.append(i)

for i in arr[1::2]:
    jack.append(i)

if sum(hol)>sum(jack):
    print(sum(hol)- sum(jack))
else:
    print(sum(jack)-sum(hol))