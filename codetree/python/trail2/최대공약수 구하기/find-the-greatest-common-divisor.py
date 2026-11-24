n, m = map(int, input().split())

# Please write your code here.

def max_ball_madician_num(n,m):
    for i in range(m,0,-1):
        if n%i == 0 and m%i==0:
            print(i)
            break


max_ball_madician_num(n,m)