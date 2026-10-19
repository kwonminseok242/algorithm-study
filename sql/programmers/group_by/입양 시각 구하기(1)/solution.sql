-- 입양 시각 구하기(1) (Lv2)
-- 결과: 오답 → 수정

-- 내 풀이 (오답)
-- SELECT DATETIME AS HOUR, COUNT(*) AS COUNT
-- FROM ANIMAL_OUTS
-- GROUP BY DATETIME
-- HAVING DATE_FORMAT(DATETIME, %h)
-- ORDER BY `HOUR`

-- 내 풀이 (수정)
SELECT HOUR(DATETIME) AS HOUR, COUNT(*) AS COUNT
FROM ANIMAL_OUTS
WHERE HOUR(DATETIME) BETWEEN 9 AND 19
GROUP BY HOUR
ORDER BY HOUR;

-- 메모
-- 틀린 이유:
--   1) GROUP BY DATETIME은 "날짜+시각 전체"로 묶는다.
--      2016-01-03 09:15:00과 2017-05-02 09:40:00은 다른 값이라 다른 그룹이 된다.
--      "시간대별"로 세려면 시(hour)만 꺼낸 값으로 묶어야 한다 -> GROUP BY HOUR(DATETIME)
--      SELECT도 마찬가지로 DATETIME 그대로가 아니라 HOUR(DATETIME)을 출력한다.
--   2) HAVING DATE_FORMAT(DATETIME, %h)
--      - 형식 문자열에 따옴표가 없어서 문법 에러. '%H'처럼 써야 한다.
--      - 비교식이 없다. HAVING/WHERE에는 "참/거짓이 나오는 조건"이 와야 한다.
--      - 시간을 꺼내는 건 거르는 일이 아니라 묶을 값을 만드는 일이라, HAVING이 아니라 SELECT/GROUP BY 자리다.
--   3) %h(소문자)는 12시간제(01~12)다. 오후 3시가 03으로 나온다. 24시간제는 %H(대문자).
--   4) "09:00부터 19:59까지" 조건이 빠졌다 -> WHERE HOUR(DATETIME) BETWEEN 9 AND 19
--      (BETWEEN은 양 끝 포함. 19시 59분까지가 HOUR = 19라서 19까지 넣는다.)
-- 접근 방법:
--   시(hour) 꺼내기 -> 9~19시만 남기기(WHERE) -> 시로 묶기 -> 개수 세기 -> 시 오름차순.
--   HOUR()는 숫자를 돌려주니 정렬도 9, 10, ..., 19 순서로 바르게 된다.
--   (DATE_FORMAT(DATETIME, '%H')는 '09' 같은 문자열이라 출력이 09로 나와 오답이 될 수 있다.)
-- 기억해 둘 점:
--   WHERE: 묶기 전에 행을 거른다.  HAVING: 묶은 뒤 COUNT/SUM 같은 집계 결과로 거른다.
--   시간 조건은 집계 결과가 아니라 행 하나하나의 값이니 WHERE.
--   DATE_FORMAT 형식 기호: %Y 연도4, %m 월, %d 일, %H 24시, %h 12시, %i 분, %s 초. 항상 따옴표 안에.
