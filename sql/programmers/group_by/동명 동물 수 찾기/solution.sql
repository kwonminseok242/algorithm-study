-- 동명 동물 수 찾기 (Lv2)
-- 결과: 오답 → 수정

-- 내 풀이 (오답)
-- SELECT NAME, `COUNT`
-- FROM (SELECT NAME,COUNT(*) AS 'COUNT'
--      FROM ANIMAL_INS
--      GROUP BY NAME
--      ORDER BY NAME) AS P
-- WHERE `COUNT` >= 2

-- 내 풀이 (수정)
SELECT NAME, COUNT(*) AS COUNT
FROM ANIMAL_INS
WHERE NAME IS NOT NULL
GROUP BY NAME
HAVING COUNT(*) >= 2
ORDER BY NAME;

-- 메모
-- 틀린 이유:
--   1) 이름이 없는(NULL) 동물을 빼지 않았다. 문제에 "이름이 없는 동물은 집계에서 제외"가 있다.
--      GROUP BY NAME은 NULL끼리도 한 그룹으로 묶고, COUNT(*)는 그 행들을 다 센다.
--      이름 없는 동물이 2마리 이상이면 결과에 NULL | 3 같은 행이 끼어 오답이 된다.
--      -> WHERE NAME IS NOT NULL 로 묶기 전에 걸러낸다.
--   2) ORDER BY를 서브쿼리 안에 두었다.
--      FROM (서브쿼리) 안의 정렬은 바깥 결과의 순서를 보장하지 않는다(MySQL이 무시할 수 있다).
--      최종 정렬은 항상 가장 바깥 쿼리의 마지막에 쓴다.
-- 접근 방법:
--   서브쿼리로 집계한 뒤 바깥에서 WHERE로 거르는 생각 자체는 맞다. 다만 그게 바로 HAVING이 하는 일이다.
--     FROM (... GROUP BY ...) AS P WHERE `COUNT` >= 2
--     == GROUP BY ... HAVING COUNT(*) >= 2
--   순서: NULL 이름 거르기(WHERE) -> 이름으로 묶기 -> 2번 이상만 남기기(HAVING) -> 이름순 정렬
-- 다른 풀이:
--   WHERE 없이 HAVING COUNT(NAME) >= 2 로 써도 된다.
--   COUNT(NAME)은 NULL을 세지 않아서 NULL 그룹은 0이 되어 걸러진다.
--   단, 이때 SELECT도 COUNT(NAME)으로 맞춘다. 의도가 덜 드러나니 WHERE IS NOT NULL 쪽이 읽기 쉽다.
-- 기억해 둘 점:
--   집계 결과로 거르는 건 HAVING. 서브쿼리 + 바깥 WHERE로 돌아갈 필요 없다.
--   GROUP BY는 NULL도 한 그룹으로 만든다. "없는 건 제외"가 있으면 WHERE ... IS NOT NULL.
--   COUNT(*)는 NULL 포함 행 수, COUNT(열)은 그 열이 NULL이 아닌 행 수.
--   ORDER BY는 맨 바깥 쿼리 끝에.
