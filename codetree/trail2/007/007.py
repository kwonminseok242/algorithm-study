secret_code, meeting_point, time = input().split()
time = int(time)

class spy:
    def __init__(self, secret_code, location, time):
        self.sc = secret_code
        self.l = location
        self.t = time

spy1 = spy(secret_code, meeting_point, time)

# 콜론(:) 앞의 공백을 없애거나 통일해야 정답 처리됩니다.
# 문제의 출력 예시가 'secret code : ' 라면 아래처럼 콜론 앞뒤로 공백을 주세요.
print(f"secret code : {spy1.sc}\nmeeting point : {spy1.l}\ntime : {spy1.t}")