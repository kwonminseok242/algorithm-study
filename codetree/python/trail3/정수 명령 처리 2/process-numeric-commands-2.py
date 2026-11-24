from collections import deque
N = int(input())
q = deque()


for _ in range(N):
    line = input().split() # 리스트로 바뀌는 구나
    if line[0] == "push":
        q.append(int(line[1]))
    elif line[0] == "pop":
        if q:
            print(q.popleft())
        else:
            continue
    elif line[0] == "size":
        print(len(q))
    elif line[0] == "empty":
        if q:
            print(0)
        else:
            print('1')
    elif line[0] == "front":
        print(q[0])
    

# Please write your code here.