-- 진료과별 총 예약 횟수 출력하기 (Lv2)
-- 결과: 오답 → 수정

-- 내 풀이 (오답)
-- SELECT P.APNT_NO, P.MCDP_CD
-- FROM APPOINTMENT AS P
-- WHERE APNT_CNCL_YN <> 'N' AND APNT_YMD(YYYY-MM) = '2022-05'
-- GROUP BY P.MCDP_CD

-- 내 풀이 (수정)
SELECT MCDP_CD AS `진료과코드`, COUNT(*) AS `5월예약건수`
FROM APPOINTMENT
WHERE APNT_YMD >= '2022-05-01' AND APNT_YMD < '2022-06-01'
GROUP BY MCDP_CD
ORDER BY `5월예약건수` ASC, `진료과코드` ASC;

-- 메모
-- 틀린 이유:
--   1) 날짜에서 연-월만 꺼내는 문법이 없다. APNT_YMD(YYYY-MM)은 "APNT_YMD라는 함수 호출"로 읽혀 에러.
--      2022년 5월을 고르는 방법은 셋 중 하나다.
--        DATE_FORMAT(APNT_YMD, '%Y-%m') = '2022-05'
--        YEAR(APNT_YMD) = 2022 AND MONTH(APNT_YMD) = 5
--        APNT_YMD >= '2022-05-01' AND APNT_YMD < '2022-06-01'   -- 범위. 6월 1일 "미만"이라 5/31 저녁도 포함
--   2) 취소 조건을 문제에 없는데 넣었고, 방향도 반대였다.
--      APNT_CNCL_YN <> 'N'은 "취소된 예약만"이다. 문제는 취소 여부를 따지지 않으니 조건 자체를 뺀다.
--      (취소 안 된 것만 셀 때는 = 'N'. 이 열은 NULL 허용이라 <> 'N'은 NULL 행도 빠진다.)
--   3) 무엇을 출력할지가 빠졌다. 진료과별 "건수"를 내야 하니 COUNT(*)가 있어야 한다.
--      APNT_NO는 GROUP BY 열도 집계함수도 아니라 그룹 안 어느 값인지 정해지지 않는다.
--   4) 컬럼명 지정(AS)과 ORDER BY가 없다.
-- 접근 방법:
--   "~별로 몇 건" = GROUP BY 기준열 + COUNT(*)
--   WHERE로 5월 행만 남김 -> MCDP_CD로 묶음 -> 묶음마다 COUNT(*)
--   정렬: 건수 오름차순, 같으면 진료과코드 오름차순.
-- 기억해 둘 점:
--   한글이나 숫자로 시작하는 별칭은 백틱(`)으로 감싼다. AS `5월예약건수`
--   ORDER BY에서 별칭을 '작은따옴표'로 쓰면 문자열 상수가 되어 정렬이 안 된다. 백틱으로 쓴다.
--   문제 문장은 '진료과 코드'(띄어쓰기)인데 예시 출력은 '진료과코드'다. 채점은 예시 출력을 따른다.
--   문제에 없는 조건(취소 여부 등)을 스스로 추가하지 않는다. 테이블에 열이 있다고 다 쓰는 게 아니다.
