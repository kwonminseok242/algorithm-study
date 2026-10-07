-- 강원도에 위치한 생산공장 목록 출력하기 (Lv1)
-- 결과: 오답 → 수정 후 통과

-- 내 풀이 (오답)
-- SELECT FACTORY_ID, FACTORY_NAME, ADDRESS
-- FROM FOOD_FACTORY
-- WHERE ADDRESS LIKE '강원도%';

-- 내 풀이 (수정)
SELECT FACTORY_ID, FACTORY_NAME, ADDRESS
FROM FOOD_FACTORY
WHERE ADDRESS LIKE '강원도%'
ORDER BY FACTORY_ID ASC;

-- 메모
-- 틀린 이유:
--   ORDER BY를 빼먹었다. 조건절은 맞았고 정렬 한 줄이 없어서 틀렸다.
--   "결과는 공장 ID를 기준으로 오름차순 정렬해주세요" -> ORDER BY FACTORY_ID
--   ORDER BY를 안 쓰면 DB가 편한 순서로 내놓는다. 우연히 맞게 보일 때도 있어서
--   눈으로 확인하면 넘어가기 쉽다. 문장에 "정렬"이 있으면 무조건 한 줄 적는다.
--   ** 벌써 세 번째다 (4번 도서 리스트, 5번 환자 목록, 9번 생산공장) **
-- 접근 방법:
--   "강원도에 위치한" -> 주소가 강원도로 시작한다 -> ADDRESS LIKE '강원도%'
--   출력할 열 3개 -> SELECT
--   정렬 -> ORDER BY FACTORY_ID
-- 기억해 둘 점:
--   LIKE 패턴에서 % 의 위치가 뜻을 바꾼다.
--     '강원도%'   앞이 강원도로 시작  <- 주소는 앞에 시/도가 오니 이게 맞다
--     '%강원도'   강원도로 끝
--     '%강원도%'  어디든 강원도가 들어감 (이것도 통과하지만 조건이 느슨하다)
--   = '강원도'는 주소 전체가 딱 "강원도"인 행만 찾으니 0행이다.
--   한글도 LIKE가 그대로 동작한다. 글자 수를 셀 때만 LENGTH 대신 CHAR_LENGTH를 쓴다.
