import heapq

N = int(input())
commands = []

for _ in range(N):
    line = input().split()
    if line[0] == "push":
        commands.append((line[0], int(line[1])))
    else:
        commands.append((line[0],))


# push A : 정수 A를 우선순위 큐에 넣는 연산
# pop : 우선순위 큐에서 최댓값을 제거하고, 그 값을 출력
# size : 우선순위 큐에 들어있는 정수의 개수를 출력
# empty : 우선순위 큐가 비어있으면 1, 아니면 0을 출력
# top : 우선순위 큐에 들어있는 값 중 최댓값을 출력

# heapq를 import해서 아까 개념에 나와있던 클래스를 작성해야하나? 라는 생각이 들었음. 코드를 살펴보니까 commands라는 리스트에
# 튜플형태로 명령어와 숫자를 넣고 있는것을 알 수 있음. 이제 어떻게 해야하지? 하나씩 꺼내서 순서대로 진행하면 될거같은데
# 단순 if문으로 해서 각각의 명령어에 따라서 진행되게 하면 되나? 

pq = [] # 일단 들어갈 리스트를 만들어준다.
for cmd in commands:
    if cmd[0] == 'push':
        heapq.heappush(pq,-cmd[1])
    elif cmd[0] == 'pop':
        print(-heapq.heappop(pq))
    elif cmd[0] == 'size':
        print(len(pq))
    elif cmd[0] == 'empty':
        print(1 if not pq else 0)
    elif cmd[0] == 'top':
        print(-pq[0]) 

        