a = list(map(int, input().split()))

even_sum = 0
mul3_sum = 0
count = 0

for i in range(1, 11):  # 크기가 10인 수열이라고 명시되어 있으므로 11까지 반복
    # 1. 짝수 번째로 입력된 값의 합
    if i % 2 == 0:
        even_sum += a[i-1]
        
    # 2. 3의 배수 번째로 입력된 값의 평균 (elif가 아닌 if 사용)
    if i % 3 == 0:
        mul3_sum += a[i-1]
        count += 1

# 평균값 출력 (보통 알고리즘 문제에서는 소수점 첫째 자리까지 출력하는 경우가 많으므로 .1f를 사용합니다)
average = mul3_sum / count
print(f"{even_sum} {average:.1f}")