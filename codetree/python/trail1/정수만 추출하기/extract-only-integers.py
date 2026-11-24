A, B = input().split()

a, b = len(A), len(B)              # ⭐ ③ 못 찾으면 끝까지 전부 숫자

for idx, c in enumerate(A):        # ⭐ 위치는 enumerate 로
    if not ('0' <= c <= '9'):      # ⭐ ① not 을 쓰면 뒤집을 일이 없다
        a = idx
        break

for idx, c in enumerate(B):
    if not ('0' <= c <= '9'):
        b = idx
        break

print(int(A[:a]) + int(B[:b]))     # ⭐ ② 디버깅 print 없음
