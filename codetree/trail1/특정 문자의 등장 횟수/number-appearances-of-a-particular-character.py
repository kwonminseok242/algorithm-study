s = input()

cnt = 0
pos = 0
while True:
    pos = s.find('ee', pos)
    if pos == -1:                 # ⭐ 에러 대신 -1 — try 가 필요 없다
        break
    cnt += 1
    pos += 1
print(cnt,end=' ')

cnt = 0
pos = 0
while True:
    pos = s.find('eb', pos)
    if pos == -1:                 # ⭐ 에러 대신 -1 — try 가 필요 없다
        break
    cnt += 1
    pos += 1
print(cnt,end=' ')
