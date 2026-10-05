A = input()
B = input()

# Please write your code here.
while B in A:
    # print(f"인덱스 번호 :{A.index(B)} {A.index(B)+1}")
    # print(f"슬라이싱 : {A[:A.index(B)]} {A[A.index(B)+2:]}")
    A = A[:A.index(B)] + A[A.index(B)+len(B):]
    # print(f'결과 : {A}')

print(A)