class Student:
    def __init__(self, height, weight, number):
        self.height = height
        self.weight = weight
        self.number = number

n = int(input())
# 1. 입력받은 데이터를 튜플 리스트로 저장 (잘 작성하신 부분!)
input_data = [tuple(map(int, input().split())) + (i + 1,) for i in range(n)]

students = []

# 2. 튜플 데이터를 꺼내서 Student 객체로 변환 후 리스트에 추가
for data in input_data:
    # data는 (키, 몸무게, 번호) 형태입니다.
    h = data[0]
    w = data[1]
    num = data[2]
    students.append(Student(h, w, num))

# 3. 다중 조건 정렬 (핵심!)
# 내림차순(큰 순서)은 앞에 마이너스(-)를 붙이고, 오름차순(작은 순서)은 그대로 둡니다.
students.sort(key=lambda x: (-x.height, -x.weight, x.number))

# 4. 결과 출력
for s in students:
    print(s.height, s.weight, s.number)