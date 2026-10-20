-- 오랜 기간 보호한 동물(1) (Lv3)
-- 결과: 풀이 맞음 (제출 결과 미확인)

-- 내 풀이 (10/20 · NOT IN)
SELECT NAME,DATETIME
FROM ANIMAL_INS
WHERE ANIMAL_ID NOT IN (SELECT ANIMAL_ID FROM ANIMAL_OUTS AS B)
ORDER BY DATETIME ASC
LIMIT 3

-- 메모
-- 틀린 이유: 없음.
--   "입양을 못 간 동물" = 들어온 기록(ANIMAL_INS)은 있는데 나간 기록(ANIMAL_OUTS)이 없는 동물.
--   NOT IN으로 나간 동물 ID를 빼고, 보호 시작일 오름차순 -> 앞에서 3마리.
-- 접근 방법 (JOIN 폴더 문제라 조인 풀이도 같이):
--   SELECT I.NAME, I.DATETIME
--   FROM ANIMAL_INS AS I
--   LEFT JOIN ANIMAL_OUTS AS O ON I.ANIMAL_ID = O.ANIMAL_ID
--   WHERE O.ANIMAL_ID IS NULL
--   ORDER BY I.DATETIME
--   LIMIT 3;
--   LEFT JOIN은 왼쪽(INS) 행을 전부 남기고, 짝이 없으면 오른쪽(OUTS) 열을 NULL로 채운다.
--   그래서 O.ANIMAL_ID IS NULL = "나간 기록이 없는 동물".
--   "A에는 있고 B에는 없는 것"은 NOT IN / LEFT JOIN + IS NULL / NOT EXISTS 세 가지가 같은 일을 한다.
-- 다듬을 점:
--   서브쿼리의 AS B는 어디에도 안 쓰니 빼도 된다.
-- 기억해 둘 점:
--   NOT IN (서브쿼리)는 서브쿼리 결과에 NULL이 하나라도 섞이면 결과가 0행이 된다.
--   (x NOT IN (1, NULL)은 참도 거짓도 아닌 UNKNOWN이라 전부 걸러진다.)
--   여기서는 ANIMAL_OUTS.ANIMAL_ID가 NULL 불가(기본키)라 안전하다.
--   NULL이 들어올 수 있는 열이면 LEFT JOIN + IS NULL이나 NOT EXISTS를 쓴다.
--   "가장 오래된 N개" = ORDER BY 오름차순 + LIMIT N.
