# 입력 처리
n = int(input())
arr = list(map(int, input().split()))

# 배열을 순회하며 짝수인 경우 2로 나눔
for i in range(n):
    if arr[i] % 2 == 0:
        arr[i] = arr[i] // 2

# 배열의 요소들을 공백으로 구분하여 출력
print(*arr)