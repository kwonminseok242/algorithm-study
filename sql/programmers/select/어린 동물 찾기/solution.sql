-- 어린 동물 찾기 (Lv1)
-- 결과: 통과 (한 번에 맞춤. 쉬웠다)

-- 내 풀이
SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS
WHERE INTAKE_CONDITION != 'Aged'
ORDER BY ANIMAL_ID;

-- 메모
-- 틀린 이유: 없음.
-- 접근 방법:
--   "젊은 동물"을 값으로 바꾼다. 예시를 보면 Aged가 아닌 동물이 전부 젊은 동물이다.
--   -> INTAKE_CONDITION != 'Aged'  (Normal, Sick, Injured가 모두 남는다)
--   "Normal이거나 Sick이거나 Injured" 라고 일일이 적지 않고, 아닌 것 하나만 빼는 쪽이 짧다.
-- 기억해 둘 점:
--   != 와 <> 는 같다. NOT IN ('Aged')로 써도 된다.
--   "A가 아닌" 조건은 그 열에 NULL이 있으면 NULL 행이 빠진다는 점만 주의한다.
--   NULL != 'Aged'의 결과는 참이 아니라 NULL이라 WHERE를 통과하지 못한다.
--   여기서는 INTAKE_CONDITION이 NOT NULL이라 문제가 없다.
--   (NULL도 살리려면 WHERE INTAKE_CONDITION != 'Aged' OR INTAKE_CONDITION IS NULL)
