-- 조건에 맞는 도서와 저자 리스트 출력하기 (Lv2)
-- 결과: 풀이 방향 맞음 (제출 결과 미확인 — 날짜 형식만 확인 필요)

-- 내 풀이 (10/20)
-- SELECT B.BOOK_ID, A.AUTHOR_NAME,B.PUBLISHED_DATE
-- FROM BOOK AS B
-- INNER JOIN AUTHOR AS A
-- ON B.AUTHOR_ID = A.AUTHOR_ID
-- WHERE B.CATEGORY = '경제'
-- ORDER BY B.PUBLISHED_DATE ASC

-- 내 풀이 (날짜 형식 고정)
SELECT B.BOOK_ID, A.AUTHOR_NAME, DATE_FORMAT(B.PUBLISHED_DATE, '%Y-%m-%d') AS PUBLISHED_DATE
FROM BOOK AS B
JOIN AUTHOR AS A ON B.AUTHOR_ID = A.AUTHOR_ID
WHERE B.CATEGORY = '경제'
ORDER BY B.PUBLISHED_DATE ASC;

-- 메모
-- 틀린 이유:
--   조인·조건·정렬은 전부 맞다. 확인할 곳은 출력 형식 하나다.
--   예시 출력의 출판일이 2021-04-11 처럼 날짜만 있다.
--   열이 DATETIME으로 저장돼 있으면 그대로 출력할 때 2021-04-11 00:00:00이 나와 오답이 된다.
--   -> DATE_FORMAT(B.PUBLISHED_DATE, '%Y-%m-%d') AS PUBLISHED_DATE
--   함수를 씌우면 헤더가 바뀌니 AS로 원래 이름을 붙인다.
--   ORDER BY는 B.PUBLISHED_DATE(원래 열)로 정렬한다. 형식을 바꾼 문자열도 YYYY-MM-DD라 순서는 같다.
-- 접근 방법:
--   필요한 열이 두 테이블에 나뉘어 있다: 도서 ID·출판일은 BOOK, 저자명은 AUTHOR.
--   공통 열 AUTHOR_ID로 JOIN -> 경제 카테고리만 WHERE -> 출판일 오름차순.
--   두 테이블에 AUTHOR_ID가 다 있으니 열마다 B. / A.를 붙인 것이 좋았다(ambiguous 에러 예방).
-- 기억해 둘 점:
--   예시 출력에 날짜가 시간 없이 나오면 DATE_FORMAT(열, '%Y-%m-%d')를 기본으로 붙인다. 손해 볼 일이 없다.
--   INNER JOIN과 JOIN은 같다.
