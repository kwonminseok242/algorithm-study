-- 12세 이하인 여자 환자 목록 출력하기 (Lv1)
-- 결과: 오답 → 수정 후 통과

-- 내 풀이 (오답)
-- SELECT PT_NAME, PT_NO, GEND_CD, AGE, TLNO
-- FROM PATIENT
-- WHERE AGE <= 12 AND GEnd_CD = 'W'
-- ORDER BY AGE DESC PT_NAME ASC;

-- 내 풀이 (수정)
SELECT PT_NAME, PT_NO, GEND_CD, AGE, IFNULL(TLNO, 'NONE') AS TLNO
FROM PATIENT
WHERE AGE <= 12 AND GEND_CD = 'W'
ORDER BY AGE DESC, PT_NAME ASC;

-- 메모
-- 틀린 이유:
--   1) "전화번호가 없는 경우 NONE으로 출력"을 옮기지 못했다.
--      없다 = NULL이다. NULL을 다른 값으로 바꿔 보여주는 함수가 IFNULL이다.
--        IFNULL(TLNO, 'NONE')  -- TLNO가 NULL이면 'NONE', 아니면 TLNO 그대로
--      함수를 씌우면 헤더가 IFNULL(TLNO, 'NONE')으로 바뀌니 AS TLNO로 이름을 되돌린다.
--      주의: WHERE로 NULL을 걸러내는 게 아니다. NULL인 행도 결과에 나와야 하고,
--      보여줄 때만 글자를 바꾸는 것이라 SELECT 쪽에서 처리한다.
--   2) ORDER BY 기준 사이에 콤마를 빼서 문법 에러가 났다.
--      ORDER BY AGE DESC PT_NAME ASC  (X)
--      ORDER BY AGE DESC, PT_NAME ASC (O)
--      기준이 여러 개면 콤마로 잇고, 방향은 열마다 따로 붙인다.
-- 접근 방법:
--   출력할 열 5개를 문제 문장 순서대로 적는다(환자이름, 환자번호, 성별코드, 나이, 전화번호).
--   조건: 12세 이하 -> AGE <= 12,  여자 -> GEND_CD = 'W'  (남자는 'M')
--   "없으면 NONE" -> SELECT에서 IFNULL
--   "나이 내림차순, 같으면 이름 오름차순" -> ORDER BY AGE DESC, PT_NAME ASC
-- 기억해 둘 점:
--   "~가 없는 경우 ~로 출력"은 WHERE가 아니라 SELECT에서 IFNULL로 바꾼다.
--   IFNULL(값, 대체)와 COALESCE(a, b, c)는 같은 일을 한다. 후보가 여러 개면 COALESCE.
--   NULL은 0도 빈 문자열도 아니다. 조건으로 찾을 때는 = NULL이 아니라 IS NULL.
--   열 이름 대소문자(GEnd_CD)는 MySQL에서 에러가 아니지만, 표기는 테이블대로 맞춰 적는다.
