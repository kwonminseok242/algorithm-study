-- 조건에 부합하는 중고거래 댓글 조회하기 (Lv1)
-- 결과: 오답 → 수정 후 통과

-- 내 풀이 (오답)
-- SELECT B.TITLE, R.BOARD_ID, R.REPLY_ID, R.WRITER_ID, R.CONTENTS, R.CREATED_DATE
-- FROM USED_GOODS_BOARD B, USED_GOODS_REPLY R
-- WHERE R.BOARD_ID IN (SELECT BOARD_ID FROM USED_GOODS_BOARD WHERE MONTH(B.CREATED_DATE) = 10)
-- ORDER BY R.CREATED_DATE ASC, B.TITLE ASC;

-- 내 풀이 (수정)
SELECT B.TITLE,
       B.BOARD_ID,
       R.REPLY_ID,
       R.WRITER_ID,
       R.CONTENTS,
       DATE_FORMAT(R.CREATED_DATE, '%Y-%m-%d') AS CREATED_DATE
FROM USED_GOODS_BOARD AS B
JOIN USED_GOODS_REPLY AS R ON B.BOARD_ID = R.BOARD_ID
WHERE YEAR(B.CREATED_DATE) = 2022
  AND MONTH(B.CREATED_DATE) = 10
ORDER BY R.CREATED_DATE ASC, B.TITLE ASC;

-- 메모
-- 틀린 이유:
--   1) 두 테이블을 이을 조건이 없었다. 이게 가장 큰 문제다.
--      FROM A, B 는 콤마 조인이라 조인 조건을 WHERE에 써야 하는데 그걸 안 썼다.
--      조건이 없으면 모든 조합이 만들어진다(카테시안 곱). 게시글 100개 x 댓글 100개 = 10,000행.
--      엉뚱한 게시글 제목에 남의 댓글이 붙은 행이 잔뜩 나온다.
--      -> JOIN ... ON B.BOARD_ID = R.BOARD_ID 로 이어 붙인다.
--      콤마 조인보다 JOIN ON을 쓴다. 조인 조건을 깜빡하면 바로 눈에 보이기 때문이다.
--   2) 서브쿼리가 필요 없었고, 안을 잘못 썼다.
--      SELECT BOARD_ID FROM USED_GOODS_BOARD WHERE MONTH(B.CREATED_DATE) = 10
--      여기서 B는 바깥 테이블이다. 서브쿼리 안의 USED_GOODS_BOARD를 가리키지 않는다.
--      그래서 "바깥 B의 월이 10이면 BOARD_ID 전체를 내놓는" 식이 되어 조건이 사실상 풀린다.
--      조인을 했으면 날짜 조건은 WHERE에 바로 쓰면 된다. 서브쿼리는 지운다.
--      (서브쿼리 안에서 조건을 걸 때는 그 안의 테이블 별칭을 쓴다)
--   3) 연도 조건을 빼먹었다. "2022년 10월"은 조건 두 개다.
--      MONTH(...) = 10 만 쓰면 2021년, 2023년 10월까지 들어온다.
--      -> YEAR(B.CREATED_DATE) = 2022 AND MONTH(B.CREATED_DATE) = 10
--      한 줄로 쓰려면 DATE_FORMAT(B.CREATED_DATE, '%Y-%m') = '2022-10' 도 된다.
--   4) BOARD_ID를 R에서 가져왔다. 조인으로 같은 값이라 답은 맞지만,
--      "게시글 ID"를 묻고 있으니 B.BOARD_ID로 적는 편이 뜻이 분명하다.
--   5) 댓글 작성일을 그대로 출력했다. 시간이 붙어 나와 채점에서 틀린다.
--      -> DATE_FORMAT(R.CREATED_DATE, '%Y-%m-%d') AS CREATED_DATE
-- 접근 방법:
--   어느 테이블에서 무엇이 오는지 먼저 가른다.
--     게시글 제목, 게시글 ID, 날짜 조건 -> B (USED_GOODS_BOARD)
--     댓글 ID, 댓글 작성자, 댓글 내용, 댓글 작성일 -> R (USED_GOODS_REPLY)
--   두 테이블의 열을 같이 보여줘야 하니 IN 서브쿼리가 아니라 JOIN이다.
--   공통 키는 BOARD_ID.
--   조건은 "게시글이 2022년 10월에 작성" -> 댓글이 아니라 B.CREATED_DATE에 건다.
--   정렬은 댓글 작성일, 같으면 게시글 제목.
-- 기억해 둘 점:
--   결과에 두 테이블의 열이 섞여 있으면 JOIN. 조건으로만 쓰면 IN 서브쿼리.
--   JOIN을 쓸 때마다 ON을 먼저 적는다. ON 없는 조인은 행 수가 폭증한다.
--   같은 이름의 열(CREATED_DATE, WRITER_ID, CONTENTS)이 양쪽에 있으면
--   별칭을 꼭 붙인다. 어느 쪽 날짜로 거르고 어느 쪽 날짜로 정렬하는지 헷갈리기 쉽다.
--   별칭의 AS는 생략해도 된다. 내가 처음 쓴 아래 두 줄은 똑같이 동작한다.
--     FROM USED_GOODS_BOARD AS B      -- AS를 쓴 형태
--     FROM USED_GOODS_BOARD B         -- AS를 뺀 형태 (같다)
--   열 별칭도 마찬가지다. COUNT(*) TOTAL 과 COUNT(*) AS TOTAL 이 같다.
--   다만 열 별칭에서 AS를 빼면 콤마를 빠뜨렸을 때 티가 안 난다.
--     SELECT TITLE, BOARD_ID REPLY_ID  -- 열 3개가 아니라 2개다. BOARD_ID의 이름이 REPLY_ID가 된다
--   그래서 테이블 별칭은 AS 없이 짧게, 열 별칭은 AS를 붙여 쓰는 사람이 많다.
--   FROM 서브쿼리의 별칭만은 생략할 수 없다. FROM (SELECT ...) T 처럼 반드시 붙인다.
