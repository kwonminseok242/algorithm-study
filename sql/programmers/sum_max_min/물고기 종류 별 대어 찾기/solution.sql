-- 물고기 종류 별 대어 찾기 (Lv3)
-- 결과: 10/19 오답 → 수정 / 10/20 재풀이 (윈도우 함수)

-- 내 풀이 (오답)
-- SELECT ID, FISH_NAME , MAX(LENGTH)
-- FROM(SELECT ID,FISH_NAME, LENGHT,FISH_TYPE
-- 	FROM FISH_INFO AS F LEFT OUTER JOIN FISH_NAME_INFO AS FN ON F.FISH_TYPE = FN.FISH_TYPE)
-- GROUP BY FISH_TYPE
-- ORDER BY ID

-- 내 풀이 (수정)
SELECT F.ID, N.FISH_NAME, F.LENGTH
FROM FISH_INFO AS F
JOIN FISH_NAME_INFO AS N ON F.FISH_TYPE = N.FISH_TYPE
WHERE (F.FISH_TYPE, F.LENGTH) IN (SELECT FISH_TYPE, MAX(LENGTH)
                                  FROM FISH_INFO
                                  GROUP BY FISH_TYPE)
ORDER BY F.ID;

-- 내 풀이 (10/20 재풀이 · RANK)
-- SELECT A.ID, A.FISH_NAME, A.LENGTH
-- FROM (SELECT T.ID, T.FISH_NAME, T.LENGTH,T.TIME,T.FISH_TYPE,RANK() OVER(PARTITION BY T.FISH_TYPE ORDER BY T.LENGTH DESC) AS RNK
--     FROM (SELECT FI.ID, FI.FISH_TYPE, FI.LENGTH, FI.TIME, FNI.FISH_NAME
--         FROM FISH_INFO AS FI
--         INNER JOIN FISH_NAME_INFO AS FNI
--         ON FI.FISH_TYPE = FNI.FISH_TYPE) AS T) AS A
-- WHERE A.RNK = 1
-- ORDER BY A.ID

-- 같은 풀이를 한 겹 줄이면
SELECT ID, FISH_NAME, LENGTH
FROM (SELECT FI.ID, FNI.FISH_NAME, FI.LENGTH,
             RANK() OVER (PARTITION BY FI.FISH_TYPE ORDER BY FI.LENGTH DESC) AS RNK
      FROM FISH_INFO AS FI
      JOIN FISH_NAME_INFO AS FNI ON FI.FISH_TYPE = FNI.FISH_TYPE) AS A
WHERE RNK = 1
ORDER BY ID;

-- 메모
-- 틀린 이유:
--   1) 핵심: GROUP BY + MAX로는 "최댓값을 가진 행"을 꺼낼 수 없다.
--      GROUP BY FISH_TYPE을 하면 종류마다 1행으로 줄어든다.
--      MAX(LENGTH)는 그 그룹의 가장 긴 길이를 정확히 구하지만,
--      같이 적은 ID, FISH_NAME은 집계가 안 된 열이라 그룹 안 어느 행 값이 나올지 정해져 있지 않다.
--      (MySQL 기본 설정 ONLY_FULL_GROUP_BY면 아예 에러.)
--      즉 "가장 긴 길이"와 "그 물고기의 ID"가 짝이 맞는다는 보장이 없다.
--   2) FROM (서브쿼리) 뒤에 별칭이 없다. MySQL에서는 파생 테이블 별칭이 필수라 에러.
--      FROM (SELECT ...) AS T
--   3) 서브쿼리 SELECT의 FISH_TYPE이 두 테이블에 다 있어서 어느 쪽인지 모호하다(ambiguous 에러).
--      조인 뒤 겹치는 열은 F.FISH_TYPE처럼 테이블 별칭을 붙인다.
--   4) LENGHT 오타(LENGTH). 그리고 출력 열 이름이 MAX(LENGTH)가 되니 AS LENGTH가 필요하다.
--   5) LEFT OUTER JOIN은 필요 없다. 모든 물고기는 종류 이름이 있으니 INNER JOIN이면 된다.
-- 접근 방법:
--   두 단계로 나눈다.
--     ① 종류별 최대 길이 구하기:  SELECT FISH_TYPE, MAX(LENGTH) FROM FISH_INFO GROUP BY FISH_TYPE
--     ② 원본에서 (종류, 길이)가 ①과 같은 행 찾기 -> 그 행의 ID를 그대로 쓸 수 있다.
--   ②는 (열1, 열2) IN (서브쿼리) 로 두 값을 한 번에 비교한다.
--   이름은 FISH_NAME_INFO와 조인해서 가져온다.
-- 다른 풀이 (파생 테이블과 조인):
--   SELECT F.ID, N.FISH_NAME, F.LENGTH
--   FROM FISH_INFO AS F
--   JOIN (SELECT FISH_TYPE, MAX(LENGTH) AS MAX_LEN
--         FROM FISH_INFO GROUP BY FISH_TYPE) AS M
--     ON F.FISH_TYPE = M.FISH_TYPE AND F.LENGTH = M.MAX_LEN
--   JOIN FISH_NAME_INFO AS N ON F.FISH_TYPE = N.FISH_TYPE
--   ORDER BY F.ID;
-- 기억해 둘 점:
--   "그룹별 최댓값을 가진 행"은 GROUP BY 한 번으로 안 된다. 최댓값을 구하고 원본과 다시 맞춘다.
--   GROUP BY 쿼리의 SELECT에는 GROUP BY 열 아니면 집계함수만 적는다.
--   LENGTH가 NULL(10cm 이하)인 행은 MAX가 무시하고, IN 비교에서도 걸리지 않는다.
--
-- 10/20 재풀이 — 어제와 비교:
--   어제: GROUP BY FISH_TYPE + MAX(LENGTH)에 ID를 같이 적었다.
--         그룹이 1행으로 줄어드니 ID가 최댓값 물고기의 것이라는 보장이 없었다.
--   오늘: RANK() OVER (PARTITION BY FISH_TYPE ORDER BY LENGTH DESC)
--         윈도우 함수는 행을 줄이지 않는다. 모든 물고기 행이 그대로 남고 "종류 안에서 몇 등"만 붙는다.
--         그래서 RNK = 1인 행의 ID, 이름, 길이가 한 행에서 짝이 맞는다. 어제 틀린 원인을 정확히 피했다.
--   어제 나온 문법 실수(파생 테이블 별칭 없음, ambiguous, LENGHT 오타)도 오늘은 하나도 없다.
--     AS T, AS A 별칭을 붙였고 열마다 FI. / FNI. / T.를 붙였다.
--   다듬을 점:
--     - 서브쿼리 T는 없어도 된다. 조인한 FROM 절에서 바로 RANK()를 쓸 수 있다(위 "한 겹 줄이면").
--       윈도우 함수를 WHERE에 바로 못 쓰니 바깥 한 겹(A)은 필요하다.
--     - TIME, FISH_TYPE은 바깥에서 안 쓰니 안쪽 SELECT에서 빼도 된다.
--   RANK vs ROW_NUMBER:
--     RANK는 공동 1등이 있으면 둘 다 1. ROW_NUMBER는 하나만 1.
--     "그룹별 최댓값을 가진 행을 전부" 내라는 문제라면 RANK(또는 IN 방식)가 맞다.
--     이 문제는 종류별 최댓값이 1마리뿐이라 둘 다 통과한다.
--   LENGTH가 NULL(10cm 이하)이면 MySQL은 DESC 정렬에서 NULL을 맨 뒤로 보내니 1등이 되지 않는다.
--   세 가지 풀이 정리 (전부 "그룹별 최댓값 행" = 마라톤 기출 유형):
--     ① (FISH_TYPE, LENGTH) IN (SELECT FISH_TYPE, MAX(LENGTH) ... GROUP BY FISH_TYPE)
--     ② 최댓값 파생 테이블과 JOIN ... ON 종류 AND 길이   ← 그룹 키를 조인 조건에 전부
--     ③ RANK() / ROW_NUMBER() OVER (PARTITION BY 그룹 ORDER BY 값 DESC) 후 바깥에서 = 1
