A, B = map(int, input().split())

print(A // B, end='.')       # 정수부 + 소수점  
r = A%B
for _ in range(20):
    r *= 10
   
    print( r//B,end='')
    r %=B