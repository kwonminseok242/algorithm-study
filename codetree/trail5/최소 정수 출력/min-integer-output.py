import heapq
n = int(input())
x = [int(input()) for _ in range(n)]

# 입력이 x면 배열에 x넣기
# 입력이 0이면 배열에서 가장 작은 값을 출력하고 그값을 배열에서 제거
pq = []
for elem in x:
    if elem > 0:
        heapq.heappush(pq,elem)
    elif elem == 0:
        if not pq:
            print('0')
        else:
            print(heapq.heappop(pq))



