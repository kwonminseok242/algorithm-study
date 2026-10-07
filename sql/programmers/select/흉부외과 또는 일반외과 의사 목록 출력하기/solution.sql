-- 흉부외과 또는 일반외과 의사 목록 출력하기 (Lv1)
-- 결과: 통과 (한 번에 맞춤)

-- 내 풀이
SELECT DR_NAME, DR_ID, MCDP_CD, HIRE_YMD
FROM DOCTOR
WHERE MCDP_CD = 'CS' OR MCDP_CD = 'GS'
ORDER BY HIRE_YMD DESC, DR_NAME ASC;

-- 더 짧게 (IN)
-- WHERE MCDP_CD IN ('CS', 'GS')

-- 메모
-- 틀린 이유: 없음.
-- 접근 방법:
--   출력할 열 4개(이름, 의사ID, 진료과, 고용일자) -> SELECT
--   "CS이거나 GS" -> OR 또는 IN
--   "고용일자 내림차순, 같으면 이름 오름차순" -> ORDER BY HIRE_YMD DESC, DR_NAME ASC
-- 궁금했던 점: WHERE MCDP_CD = 'CS' OR 'GS' 로 줄여 써도 되나?
--   안 된다. 그런데 에러가 나지 않아서 더 위험하다.
--   OR의 양쪽은 각각 하나의 완성된 조건이어야 한다. 위 식은 이렇게 읽힌다.
--     (MCDP_CD = 'CS') OR ('GS')
--   오른쪽의 'GS'는 비교가 아니라 그냥 값이고, MySQL은 이 문자열을 숫자로 바꿔 참/거짓을
--   판단한다. 숫자로 읽을 수 없는 글자는 0(거짓)이 된다.
--     SELECT 'GS' OR 0;  -- 0  (경고: Truncated incorrect DOUBLE value: 'GS')
--   그래서 결과는 "MCDP_CD = 'CS'"만 쓴 것과 같아진다. GS 의사가 통째로 빠지는데
--   에러도 0행도 아니고 그럴듯한 결과가 나오기 때문에 알아채기 어렵다.
--   (문자열이 '1'이었다면 참이 되어 모든 행이 나온다. 더 엉뚱해진다)
--   줄여 쓰고 싶으면 IN을 쓴다. 열 이름을 한 번만 적는다.
--     WHERE MCDP_CD IN ('CS', 'GS')
-- 기억해 둘 점:
--   OR 양쪽에는 "열 = 값"을 매번 다 적는다. 같은 열에 값이 여러 개면 IN이 정답에 가깝다.
--   AND가 OR보다 먼저 묶인다. 섞어 쓸 때는 괄호로 의도를 고정한다.
--     WHERE (A OR B) AND C   -- 괄호 없으면 A OR (B AND C)로 읽힌다
