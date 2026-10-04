A = input()

arr = []
ex = A[0]                     # ex = 지금 세고 있는 글자
cnt = 0                       # cnt = 그 글자가 몇 번 연속됐나

for c in A:
    if c == ex:
        cnt += 1              # 같으면 계속 센다
    else:
        arr.append(f"{ex}{cnt}")   # 다르면 세던 걸 확정하고
        ex = c                     # 새 묶음 시작
        cnt = 1

arr.append(f"{ex}{cnt}")      # ⭐⭐ 마지막 묶음 — 루프 밖에서 한 번 더

result = ''.join(arr)
print(len(result))
print(result)