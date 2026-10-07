-- 3월에 태어난 여성 회원 목록 출력하기 (Lv2)
-- 결과: 오답 → 수정 후 통과

-- 내 풀이 (오답)
-- SELECT MEMBER_ID, MEMBER_NAME, GENDER, DATE_OF_BIRTH
-- FROM MEMBER_PROFILE
-- WHERE MONTH(DATE_OF_BIRTH) = 3
--   AND TLNO IS NOT NULL
-- ORDER BY MEMBER_ID ASC;

-- 내 풀이 (수정)
SELECT MEMBER_ID,
       MEMBER_NAME,
       GENDER,
       DATE_FORMAT(DATE_OF_BIRTH, '%Y-%m-%d') AS DATE_OF_BIRTH
FROM MEMBER_PROFILE
WHERE MONTH(DATE_OF_BIRTH) = 3
  AND GENDER = 'W'
  AND TLNO IS NOT NULL
ORDER BY MEMBER_ID ASC;

-- 메모
-- 틀린 이유:
--   1) 성별 조건을 빼먹었다. 이게 오답의 직접 원인이다.
--      "생일이 3월인 '여성' 회원" -> AND GENDER = 'W'  (남성은 'M')
--      조건이 빠지면 에러 없이 남성까지 섞여 나오기 때문에 결과만 보면 그럴듯하다.
--      문제 문장에서 조건을 세어 본다: 3월(1) + 여성(2) + 전화번호 있음(3) = WHERE 조건 3개.
--      내가 쓴 건 2개였다.
--   2) 날짜를 그대로 출력했다.
--      이 문제의 DATE_OF_BIRTH는 표에는 DATE라고 적혀 있지만 실제로는 시간이 붙어 나와서
--      2021-03-01 00:00:00처럼 보이고, 채점은 보이는 문자열을 비교하므로 틀린다.
--      -> DATE_FORMAT(DATE_OF_BIRTH, '%Y-%m-%d')으로 날짜만 남기고
--         AS DATE_OF_BIRTH로 컬럼명을 되돌린다.
--      DATE(DATE_OF_BIRTH)로도 시간이 떨어진다. 출력 형식을 못 믿을 때는 DATE_FORMAT이 확실하다.
-- 접근 방법:
--   출력할 열 4개 -> SELECT (날짜는 형식을 맞춰서)
--   조건 3개 -> WHERE ... AND ... AND ...
--   "회원ID 오름차순" -> ORDER BY MEMBER_ID
--   TLNO는 조건에만 쓰이고 출력에는 없다. 조건용 열이 SELECT에 없어도 된다.
-- 기억해 둘 점:
--   제출 전에 문제 문장의 조건 개수와 WHERE의 조건 개수를 세어 맞춰 본다.
--   "NULL인 경우는 제외" -> WHERE TLNO IS NOT NULL (행을 뺀다)
--   "NULL인 경우는 NONE으로 출력" -> SELECT IFNULL(TLNO, 'NONE') (행은 남기고 글자만 바꾼다)
--   둘은 다른 요구다. 문장을 끝까지 읽고 어느 쪽인지 정한다.
