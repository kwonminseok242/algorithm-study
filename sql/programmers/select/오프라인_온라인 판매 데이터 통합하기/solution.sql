-- 오프라인/온라인 판매 데이터 통합하기 (Lv4)
-- 결과: 오답 → 수정 후 통과

-- 내 풀이 (오답)
-- SELECT O.SALES_DATE, O.PRODUCT_ID, O.USER_ID, O.SALES_AMOUNT
-- FROM ONLIVE_SALE AS O
-- JOIN OFFLINE_SALE AS OF ON O.PRODUCT_ID = OF.PRODUCT_ID
-- ORDER BY O.SALES_DATE ASC, O.PRODUCT_ID ASC, O.USER_ID ASC;

-- 내 풀이 (수정)
SELECT DATE_FORMAT(SALES_DATE, '%Y-%m-%d') AS SALES_DATE,
       PRODUCT_ID,
       USER_ID,
       SALES_AMOUNT
FROM ONLINE_SALE
WHERE YEAR(SALES_DATE) = 2022 AND MONTH(SALES_DATE) = 3

UNION ALL

SELECT DATE_FORMAT(SALES_DATE, '%Y-%m-%d') AS SALES_DATE,
       PRODUCT_ID,
       NULL AS USER_ID,
       SALES_AMOUNT
FROM OFFLINE_SALE
WHERE YEAR(SALES_DATE) = 2022 AND MONTH(SALES_DATE) = 3

ORDER BY SALES_DATE ASC, PRODUCT_ID ASC, USER_ID ASC;

-- 메모
-- 틀린 이유:
--   1) JOIN을 썼다. 이 문제는 UNION ALL이다. 방향을 잘못 잡은 것이 가장 큰 문제다.
--      JOIN  : 두 테이블을 "옆으로" 붙인다. 한 행에 양쪽 열이 같이 온다. 열이 늘어난다.
--      UNION : 두 결과를 "위아래로" 쌓는다. 행이 늘어난다. 열 구성은 그대로다.
--      이 문제는 온라인 판매 기록과 오프라인 판매 기록을 한 목록으로 합치는 것이다.
--      온라인 1건과 오프라인 1건은 서로 짝이 아니다. 각각 독립된 판매 기록이다.
--      PRODUCT_ID로 조인하면 같은 상품의 온라인 x 오프라인 조합이 전부 만들어져
--      판매 건수가 뻥튀기된다. "통합" "합쳐서" "같이 보여줘" 는 UNION 신호다.
--   2) UNION이 아니라 UNION ALL이다.
--      UNION은 중복 행을 지운다. 여기서는 우연히 날짜/상품/수량이 같은 판매가 있어도
--      서로 다른 판매 기록이라 지우면 안 된다. 중복 제거가 필요 없으면 UNION ALL이 맞다.
--   3) 2022년 3월 조건을 빼먹었다. 양쪽 쿼리에 각각 적어야 한다. 한쪽에만 쓰면 반만 걸러진다.
--      YEAR(...) = 2022 AND MONTH(...) = 3
--      BETWEEN '2022-03-01' AND '2022-03-31' 도 된다. (SALES_DATE가 DATE라 안전하다)
--   4) 오프라인에는 USER_ID 열이 아예 없다. 그런데 열 수와 순서를 맞춰야 한다.
--      -> NULL AS USER_ID 로 빈 열을 만들어 끼운다. 문제도 NULL로 표시하라고 했다.
--   5) 날짜 출력 형식. DATE_FORMAT(SALES_DATE, '%Y-%m-%d')
--   6) 오타와 별칭 문제.
--      ONLIVE_SALE -> ONLINE_SALE
--      AS OF 는 쓸 수 없다. OF는 MySQL 8.0의 예약어다. 별칭은 ON, OFF, OF 같은 단어를 피한다.
--      UNION에서는 별칭 자체가 필요 없다. 각 쿼리가 테이블 하나씩만 보기 때문이다.
--      그래서 O. 같은 접두사도 빼고 열 이름만 적는다.
-- 접근 방법:
--   "두 테이블의 기록을 한 목록으로" -> UNION ALL
--   양쪽 SELECT의 열 개수, 순서, 의미를 똑같이 맞춘다. 없는 열은 NULL로 채운다.
--   조건(2022년 3월)은 양쪽에 각각 쓴다.
--   ORDER BY는 전체에 한 번, 맨 끝에만 쓴다. 쌓은 결과를 정렬하는 것이라 테이블 접두사도 없다.
-- 기억해 둘 점:
--   JOIN은 옆으로, UNION은 아래로. 결과의 열이 늘어나는지 행이 늘어나는지로 고른다.
--   UNION의 열 이름은 첫 번째 쿼리를 따른다. 그래서 AS는 위쪽 쿼리에만 있어도 된다.
--   MySQL에서 NULL은 ASC일 때 맨 앞에 온다. 오프라인 행(USER_ID가 NULL)이 위로 올라온다.
--   예약어를 별칭으로 쓰면 엉뚱한 문법 에러가 난다. 의심되면 백틱 대신 다른 이름을 쓴다.
