-- 동물의 아이디와 이름 (Lv1)
-- 결과: 통과 (한 번에 맞춤. 쉬웠다)

-- 내 풀이
SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;

-- 메모
-- 틀린 이유: 없음. 조건 없이 열 두 개와 정렬만 있는 문제다.
-- 기억해 둘 점:
--   ORDER BY에서 방향을 안 쓰면 ASC다. "ANIMAL_ID순"처럼 방향 말이 없으면 오름차순이다.
