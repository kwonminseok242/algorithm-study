-- 역순 정렬하기 (Lv1)
-- 결과: 통과 (한 번에 맞춤. 쉬웠다)

-- 내 풀이
SELECT NAME, DATETIME
FROM ANIMAL_INS
ORDER BY ANIMAL_ID DESC;

-- 메모
-- 틀린 이유: 없음.
-- 접근 방법: "이름과 보호 시작일" -> SELECT NAME, DATETIME / "ANIMAL_ID 역순" -> ORDER BY ANIMAL_ID DESC
-- 기억해 둘 점:
--   ORDER BY에는 SELECT에 없는 열도 쓸 수 있다. 여기서 ANIMAL_ID는 출력하지 않지만 정렬 기준이다.
--   (DISTINCT나 GROUP BY를 쓸 때는 예외다. 묶고 나면 그 열이 남아 있지 않아 정렬에 못 쓴다)
--   "역순"은 DESC다. 기준 열이 무엇인지만 문장에서 찾으면 된다.
