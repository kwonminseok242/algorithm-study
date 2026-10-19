-- 물고기 종류 별 대어 찾기 (Lv3)
-- 결과: 오답 → 수정

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
