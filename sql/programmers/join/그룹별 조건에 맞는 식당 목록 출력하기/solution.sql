-- 그룹별 조건에 맞는 식당 목록 출력하기 (Lv4)
-- 결과: 오답 → 수정

-- 내 풀이 (오답 · 10/21)
-- SELECT TBL.MEMBER_NAME, TBL.REVIEW_TEXT, TBL.REVIEW_DATE
-- FROM (SELECT A.MEMBER_NAME, B.REVIEW_TEXT, B.REVIEW_DATE, COUNT(B.REVIEW_ID) AS CNT
--      FROM MEMBER_PROFILE AS A
--      INNER JOIN REST_REVIEW AS B
--      ON A.MEMBER_ID = B.MEMBER_ID
--      GROUP BY A.MEMBER_ID) AS TBL
-- WHERE TBL.CNT = MAX(TBL.CNT)
-- ORDER BY TBL.REVIEW_DATE ASC, TBL.REVIEW_TEXT ASC

-- 내 풀이 (수정)
SELECT M.MEMBER_NAME, R.REVIEW_TEXT, DATE_FORMAT(R.REVIEW_DATE, '%Y-%m-%d') AS REVIEW_DATE
FROM MEMBER_PROFILE AS M
JOIN REST_REVIEW AS R ON M.MEMBER_ID = R.MEMBER_ID
WHERE R.MEMBER_ID IN (SELECT MEMBER_ID
                      FROM REST_REVIEW
                      GROUP BY MEMBER_ID
                      HAVING COUNT(*) = (SELECT MAX(CNT)
                                         FROM (SELECT COUNT(*) AS CNT
                                               FROM REST_REVIEW
                                               GROUP BY MEMBER_ID) AS T))
ORDER BY R.REVIEW_DATE ASC, R.REVIEW_TEXT ASC;

-- 메모
-- 틀린 이유:
--   1) WHERE에 집계함수 MAX()를 썼다 -> "Invalid use of group function" 에러.
--      WHERE는 행 하나씩 보면서 거르는 단계라 "전체 중 최댓값"을 모른다.
--      최댓값은 서브쿼리로 따로 구해서 값으로 비교해야 한다: = (SELECT MAX(CNT) FROM ...)
--   2) 핵심: GROUP BY MEMBER_ID를 하면 회원마다 1행으로 줄어든다.
--      문제는 리뷰를 가장 많이 쓴 회원의 "리뷰 전부"를 출력하라는 것인데,
--      묶은 뒤에는 REVIEW_TEXT, REVIEW_DATE가 그 회원의 리뷰 중 아무거나 하나만 남는다.
--      (집계 안 한 열이라 ONLY_FULL_GROUP_BY면 에러.) 10/19 물고기 대어와 같은 원인이다.
--      -> 세는 일(누가 최다인가)과 보여주는 일(그 회원의 리뷰 전부)을 나눈다.
--   3) 예시 출력의 리뷰 작성일이 2022-04-12처럼 날짜만 있다 -> DATE_FORMAT(..., '%Y-%m-%d')
-- 접근 방법:
--   ① 회원별 리뷰 수:            SELECT COUNT(*) AS CNT FROM REST_REVIEW GROUP BY MEMBER_ID
--   ② 그중 최댓값:               SELECT MAX(CNT) FROM (①) AS T
--   ③ 리뷰 수가 ②와 같은 회원:   SELECT MEMBER_ID ... GROUP BY MEMBER_ID HAVING COUNT(*) = (②)
--   ④ 원본에서 ③ 회원의 리뷰 전부 + 이름 JOIN -> 날짜, 내용 순 정렬
--   공동 1등이 여러 명이어도 IN이라 전부 나온다.
-- 다른 풀이 (윈도우 함수 — 10/20 물고기 재풀이와 같은 도구):
--   SELECT M.MEMBER_NAME, R.REVIEW_TEXT, DATE_FORMAT(R.REVIEW_DATE, '%Y-%m-%d') AS REVIEW_DATE
--   FROM MEMBER_PROFILE AS M
--   JOIN REST_REVIEW AS R ON M.MEMBER_ID = R.MEMBER_ID
--   WHERE R.MEMBER_ID IN (SELECT MEMBER_ID
--                         FROM (SELECT MEMBER_ID, RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
--                               FROM REST_REVIEW
--                               GROUP BY MEMBER_ID) AS T
--                         WHERE RNK = 1)
--   ORDER BY R.REVIEW_DATE, R.REVIEW_TEXT;
--   GROUP BY로 회원별 1행을 만든 뒤 그 위에서 RANK()로 순위를 매긴다(윈도우는 GROUP BY 다음에 계산).
--   ORDER BY COUNT(*) DESC LIMIT 1로 최다 회원을 고르면 공동 1등 중 한 명만 나와서 위험하다.
-- 기억해 둘 점:
--   WHERE에는 집계함수를 못 쓴다. 그룹 결과로 거르면 HAVING, 전체 최댓값과 비교하면 서브쿼리.
--   "최다/최대인 대상의 상세 행 전부"는 GROUP BY 한 번으로 안 된다.
--   대상 고르기(GROUP BY + 최댓값)와 상세 보여주기(원본 + IN)를 나눈다.
