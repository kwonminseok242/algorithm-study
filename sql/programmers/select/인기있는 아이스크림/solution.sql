-- 인기있는 아이스크림 (Lv1)
-- 결과: 통과 (한 번에 맞춤)

-- 내 풀이
SELECT FLAVOR
FROM FIRST_HALF
ORDER BY TOTAL_ORDER DESC, SHIPMENT_ID ASC;

-- 메모
-- 틀린 이유: 없음.
-- 접근 방법:
--   조건이 없으니 WHERE는 쓰지 않는다. 문제 문장을 순서대로 옮기면 그대로 쿼리가 된다.
--   "아이스크림의 맛을" -> SELECT FLAVOR
--   "총주문량을 기준으로 내림차순" -> ORDER BY TOTAL_ORDER DESC
--   "같다면 출하 번호를 기준으로 오름차순" -> , SHIPMENT_ID ASC
--   정렬에만 쓰는 열(TOTAL_ORDER, SHIPMENT_ID)은 SELECT에 없어도 된다.
-- 기억해 둘 점:
--   "~가 같다면"이라는 말은 ORDER BY 기준이 두 개라는 신호다.
--   앞 기준으로 먼저 줄을 세우고, 그 값이 같은 행만 뒤 기준으로 가른다.
--   방향(ASC/DESC)은 열마다 따로 붙는다. DESC 하나가 뒤 열까지 걸리지 않는다.
