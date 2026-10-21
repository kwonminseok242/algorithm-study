-- 있었는데요 없었습니다 (Lv3)
-- 결과: 풀이 방향 맞음 (제출 결과 미확인 — 부등호 하나 확인 필요)

-- 내 풀이 (10/21)
-- SELECT A.ANIMAL_ID, B.NAME
-- FROM ANIMAL_INS AS A
-- INNER JOIN ANIMAL_OUTS AS B
-- ON A.ANIMAL_ID = B.ANIMAL_ID
-- WHERE B.DATETIME <= A.DATETIME
-- ORDER BY A.DATETIME

-- 내 풀이 (부등호 수정)
SELECT A.ANIMAL_ID, A.NAME
FROM ANIMAL_INS AS A
JOIN ANIMAL_OUTS AS B ON A.ANIMAL_ID = B.ANIMAL_ID
WHERE B.DATETIME < A.DATETIME
ORDER BY A.DATETIME;

-- 메모
-- 틀린 이유:
--   지문은 "보호 시작일보다 입양일이 더 빠른 동물"이다. "더 빠른"은 같은 날을 포함하지 않는다 -> <
--   <= 로 쓰면 보호 시작과 입양이 같은 시각인 동물(잘못 입력된 게 아닌 기록)까지 결과에 들어간다.
--   데이터에 같은 시각이 없으면 통과하지만, 지문 그대로 옮기면 < 가 맞다.
--   "빠른/늦은/초과/미만" -> < >,  "이상/이하/~부터/~까지" -> <= >=
-- 접근 방법:
--   두 테이블 모두에 있는 동물이어야 날짜를 비교할 수 있다 -> INNER JOIN (ANIMAL_ID)
--   조인한 행에서 입양일(OUTS.DATETIME) < 보호 시작일(INS.DATETIME)만 남김 -> 보호 시작일 순.
--   두 테이블에 DATETIME, NAME이 다 있으니 A. / B.를 붙인 것이 좋았다. 이게 없으면 ambiguous 에러.
--   NAME은 같은 동물이라 A.NAME이든 B.NAME이든 같다.
-- 기억해 둘 점:
--   오랜 기간 보호한 동물(1)·없어진 기록 찾기는 "한쪽에만 있는 것"(LEFT JOIN + IS NULL / NOT IN),
--   이 문제는 "양쪽에 다 있는데 값이 이상한 것"(INNER JOIN + 값 비교)이다.
--   MySQL은 # 도 한 줄 주석으로 받는다. -- 는 뒤에 공백이 있어야 주석이다.
