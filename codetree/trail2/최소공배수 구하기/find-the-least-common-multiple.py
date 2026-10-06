n, m = map(int, input().split())

# Please write your code here.

def max_ball_madician_num(n,m):
    Yes = True
    cnt = n
    while Yes:
        if cnt % n == 0 and cnt % m == 0:
            print(cnt)
            Yes = False
        cnt +=1
        


max_ball_madician_num(n,m)