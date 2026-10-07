-- 아픈 동물 찾기 (Lv1)
-- 결과: 통과 (한 번에 맞춤)

-- 내 풀이
SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS
WHERE INTAKE_CONDITION = 'Sick'
ORDER BY ANIMAL_ID ASC;

-- 메모
-- 틀린 이유: 없음.
-- 접근 방법: "아픈" -> INTAKE_CONDITION = 'Sick' / "아이디 순" -> ORDER BY ANIMAL_ID
-- 기억해 둘 점:
--   INTAKE_CONDITION 값은 'Normal', 'Sick', 'Injured', 'Aged' 네 가지다.
--   ('Aged'는 "어린 동물 찾기" 문제의 예시에서 확인했다)
--   "아프거나 다친" 이면 IN ('Sick', 'Injured'),
--   "정상이 아닌" 이면 != 'Normal',
--   "젊은" 이면 != 'Aged' 다. 문장을 값으로 바꿔 생각한다.
