N = int(input())
for j in range(N):
    a, b = map(int, input().split())

    arr = [] # 리스트 초기화를 안쪽 for문 바깥으로 이동
    for i in range(a, b+1):
        if i % 2 == 0:
            arr.append(i)
            
    print(sum(arr))