-- 가격이 제일 비싼 식품의 정보 출력하기 (Lv2)
-- 결과: 오답 → 수정

-- 내 풀이 (오답)
-- SELECT PRODUCT_ID, PRODUCT_NAME, PRODUCT_CD, CATEGORY, PRICE
-- FROM FOOD_PRODUCT
-- WHERE PRICE = (SELECT MAX(PRICE)
--                FROM FOOD_PRODUCT
--                GROUP BY PRICE)

-- 내 풀이 (수정)
SELECT PRODUCT_ID, PRODUCT_NAME, PRODUCT_CD, CATEGORY, PRICE
FROM FOOD_PRODUCT
WHERE PRICE = (SELECT MAX(PRICE)
               FROM FOOD_PRODUCT);

-- 메모
-- 틀린 이유:
--   서브쿼리에 GROUP BY PRICE를 붙여서 "가격별 최댓값"이 여러 행 나왔다.
--   가격이 1000, 2000, 3000인 상품이 있으면 그룹이 3개 생기고,
--   각 그룹의 MAX(PRICE)는 자기 자신이라 1000, 2000, 3000 세 행이 돌아온다.
--   WHERE PRICE = (...)의 =는 값 하나와만 비교할 수 있어서
--   "Subquery returns more than 1 row" 에러가 난다.
-- 접근 방법:
--   "집계함수를 쓰려면 GROUP BY가 필요하다"는 반만 맞다.
--     GROUP BY 없음 -> 테이블 전체가 한 그룹 -> 결과 1행 (전체 최댓값)
--     GROUP BY 열   -> 열 값마다 한 그룹 -> 결과 여러 행 (그룹별 최댓값)
--   GROUP BY가 필요한 건 SELECT에 집계 안 한 열을 같이 적을 때다.
--   여기서는 전체에서 제일 비싼 가격 하나만 필요하니 GROUP BY 없이 MAX(PRICE)만 쓴다.
--   그 값과 같은 행을 바깥 쿼리에서 찾으면 그 상품의 모든 열을 꺼낼 수 있다.
-- 다른 풀이:
--   SELECT * FROM FOOD_PRODUCT ORDER BY PRICE DESC LIMIT 1;
--   이 문제는 최댓값이 하나라 통과하지만, 같은 최고가가 여러 개면 하나만 나온다.
--   서브쿼리 방식은 공동 1등까지 전부 나온다.
-- 기억해 둘 점:
--   SELECT MAX(...) FROM 테이블  -> GROUP BY 없이도 된다. 결과는 항상 1행.
--   = (서브쿼리)는 서브쿼리가 1행일 때만. 여러 행이면 IN (서브쿼리).
--   GROUP BY 기준 열에 MAX를 걸면(GROUP BY PRICE + MAX(PRICE)) 의미가 없다. 각 그룹 값 그대로다.
