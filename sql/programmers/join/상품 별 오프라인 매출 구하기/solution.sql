-- 상품 별 오프라인 매출 구하기 (Lv2)
-- 결과: 풀이 맞음 (제출 결과 미확인)

-- 내 풀이 (10/20)
SELECT P.PRODUCT_CODE, SUM(O.SALES_AMOUNT*P.PRICE)AS SALES
FROM PRODUCT AS P
INNER JOIN OFFLINE_SALE AS O
ON P.PRODUCT_ID = O.PRODUCT_ID
GROUP BY P.PRODUCT_CODE
ORDER BY `SALES` DESC, P.PRODUCT_CODE ASC

-- 메모
-- 틀린 이유: 없음. 조인 키, 그룹 키, 집계식, 정렬 2단계가 전부 맞다.
-- 접근 방법:
--   매출 = 판매량 × 판매가. 판매량은 OFFLINE_SALE, 판매가는 PRODUCT에 있어서 PRODUCT_ID로 JOIN.
--   "상품코드 별"이니 GROUP BY P.PRODUCT_CODE, 묶음마다 SUM(판매량 × 판매가).
--   정렬: 매출 내림차순, 같으면 상품코드 오름차순.
--   SUM(O.SALES_AMOUNT) * P.PRICE 가 아니라 SUM(O.SALES_AMOUNT * P.PRICE)로 곱한 뒤 더했다.
--     같은 상품이면 가격이 같아 결과는 같지만, 곱한 뒤 더하는 쪽이 어떤 경우에도 맞다.
--     (앞의 형태는 P.PRICE가 GROUP BY 열이 아니라 ONLY_FULL_GROUP_BY에서 에러가 날 수 있다.)
-- 다듬을 점:
--   SUM(...)AS SALES 처럼 괄호와 AS 사이 공백이 없어도 동작한다. 읽기 쉽게 한 칸 띄우면 좋다.
--   SALES는 영어 별칭이라 백틱 없이 ORDER BY SALES DESC로 써도 된다.
--   백틱이 꼭 필요한 건 한글·숫자로 시작하는 별칭(`5월예약건수`)이나 예약어와 겹칠 때다.
--   어제 진료과별 예약에서 틀린 "별칭 정렬"을 이번엔 백틱으로 바르게 썼다.
