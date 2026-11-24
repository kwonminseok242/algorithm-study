n = int(input())
meetings = [tuple(map(int, input().split())) for _ in range(n)]

# 회의 시작 시간, 끝시간
# 비선점(끝날때까지 기다려야함), 취소하는회의 개수를 최소화해서 회의할 수 있는 최대의 회의수 구하기
# 회의를 하나씩 빼고 돌려서 가능한 회의수를 구하면되나? 회의를 2개를 빼야하면 어떡하지?
# 일단 meetings를 정렬해야하나?


meetings.sort(key=lambda x: (x[1], x[0])) # 회의를 끝나는 순서대로 정렬

total = 0
end_time = 0

for start, end in meetings:
    if end_time <= start:
        end_time = end
        total +=1

print(len(meetings) - total) 

