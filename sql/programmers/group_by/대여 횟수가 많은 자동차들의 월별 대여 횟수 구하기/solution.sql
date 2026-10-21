-- 대여 횟수가 많은 자동차들의 월별 대여 횟수 구하기 (Lv3)
-- 결과: 오답 → 수정

-- 내 풀이 (오답 · 10/21)
-- SELECT COUNT(T.HISTORY_ID) AS COUNTT ,T.CAR_ID,T.START_DATE, T.END_DATE,
-- FROM (SELECT HISTORY_ID,CAR_ID,START_DATE,END_DATE
--       FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
--      WHERE START_DATE>= 2022-08 AND END_DATE <= 2022-10) AS T
-- GROUP BY T.CAR_ID
-- ORDER BY COUNTT

-- 내 풀이 (수정)
SELECT MONTH(START_DATE) AS MONTH, CAR_ID, COUNT(*) AS RECORDS
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
WHERE START_DATE >= '2022-08-01' AND START_DATE < '2022-11-01'
  AND CAR_ID IN (SELECT CAR_ID
                 FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
                 WHERE START_DATE >= '2022-08-01' AND START_DATE < '2022-11-01'
                 GROUP BY CAR_ID
                 HAVING COUNT(*) >= 5)
GROUP BY MONTH, CAR_ID
ORDER BY MONTH ASC, CAR_ID DESC;

-- 메모
-- 틀린 이유:
--   1) 문제가 두 단계인데 한 단계로 풀었다.
--      ① "8~10월 대여 시작 횟수가 총 5회 이상인 자동차"를 고른다   -> CAR_ID별 COUNT, HAVING >= 5
--      ② 그 자동차들의 "월별" 대여 횟수를 센다                     -> (월, CAR_ID)별 COUNT
--      ①과 ②는 묶는 단위가 다르다(자동차 vs 자동차+월). GROUP BY 하나로는 둘 다 못 한다.
--      -> ①을 서브쿼리(IN)로 따로 구하고, 바깥에서 ②를 센다.
--      5회 이상 조건(HAVING)과 월별 그룹(MONTH)이 둘 다 빠져 있었다.
--   2) 날짜에 따옴표가 없다. 2022-08은 날짜가 아니라 뺄셈이라 2014가 된다.
--      -> '2022-08-01'처럼 따옴표 안에 날짜 전체를 쓴다.
--      10월 전체를 넣으려면 '2022-11-01' 미만(<)으로 끊는다. <= '2022-10'으로는 10월 2일 이후가 빠진다.
--   3) 기준 열이 틀렸다. 지문은 "대여 시작일 기준"이라 START_DATE만 본다.
--      END_DATE <= 10월을 걸면 10월에 시작해 11월에 반납한 대여가 빠진다.
--   4) SELECT 마지막 열 뒤에 콤마(T.END_DATE,)가 있어서 FROM 앞에서 문법 에러.
--   5) START_DATE, END_DATE는 GROUP BY 열도 집계함수도 아니다. 출력도 요구되지 않았다.
--      출력은 MONTH, CAR_ID, RECORDS 세 열이고 순서도 이대로다.
--   6) 정렬은 월 오름차순, 같으면 자동차 ID 내림차순이다. 횟수로 정렬하지 않는다.
-- 접근 방법:
--   ① 서브쿼리: 기간 안 대여만 남김 -> CAR_ID로 묶음 -> HAVING COUNT(*) >= 5 -> CAR_ID 목록
--   ② 바깥: 기간 안 대여 중 ①에 든 차만 -> MONTH(START_DATE), CAR_ID로 묶음 -> COUNT(*)
--   기간 조건은 서브쿼리와 바깥 둘 다에 건다.
--     서브쿼리에만 걸면 7월·11월 대여까지 월별 집계에 섞이고,
--     바깥에만 걸면 기간 밖 대여까지 5회에 포함된다.
--   대여 기록이 없는 달은 행이 안 생기니 "0회인 달 제외"는 따로 처리할 필요가 없다.
-- 기억해 둘 점:
--   지문에 "~인 대상의 ~별 값"이 있으면 두 단계다. 대상 고르기(GROUP BY + HAVING)를 IN 서브쿼리로 분리.
--   (그룹별 조건에 맞는 식당 목록·물고기 대어와 같은 "고르기 / 보여주기 분리" 구조)
--   날짜 리터럴은 항상 따옴표. 월 단위 범위는 >= 'YYYY-MM-01' AND < '다음달-01'.
--   SELECT 마지막 열 뒤 콤마는 에러.
