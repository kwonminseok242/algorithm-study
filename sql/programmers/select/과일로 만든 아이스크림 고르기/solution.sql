-- 과일로 만든 아이스크림 고르기 (Lv1)
-- 결과: 통과

-- 내 풀이
SELECT FLAVOR
FROM FIRST_HALF
WHERE TOTAL_ORDER > 3000
  AND FLAVOR IN (
      SELECT FLAVOR
      FROM ICECREAM_INFO
      WHERE INGREDIENT_TYPE = 'fruit_based'
  )
ORDER BY TOTAL_ORDER DESC;

-- 다른 풀이 (JOIN)
-- SELECT H.FLAVOR
-- FROM FIRST_HALF AS H
-- JOIN ICECREAM_INFO AS I ON H.FLAVOR = I.FLAVOR
-- WHERE H.TOTAL_ORDER > 3000 AND I.INGREDIENT_TYPE = 'fruit_based'
-- ORDER BY H.TOTAL_ORDER DESC;

-- 메모
-- 틀린 이유: 없음. (처음 적을 때 서브쿼리의 SELECT 뒤 열 이름이 비어 있었다)
-- 접근 방법:
--   조건이 두 테이블에 나뉘어 있다. 총주문량은 FIRST_HALF, 성분은 ICECREAM_INFO에 있다.
--   보여줄 열이 FIRST_HALF에만 있으니, 다른 테이블은 "맛 목록"으로만 쓰면 된다.
--   -> FLAVOR IN (ICECREAM_INFO에서 fruit_based인 FLAVOR들)
--   "총주문량이 큰 순서대로" -> ORDER BY TOTAL_ORDER DESC
-- 고친 과정:
--   처음에는 = 로 썼다가 IN으로 바꿨다.  FLAVOR = (SELECT ...) -> FLAVOR IN (SELECT ...)
--   fruit_based인 맛이 여러 개라서 서브쿼리가 여러 행을 내놓는다. = 는 값 하나하고만
--   비교하는 연산자라 이때 "Subquery returns more than 1 row" 에러가 난다.
--   서브쿼리가 내놓는 행이 몇 개인지 보고 고른다.
--     여러 행일 수 있다 -> IN   (목록 안에 있는지 확인)
--     반드시 한 행이다  -> =    (MAX, MIN, COUNT 같은 집계는 GROUP BY가 없으면 한 행)
--   행이 하나뿐이어도 IN은 그대로 동작한다. 헷갈리면 IN이 안전하다.
-- 기억해 둘 점:
--   WHERE 열 IN (서브쿼리)의 서브쿼리는 열을 딱 하나만 내놔야 한다.
--   비교하는 쪽(FLAVOR)과 서브쿼리가 내놓는 열(FLAVOR)이 짝이 맞아야 한다.
--   JOIN으로도 같은 답이 나온다. 다른 테이블의 열을 결과에 보여줄 필요가 없고
--   조건으로만 쓸 때는 IN 서브쿼리가 짧다. 보여줄 열이 생기면 JOIN으로 간다.
