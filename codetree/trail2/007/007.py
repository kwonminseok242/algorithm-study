secret_code, meeting_point, time = input().split()
time = int(time)

# Please write your code here.

class spy:
    def __init__(self, secret_code, location, time):
        self.sc = secret_code
        self.l = location
        self.t = time

spy1 = spy(secret_code,meeting_point,time)

print(f"secret code : {spy1.sc}\nmeeting point : {spy1.l}\ntime : {spy1.t}")
