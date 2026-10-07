-- 서울에 위치한 식당 목록 출력하기 (Lv4)
-- 결과: 오답 → 수정 후 통과

-- 내 풀이 (오답)
-- SELECT I.REST_ID, I.REST_NAME, I.FOOD_TYPE, I.FAVORITES, I.ADDRESS,
--        AVG(ROUND(R.REVEW_SCORE), 2)
-- FROM REST_INFO AS I
-- JOIN REST_REVEIW AS R ON I.REST_ID = R.REST_ID
-- WHERE I.ADDRESS LIKE '서울%'
-- ORDER BY AVG(ROUND(R.REVEW_SCORE), 2) DESC, I.FAVORITES DESC;

-- 내 풀이 (수정)
SELECT I.REST_ID,
       I.REST_NAME,
       I.FOOD_TYPE,
       I.FAVORITES,
       I.ADDRESS,
       ROUND(AVG(R.REVIEW_SCORE), 2) AS SCORE
FROM REST_INFO AS I
JOIN REST_REVIEW AS R ON I.REST_ID = R.REST_ID
WHERE I.ADDRESS LIKE '서울%'
GROUP BY I.REST_ID, I.REST_NAME, I.FOOD_TYPE, I.FAVORITES, I.ADDRESS
ORDER BY SCORE DESC, I.FAVORITES DESC;

-- 메모
-- 틀린 이유:
--   1) AVG와 ROUND의 순서가 뒤집혔다. 그리고 괄호 위치가 어긋났다.
--      내가 쓴 식:  AVG(ROUND(R.REVIEW_SCORE), 2)
--        -> ROUND(점수)로 점수를 하나씩 정수로 만든 뒤, AVG에 인자를 2개 준 셈이다.
--           AVG는 인자를 하나만 받으므로 문법 에러가 난다.
--      맞는 식:    ROUND(AVG(R.REVIEW_SCORE), 2)
--        -> 여러 점수를 먼저 AVG로 하나의 평균으로 접고, 그 값을 ROUND로 자른다.
--      순서를 정하는 기준: "평균을 반올림" 이라는 말 그대로 평균이 먼저다.
--      ROUND를 먼저 씌우면 각 점수가 3, 4처럼 뭉개진 뒤 평균이 나오므로 값 자체가 달라진다.
--      바깥에 쓰는 함수가 나중에 적용된다. 괄호 안쪽부터 바깥으로 읽는다.
--   2) GROUP BY가 없었다. 집계 함수와 일반 열을 같이 SELECT할 때는 GROUP BY가 필요하다.
--      GROUP BY가 없으면 테이블 전체가 한 묶음이 되어 평균이 딱 하나만 나온다.
--      식당별 평균이 필요하니 식당 단위로 묶는다. -> GROUP BY I.REST_ID, ...
--      REST_ID가 식당의 키라서 논리적으로는 REST_ID 하나로 충분하지만,
--      ONLY_FULL_GROUP_BY 설정에서 에러가 날 수 있으니 집계가 아닌 열을 다 적는 편이 안전하다.
--   3) 반올림 자리수. "소수점 세 번째 자리에서 반올림" -> 셋째 자리를 없앤다 -> 둘째 자리까지 남는다
--      -> ROUND(..., 2).  "에서"면 그 자리가 사라지고 "까지"면 남는다.
--   4) 컬럼명을 지정하지 않았다. 결과 헤더는 SCORE다. -> AS SCORE
--   5) 오타. REVEW_SCORE -> REVIEW_SCORE,  REST_REVEIW -> REST_REVIEW
--      테이블/열 이름은 문제 설명에서 복사해 쓰는 편이 빠르다.
-- 접근 방법:
--   어느 테이블에서 무엇이 오는지 가른다.
--     식당 ID, 이름, 음식 종류, 즐겨찾기수, 주소 -> I (REST_INFO)
--     리뷰 점수 -> R (REST_REVIEW), 식당마다 여러 행이니 평균으로 접는다
--   식당 1건에 리뷰 여러 건이 붙으므로 조인 후 행이 늘어난다. 그걸 식당 단위로 되접는 게 GROUP BY다.
--   "서울에 위치한" -> I.ADDRESS LIKE '서울%'
--   정렬: 평균점수 내림차순, 같으면 즐겨찾기수 내림차순
-- 기억해 둘 점:
--   집계 + 일반 열을 함께 보여주려면 GROUP BY. 집계만 보여줄 때는 필요 없다.
--   ROUND(AVG(열), 2)가 정석 순서다. AVG(ROUND(...))는 값이 달라진다.
--   별칭은 ORDER BY, GROUP BY, HAVING에서 쓸 수 있다. 그래서 ORDER BY SCORE DESC가 된다.
--   (WHERE에서는 별칭을 쓸 수 없다. WHERE가 SELECT보다 먼저 실행되기 때문이다)
--   긴 집계식을 ORDER BY에 그대로 또 적지 않는다. 별칭을 한 번 정하고 그 이름을 쓴다.
