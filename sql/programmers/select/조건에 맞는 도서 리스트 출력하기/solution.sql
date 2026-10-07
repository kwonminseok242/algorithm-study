-- 조건에 맞는 도서 리스트 출력하기 (Lv1)
-- 결과: 오답 → 수정 후 통과

-- 내 풀이 (오답)
-- SELECT BOOK_ID, PUBLISHED_DATE
-- FROM BOOK
-- WHERE PUBLISHED_DATE = '2021%' AND CATEGORY = '인문';

-- 내 풀이 (수정)
SELECT BOOK_ID, PUBLISHED_DATE
FROM BOOK
WHERE YEAR(PUBLISHED_DATE) = 2021
  AND CATEGORY = '인문'
ORDER BY PUBLISHED_DATE ASC;

-- 메모
-- 틀린 이유:
--   1) = 에 % 를 썼다. % 는 LIKE에서만 와일드카드다.
--      = 에서는 그냥 글자 그대로라서 "2021%"라는 문자열과 똑같은 날짜를 찾는 셈이고,
--      그런 날짜는 없으니 결과가 0행이 된다. 에러가 안 나서 더 헷갈린다.
--      연도만 걸러낼 때는 날짜에서 연도를 꺼내 숫자로 비교한다. -> YEAR(PUBLISHED_DATE) = 2021
--      YEAR()가 숫자를 돌려주므로 따옴표 없는 2021과 비교한다.
--   2) ORDER BY를 빼먹었다. "출판일을 기준으로 오름차순 정렬해주세요"가 있으면
--      ORDER BY PUBLISHED_DATE ASC를 적는다. (ASC는 기본값이라 생략해도 된다)
-- 다른 방법 (기간으로 거르기):
--   WHERE PUBLISHED_DATE >= '2021-01-01' AND PUBLISHED_DATE < '2022-01-01'
--   또는 BETWEEN '2021-01-01' AND '2021-12-31'
--   열에 함수를 씌우지 않아서 인덱스를 쓸 수 있다. 실무에서는 이쪽을 선호한다.
--   단, 컬럼이 DATETIME이면 BETWEEN의 끝날짜는 '2021-12-31 00:00:00'으로 읽혀
--   12월 31일 낮 시간이 빠진다. 그럴 때는 >= , < 형태가 안전하다.
-- 접근 방법:
--   출력할 열(BOOK_ID, PUBLISHED_DATE) -> SELECT
--   조건 두 개(2021년, '인문') -> WHERE ... AND ...
--   정렬 문구 -> ORDER BY
-- 기억해 둘 점:
--   % 가 들어가면 LIKE, 없으면 = 다. 날짜 연도 조건은 LIKE보다 YEAR()가 분명하다.
--   결과에 시간(00:00:00)이 붙어 나오면 DATE_FORMAT(PUBLISHED_DATE, '%Y-%m-%d')으로 자른다.
--   이 문제의 PUBLISHED_DATE는 DATE 타입이라 그대로 출력해도 날짜만 나온다.
