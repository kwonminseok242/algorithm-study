def swap_values(a, b):
    # 두 값을 교환하여 반환
    return b, a

# 입력 처리
n, m = map(int, input().split())

# 함수 호출 및 결과 갱신
n, m = swap_values(n, m)

# 출력
print(n, m)