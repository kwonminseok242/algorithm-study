class Student:
    def __init__(self, name, kor, eng, math):
        self.name = name
        self.kor = kor
        self.eng = eng
        self.math = math

n = int(input())
students = []

# 1. 입력받은 데이터를 바로 Student 객체로 만들어 리스트에 추가합니다.
for _ in range(n):
    student_input = input().split()
    name = student_input[0]
    kor = int(student_input[1])
    eng = int(student_input[2])
    math = int(student_input[3])
    
    students.append(Student(name, kor, eng, math))

# 2. 세 과목 점수의 총합을 기준으로 오름차순(낮은 순) 정렬합니다.
students.sort(key=lambda x: x.kor + x.eng + x.math) 

# 3. 정렬된 결과를 이름과 함께 출력합니다.
for student in students:
    print(student.name, student.kor, student.eng, student.math)