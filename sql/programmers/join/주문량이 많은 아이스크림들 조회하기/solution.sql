-- 주문량이 많은 아이스크림들 조회하기 (Lv4)
-- 결과: 오답 (미완성) → 수정

-- 내 풀이 (오답 · 10/21 — 조인까지만 짜고 멈춤)
-- 계획: 조인하고 맛대로 그룹하고 TOTAL_ORDER 합치고 상위 3개
-- SELECT F.SHIPMENT_ID,J.SHIPMENT_ID, F.FLAVOR, F.TOTAL_ORDER,J.FLAVOR,J.TOTAL_ORDER
-- FROM FIRST_HALF AS F
-- INNER JOIN JULY AS J
-- ON F.FLAVOR = J.FLAVOR

-- 내 풀이 (수정)
SELECT F.FLAVOR
FROM FIRST_HALF AS F
JOIN (SELECT FLAVOR, SUM(TOTAL_ORDER) AS JULY_TOTAL
      FROM JULY
      GROUP BY FLAVOR) AS J
  ON F.FLAVOR = J.FLAVOR
ORDER BY F.TOTAL_ORDER + J.JULY_TOTAL DESC
LIMIT 3;

-- 메모
-- 틀린 이유:
--   1) 계획("조인 -> 맛으로 그룹 -> 합치기")대로 가면 상반기 주문량이 여러 번 더해진다.
--      FIRST_HALF는 맛 하나에 1행(FLAVOR가 기본키),
--      JULY는 같은 맛이 출하번호만 달리해서 여러 행이다(맛 하나에 N행).
--      1:N으로 조인하면 FIRST_HALF 행이 JULY 행 수만큼 복제된다.
--        FIRST_HALF: 딸기 | 3100
--        JULY:       딸기 | 520,  딸기 | 400
--        조인 결과:   딸기 | 3100 | 520
--                    딸기 | 3100 | 400
--        SUM(F.TOTAL_ORDER + J.TOTAL_ORDER) = 3100*2 + 920 = 7120   (정답은 3100 + 920 = 4020)
--      "맛이 같아도 출하번호는 다르다"를 알아챈 것 자체는 맞았다. 그게 바로 복제의 원인이다.
--   2) 출력은 맛(FLAVOR) 하나뿐인데 SHIPMENT_ID, TOTAL_ORDER까지 꺼냈다.
--      확인용 쿼리였다면 괜찮지만 제출할 때는 문제가 요구한 열만 남긴다.
--   3) 정렬(합계 큰 순)과 LIMIT 3까지 가지 못했다.
-- 접근 방법:
--   N쪽(JULY)을 먼저 맛별로 1행이 되게 줄인 다음 조인한다.
--     ① JULY를 맛별 합계로:  SELECT FLAVOR, SUM(TOTAL_ORDER) FROM JULY GROUP BY FLAVOR
--     ② FIRST_HALF와 ①을 맛으로 조인 -> 이제 양쪽 다 맛 하나에 1행이라 복제가 없다.
--     ③ 상반기 + 7월 합계 큰 순으로 정렬 -> LIMIT 3
--   ORDER BY에 식(F.TOTAL_ORDER + J.JULY_TOTAL)을 바로 써도 된다. SELECT에 안 꺼내도 정렬은 된다.
-- 다른 풀이 (UNION ALL로 세로로 쌓기):
--   SELECT FLAVOR
--   FROM (SELECT FLAVOR, TOTAL_ORDER FROM FIRST_HALF
--         UNION ALL
--         SELECT FLAVOR, TOTAL_ORDER FROM JULY) AS T
--   GROUP BY FLAVOR
--   ORDER BY SUM(TOTAL_ORDER) DESC
--   LIMIT 3;
--   두 테이블 열 구성이 같으니 조인 대신 위아래로 붙인 뒤 맛별로 한 번에 더한다. 복제 걱정이 없다.
--   UNION은 중복 행을 지우니(같은 맛·같은 주문량이면 하나가 사라짐) 반드시 UNION ALL.
-- 기억해 둘 점:
--   1:N 조인 후 1쪽의 값을 SUM하면 N배로 부풀려진다.
--   조인하기 전에 "양쪽이 키 하나에 몇 행인가"를 먼저 본다. N행인 쪽은 GROUP BY로 1행으로 줄여서 조인.
--   테이블 두 개의 값을 "더하기"만 하면 되는 문제는 UNION ALL + GROUP BY도 후보다.
