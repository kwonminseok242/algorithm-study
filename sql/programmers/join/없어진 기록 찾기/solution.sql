-- 없어진 기록 찾기 (Lv3)
-- 결과: 풀이 맞음 (제출 결과 미확인)

-- 내 풀이 (10/20 · NOT IN)
SELECT ANIMAL_ID, NAME
FROM ANIMAL_OUTS
WHERE ANIMAL_ID NOT IN (SELECT ANIMAL_ID FROM ANIMAL_INS)
ORDER BY ANIMAL_ID

-- 메모
-- 틀린 이유: 없음.
--   "입양을 간 기록은 있는데 보호소에 들어온 기록이 없는 동물"
--   = ANIMAL_OUTS에는 있고 ANIMAL_INS에는 없는 ID. ID 순 정렬.
-- 접근 방법 (조인 풀이):
--   SELECT O.ANIMAL_ID, O.NAME
--   FROM ANIMAL_OUTS AS O
--   LEFT JOIN ANIMAL_INS AS I ON O.ANIMAL_ID = I.ANIMAL_ID
--   WHERE I.ANIMAL_ID IS NULL
--   ORDER BY O.ANIMAL_ID;
--   LEFT JOIN의 왼쪽에 "남길 쪽"(OUTS)을 둔다. 짝이 없는 행은 오른쪽(INS) 열이 NULL.
-- 기억해 둘 점:
--   오랜 기간 보호한 동물(1)과 방향만 반대인 같은 문제다.
--     오랜 기간 보호한 동물(1): INS에 있고 OUTS에 없는 것 -> FROM INS ... NOT IN (OUTS)
--     없어진 기록 찾기:         OUTS에 있고 INS에 없는 것 -> FROM OUTS ... NOT IN (INS)
--   "어디에 있고 어디에 없는가"를 먼저 한 문장으로 정하면 FROM과 서브쿼리 자리가 정해진다.
--   NOT IN 서브쿼리에 NULL이 섞이면 0행이 된다. ANIMAL_INS.ANIMAL_ID는 NULL 불가라 안전.
