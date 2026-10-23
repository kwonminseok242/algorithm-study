-- 조건에 맞는 사원 정보 조회하기 (Lv2)
-- 결과: 오답 → 수정

-- 내 풀이 (오답 · 10/22)
-- SELECT H.SCORE, E.EMP_NO, E.EMP_NAME,E.POSITION, E.EMAIL
-- FROM HR_EMPLOYEES AS E
-- INNER JOIN HR_GRADE AS H
-- ON E.EMP_NO = H.EMP_NO
-- WHERE E.EMP_NO IN (SELECT EMP_NO, RANK() OVER (ORDER BY SCORE)
--                 FROM HR_GRADE
--                 GROUP BY EMP_NO
--                 WHERE YEAR = 2022) AND H.YEAR = 2022

-- 내 풀이 (수정)
SELECT SUM(G.SCORE) AS SCORE, E.EMP_NO, E.EMP_NAME, E.POSITION, E.EMAIL
FROM HR_EMPLOYEES AS E
JOIN HR_GRADE AS G ON E.EMP_NO = G.EMP_NO
WHERE G.YEAR = 2022
GROUP BY E.EMP_NO, E.EMP_NAME, E.POSITION, E.EMAIL
ORDER BY SCORE DESC
LIMIT 1;

-- 메모
-- 틀린 이유:
--   1) 점수는 상·하반기 2행이다. 지문의 SCORE는 "2022년 상·하반기 점수의 합"이다.
--      H.SCORE를 그대로 꺼내면 사원마다 반기 점수 2행이 나온다 -> 사원별 SUM(SCORE)로 묶어야 한다.
--      서브쿼리의 RANK()도 SCORE(반기 점수 한 개)로 순위를 매겨서 합계 기준이 아니었다.
--   2) IN (서브쿼리)는 열 1개만 돌려줘야 한다. EMP_NO, RANK() 두 열이라 "Operand should contain 1 column(s)" 에러.
--   3) 절 순서가 틀렸다. WHERE는 GROUP BY보다 앞에 온다.
--      FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY -> LIMIT
--   4) RANK() OVER (ORDER BY SCORE)는 오름차순이라 점수가 "낮은" 사람이 1등이 된다. 최고점이면 DESC.
--   5) 순위를 매기기만 하고 1등만 고르는 조건(RNK = 1)이 없다.
--      IN 안에 순위를 넣는다고 1등만 걸러지지 않는다. 순위는 바깥에서 WHERE RNK = 1로 골라야 의미가 있다.
-- 접근 방법:
--   2022년 행만 남김(WHERE) -> 사원별로 묶어 SUM(SCORE) -> 합계 큰 순 -> 1명(LIMIT 1).
--   이름·직책·이메일은 HR_EMPLOYEES에 있으니 EMP_NO로 JOIN.
--   지문에 "최고점 사원은 1명"이라 LIMIT 1로 충분하다.
-- 다른 풀이 (공동 1등까지 안전 — RANK):
--   SELECT SCORE, EMP_NO, EMP_NAME, POSITION, EMAIL
--   FROM (SELECT SUM(G.SCORE) AS SCORE, E.EMP_NO, E.EMP_NAME, E.POSITION, E.EMAIL,
--                RANK() OVER (ORDER BY SUM(G.SCORE) DESC) AS RNK
--         FROM HR_EMPLOYEES AS E
--         JOIN HR_GRADE AS G ON E.EMP_NO = G.EMP_NO
--         WHERE G.YEAR = 2022
--         GROUP BY E.EMP_NO, E.EMP_NAME, E.POSITION, E.EMAIL) AS T
--   WHERE RNK = 1;
--   RANK()는 GROUP BY 다음에 계산되니 OVER (ORDER BY SUM(...))처럼 집계값으로 순위를 매길 수 있다.
--   RANK()를 떠올린 방향은 맞았다. 위치(바깥에서 = 1)와 기준(합계, DESC)만 고치면 된다.
-- 기억해 둘 점:
--   IN (서브쿼리)는 열 1개. 두 열을 비교하려면 (A, B) IN (SELECT A, B ...).
--   WHERE는 GROUP BY 앞. 순서를 외우기: FROM WHERE GROUP HAVING SELECT ORDER LIMIT.
--   RANK/ROW_NUMBER로 1등 고르기 = 서브쿼리에서 순위 계산 -> 바깥에서 WHERE RNK = 1.
--   "합계가 가장 큰" = GROUP BY + SUM + ORDER BY DESC (+ LIMIT 또는 RANK).
