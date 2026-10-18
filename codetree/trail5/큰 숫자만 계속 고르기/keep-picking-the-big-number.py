import heapq
n, m = map(int, input().split())
arr = list(map(int, input().split()))

arr = [-x for x in arr]
heapq.heapify(arr)

for i in range(m):
     x = -heapq.heappop(arr) -1
     heapq.heappush(arr,-x)

print(-arr[0])