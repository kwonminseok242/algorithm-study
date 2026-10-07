# SQL 문법 정리

프로그래머스 SQL 고득점 Kit에서 쓰는 MySQL 조회 문법이다. 표를 먼저 보고, 바로 아래 예시를 쿼리 틀로 쓰면 된다.

## 목차

1. [쿼리가 읽히는 순서](#1-쿼리가-읽히는-순서)
2. [SELECT](#2-select)
3. [WHERE](#3-where)
4. [정렬, 개수 제한, 중복 제거](#4-정렬-개수-제한-중복-제거)
5. [집계 함수](#5-집계-함수)
6. [GROUP BY와 HAVING](#6-group-by와-having)
7. [NULL](#7-null)
8. [JOIN](#8-join)
9. [서브쿼리](#9-서브쿼리)
10. [UNION](#10-union)
11. [CASE](#11-case)
12. [문자열](#12-문자열)
13. [날짜](#13-날짜)
14. [비트 연산](#14-비트-연산)
15. [WITH](#15-with)
16. [틀리기 쉬운 지점](#16-틀리기-쉬운-지점)

---

## 1. 쿼리가 읽히는 순서

적는 순서와 실행 순서는 다르다. `WHERE`에서 SELECT 별칭을 쓰면 에러 나는 이유가 여기 있다.

| 순서 | 절 | 하는 일 |
|---|---|---|
| 1 | `FROM` / `JOIN` | 테이블을 꺼내고 붙인다 |
| 2 | `WHERE` | 행을 거른다. 집계 전 |
| 3 | `GROUP BY` | 같은 값끼리 묶는다 |
| 4 | `HAVING` | 묶인 결과를 거른다 |
| 5 | `SELECT` | 열을 고르고 계산한다 |
| 6 | `DISTINCT` | 결과 행의 중복을 뺀다 |
| 7 | `ORDER BY` | 정렬한다 |
| 8 | `LIMIT` | 개수를 자른다 |

MySQL은 `GROUP BY`, `HAVING`, `ORDER BY`에서 SELECT 별칭을 허용한다. `WHERE`에서는 허용하지 않는다.

```sql
SELECT ANIMAL_TYPE, COUNT(*) AS cnt
FROM ANIMAL_INS
WHERE INTAKE_CONDITION = 'Sick'   -- 별칭 cnt 사용 불가
GROUP BY ANIMAL_TYPE
HAVING cnt >= 2                   -- MySQL에서는 가능
ORDER BY cnt DESC;
```

---

## 2. SELECT

```sql
SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS;
```

| 표현 | 의미 |
|---|---|
| `*` | 모든 열 |
| `col AS 별칭` | 결과 열 이름. `AS`는 생략 가능 |
| `테이블.열` | 어느 테이블 열인지 고정 |
| `테이블 AS A` | 테이블 별칭. 이후에는 `A.열` |

같은 이름 열이 두 테이블에 있으면 `ANIMAL_ID`처럼 쓰면 에러다. `A.ANIMAL_ID`로 적는다.

`AS`는 테이블 별칭에서도 열 별칭에서도 생략할 수 있다. 아래 네 줄은 각각 같은 뜻이다.

```sql
FROM USED_GOODS_BOARD AS B
FROM USED_GOODS_BOARD B      -- 같다

SELECT COUNT(*) AS TOTAL
SELECT COUNT(*) TOTAL        -- 같다
```

열 별칭에서 `AS`를 빼면 콤마를 빠뜨린 실수가 눈에 띄지 않는다. `SELECT TITLE, BOARD_ID REPLY_ID`는 열 세 개가 아니라 두 개이고, `BOARD_ID`의 이름이 `REPLY_ID`가 된다. 테이블 별칭은 `AS` 없이 짧게, 열 별칭은 `AS`를 붙이는 쪽이 안전하다.

`FROM (SELECT ...)` 서브쿼리의 별칭만은 생략할 수 없다.

계산식도 열이 된다.

```sql
SELECT PRICE * SALES AS TOTAL_SALES
FROM BOOK;
```

---

## 3. WHERE

조건이 참인 행만 남긴다. 비교 결과가 `NULL`이면 그 행은 탈락한다.

| 연산 | 의미 | 예시 |
|---|---|---|
| `=`, `!=`, `<>` | 같다, 다르다 | `TYPE = 'Cat'` |
| `<`, `>`, `<=`, `>=` | 크기 비교 | `AGE >= 12` |
| `AND`, `OR`, `NOT` | 조건 결합 | `A AND (B OR C)` |
| `BETWEEN a AND b` | a 이상 b 이하. 양쪽 포함 | `PRICE BETWEEN 1000 AND 3000` |
| `IN (값, ...)` | 목록 중 하나 | `TYPE IN ('Cat', 'Dog')` |
| `LIKE` | 패턴 | `NAME LIKE 'el%'` |
| `IS NULL` | 값이 없음 | `NAME IS NULL` |

`AND`가 `OR`보다 먼저 묶인다. 의도가 "A 또는 (B 그리고 C)"라면 괄호를 쓴다.

`OR` 양쪽은 각각 완성된 조건이어야 한다. 열 이름을 빼고 값만 적으면 에러 없이 다른 뜻이 된다.

```sql
WHERE MCDP_CD = 'CS' OR 'GS'          -- (MCDP_CD = 'CS') OR ('GS')로 읽힌다
WHERE MCDP_CD = 'CS' OR MCDP_CD = 'GS' -- 맞는 식
WHERE MCDP_CD IN ('CS', 'GS')          -- 같은 열이면 이쪽이 짧다
```

값 하나만 놓인 `'GS'`는 숫자로 바뀌어 참/거짓이 된다. 숫자로 읽을 수 없는 글자는 `0`, 즉 거짓이라 `'CS'` 조건만 남는다. 경고만 나오고 결과는 그럴듯해서 알아채기 어렵다.

```sql
SELECT MEMBER_ID, GENDER, DATE_OF_BIRTH
FROM MEMBER_PROFILE
WHERE GENDER = 'W'
  AND MONTH(DATE_OF_BIRTH) = 3
  AND TLNO IS NOT NULL;
```

`LIKE` 와일드카드는 두 개다.

| 기호 | 의미 |
|---|---|
| `%` | 글자 수 제한 없는 아무 문자열. 빈 문자열 포함 |
| `_` | 아무 글자 하나 |

```sql
NAME LIKE 'el%'    -- el로 시작
NAME LIKE '%el'    -- el로 끝
NAME LIKE '%el%'   -- 중간에 el
NAME LIKE '____'   -- 정확히 4글자
```

프로그래머스 MySQL은 대체로 대소문자를 구분하지 않는다. `LIKE '%el%'`이 `EL`, `El`에도 맞는다. 문제에서 대소문자 무시를 요구하면 `LOWER(NAME) LIKE '%el%'`로 고정할 수 있다.

---

## 4. 정렬, 개수 제한, 중복 제거

```sql
SELECT NAME, DATETIME
FROM ANIMAL_INS
ORDER BY NAME ASC, DATETIME DESC
LIMIT 1;
```

| 구문 | 의미 |
|---|---|
| `ORDER BY 열 ASC` | 오름차순. `ASC`는 기본값이라 생략 가능 |
| `ORDER BY 열 DESC` | 내림차순 |
| `ORDER BY 1, 2` | SELECT에 적은 순서. 가독성이 떨어져 열 이름을 쓴다 |
| `LIMIT n` | 앞에서 n행 |
| `LIMIT offset, n` | offset개를 건너뛰고 n행. 첫 행 offset은 0 |
| `DISTINCT` | 결과 행이 완전히 같은 것만 한 번 |

정렬 기준이 두 개면 앞 기준으로 먼저 줄을 세우고, 그 값이 같은 행만 다음 기준으로 가른다.

```sql
ORDER BY NAME ASC, DATETIME DESC
```

MySQL에서 `NULL`은 가장 작은 값처럼 정렬된다. `ASC`면 NULL이 앞, `DESC`면 NULL이 뒤다.

`DISTINCT`는 SELECT 결과 전체에 적용된다. `SELECT DISTINCT A, B`는 (A, B) 쌍이 같을 때만 하나로 합친다.

---

## 5. 집계 함수

여러 행을 값 하나로 접는다. `GROUP BY`가 없으면 테이블 전체가 한 묶음이다.

| 함수 | 의미 | NULL |
|---|---|---|
| `COUNT(*)` | 행 수 | NULL이 있는 행도 센다 |
| `COUNT(열)` | 그 열이 NULL이 아닌 행 수 | NULL은 빠진다 |
| `COUNT(DISTINCT 열)` | 서로 다른 값의 개수 | NULL은 빠진다 |
| `SUM(열)` | 합 | NULL은 0으로 더하지 않고 무시 |
| `AVG(열)` | 평균 | NULL인 행은 분모에서도 빠진다 |
| `MAX(열)`, `MIN(열)` | 최댓값, 최솟값 | NULL은 무시 |

```sql
SELECT COUNT(*) AS total,
       COUNT(NAME) AS named,
       COUNT(DISTINCT NAME) AS unique_names
FROM ANIMAL_INS;
```

### 반올림과 자리수

`ROUND(값, 자리수)`에서 자리수는 **남길 소수 자리의 개수**다. 자리수를 적지 않으면 0과 같다.

```sql
SELECT ROUND(AVG(REVIEW_SCORE), 2) AS SCORE
FROM REST_REVIEW;
```

값이 `1234.5678`일 때:

| 쓴 식 | 결과 | 뜻 |
|---|---|---|
| `ROUND(값)` | `1235` | 소수를 없앤 정수 |
| `ROUND(값, 0)` | `1235` | 위와 같다 |
| `ROUND(값, 1)` | `1234.6` | 소수 첫째 자리까지 |
| `ROUND(값, 2)` | `1234.57` | 소수 둘째 자리까지 |
| `ROUND(값, -2)` | `1200` | 백의 자리까지 (음수도 된다) |

문제의 말과 자리수를 이렇게 맞춘다. "소수 **첫 번째 자리에서** 반올림"은 그 자리를 반올림해 **없앤다**는 뜻이라 `0`, "소수 **둘째 자리까지** 표시"는 그 자리를 **남긴다**는 뜻이라 `2`다. `에서`와 `까지`를 보고 고른다.

| 문제 문구 | 자리수 |
|---|---|
| 소수 첫째 자리에서 반올림 / 정수로 | `ROUND(값, 0)` |
| 소수 둘째 자리에서 반올림 / 소수 첫째 자리까지 | `ROUND(값, 1)` |
| 소수 셋째 자리에서 반올림 / 소수 둘째 자리까지 | `ROUND(값, 2)` |

반올림이 아니라고 하면 함수를 바꾼다. 자리수 규칙은 `ROUND`와 같다.

| 함수 | 하는 일 | `1234.5678` → |
|---|---|---|
| `ROUND(값, 2)` | 반올림 | `1234.57` |
| `TRUNCATE(값, 2)` | 버림 (자리수 필수) | `1234.56` |
| `FLOOR(값)` | 내림, 정수로 | `1234` |
| `CEIL(값)` | 올림, 정수로 | `1235` |

집계 결과가 없는 그룹에서 `SUM`은 `NULL`이다. 0으로 보이게 하려면 `IFNULL(SUM(PRICE), 0)`을 쓴다.

---

## 6. GROUP BY와 HAVING

`GROUP BY`에 적은 열의 값이 같은 행이 한 줄이 된다.

```sql
SELECT ANIMAL_TYPE, COUNT(*) AS count
FROM ANIMAL_INS
GROUP BY ANIMAL_TYPE
ORDER BY ANIMAL_TYPE;
```

SELECT에 나오는 일반 열은 `GROUP BY`에 있어야 한다. 없으려면 집계 함수로 감싼다.

```sql
-- ANIMAL_TYPE마다 NAME은 여러 개라 이렇게 쓰면 안 된다
SELECT ANIMAL_TYPE, NAME, COUNT(*)
FROM ANIMAL_INS
GROUP BY ANIMAL_TYPE;
```

| | `WHERE` | `HAVING` |
|---|---|---|
| 시점 | 묶기 전, 행 단위 | 묶은 뒤, 그룹 단위 |
| 집계 함수 | 못 쓴다 | 쓴다 |
| 예시 | `WHERE AGE >= 20` | `HAVING COUNT(*) >= 2` |

```sql
SELECT NAME, COUNT(*) AS cnt
FROM ANIMAL_INS
WHERE NAME IS NOT NULL
GROUP BY NAME
HAVING cnt >= 2
ORDER BY NAME;
```

가격대를 만 원 단위로 끊을 때는 그 식을 `GROUP BY`에 넣는다.

```sql
SELECT FLOOR(PRICE / 10000) * 10000 AS PRICE_GROUP,
       COUNT(*) AS PRODUCTS
FROM PRODUCT
GROUP BY FLOOR(PRICE / 10000) * 10000
ORDER BY PRICE_GROUP;
```

여러 열을 묶으면 그 조합이 한 그룹이다.

```sql
GROUP BY YEAR, MONTH, GENDER
```

문자열로 한 칸에 모을 때는 `GROUP_CONCAT`을 쓴다.

```sql
SELECT GROUP_CONCAT(FILE_PATH ORDER BY FILE_ID SEPARATOR ' ')
FROM ATTACHED_FILE
GROUP BY BOARD_ID;
```

---

## 7. NULL

`NULL`은 0도 아니고 빈 문자열 `''`도 아니다. "값이 없다"이다. `NULL`과 무엇을 비교해도 결과는 `NULL`이라 `WHERE`를 통과하지 못한다.

| 틀린 식 | 맞는 식 |
|---|---|
| `NAME = NULL` | `NAME IS NULL` |
| `NAME != NULL` | `NAME IS NOT NULL` |

```sql
SELECT ANIMAL_ID
FROM ANIMAL_INS
WHERE NAME IS NULL;
```

| 함수 | 동작 |
|---|---|
| `IFNULL(값, 대체)` | 값이 NULL이면 대체, 아니면 값 |
| `COALESCE(a, b, c)` | 앞에서부터 보다가 처음 나오는 NULL이 아닌 값 |
| `NULLIF(a, b)` | a와 b가 같으면 NULL, 다르면 a |

```sql
SELECT ANIMAL_TYPE, IFNULL(NAME, 'No name') AS NAME
FROM ANIMAL_INS;
```

길이가 NULL인 물고기를 10cm로 보고 평균을 낼 때:

```sql
SELECT ROUND(AVG(IFNULL(LENGTH, 10)), 2) AS AVERAGE_LENGTH
FROM FISH_INFO;
```

`NOT IN` 목록 안에 `NULL`이 하나라도 있으면 결과가 비는 경우가 있다. 서브쿼리에서 NULL이 나올 수 있으면 `IS NOT NULL`로 먼저 뺀다.

---

## 8. JOIN

두 테이블에서 연결 키가 같은 행을 한 줄로 붙인다.

```sql
SELECT A.BOOK_ID, B.AUTHOR_NAME
FROM BOOK AS A
JOIN AUTHOR AS B ON A.AUTHOR_ID = B.AUTHOR_ID;
```

| 종류 | 남기는 행 |
|---|---|
| `INNER JOIN` (`JOIN`) | 양쪽 모두 키가 있는 행 |
| `LEFT JOIN` | 왼쪽은 전부. 오른쪽에 없으면 오른쪽 열은 NULL |
| `RIGHT JOIN` | 오른쪽은 전부. 실무와 시험 모두 `LEFT JOIN`으로 방향을 고정하는 편이 읽기 쉽다 |

```sql
SELECT O.ANIMAL_ID, O.NAME
FROM ANIMAL_OUTS AS O
LEFT JOIN ANIMAL_INS AS I ON O.ANIMAL_ID = I.ANIMAL_ID
WHERE I.ANIMAL_ID IS NULL;   -- 입양 기록은 있는데 보호소 입소 기록이 없는 동물
```

`ON`과 `WHERE`를 바꾸면 의미가 바뀐다.

- `ON`의 조건은 붙이는 규칙이다. 실패해도 `LEFT JOIN`의 왼쪽 행은 남고 오른쪽은 NULL이 된다.
- `WHERE`의 조건은 붙인 뒤의 필터다. 오른쪽 열에 `WHERE B.COL = 'X'`를 쓰면 NULL 행이 사라져 `INNER JOIN`과 같아진다.

왼쪽은 남기고, 오른쪽은 특정 조건일 때만 붙이려면 그 조건을 `ON`에 둔다.

```sql
LEFT JOIN CAR_RENTAL AS R
  ON C.CAR_ID = R.CAR_ID
 AND R.START_DATE <= '2022-10-16'
 AND R.END_DATE >= '2022-10-16'
```

키가 양쪽에서 같은 이름이면 `USING (CAR_ID)`로 줄일 수 있다.

세 테이블은 두 번 붙인다. 순서는 가운데 테이블을 먼저 두고 양옆을 잇는 식이 읽기 쉽다.

```sql
SELECT A.AUTHOR_ID, A.AUTHOR_NAME, B.CATEGORY,
       SUM(B.PRICE * S.SALES) AS TOTAL_SALES
FROM BOOK AS B
JOIN AUTHOR AS A ON B.AUTHOR_ID = A.AUTHOR_ID
JOIN BOOK_SALES AS S ON B.BOOK_ID = S.BOOK_ID
WHERE S.SALES_DATE BETWEEN '2022-01-01' AND '2022-01-31'
GROUP BY A.AUTHOR_ID, A.AUTHOR_NAME, B.CATEGORY
ORDER BY A.AUTHOR_ID, B.CATEGORY DESC;
```

같은 테이블을 두 번 쓸 때는 별칭이 필수다. 대장균의 부모-자식이 이 형태다.

```sql
SELECT C.ID, COUNT(P.ID) AS CHILD_COUNT
FROM ECOLI_DATA AS C
LEFT JOIN ECOLI_DATA AS P ON C.ID = P.PARENT_ID
GROUP BY C.ID
ORDER BY C.ID;
```

`LEFT JOIN`인 이유: 자식이 없는 개체도 0으로 남아야 하기 때문이다. `COUNT(P.ID)`는 못 붙은 행의 NULL을 세지 않는다. `COUNT(*)`를 쓰면 자식이 없어도 1이 된다.

---

## 9. 서브쿼리

쿼리 안의 쿼리다. 위치에 따라 반환하는 모양이 정해져 있다.

| 위치 | 반환 | 예시 |
|---|---|---|
| `WHERE 열 IN (서브쿼리)` | 열 하나, 여러 행 | 회원 목록 |
| `WHERE 열 = (서브쿼리)` | 값 하나 | 최댓값과 같은 행 |
| `FROM (서브쿼리) AS T` | 표 하나 | 집계 결과를 다시 조인. 별칭 필수 |
| `SELECT (서브쿼리)` | 값 하나 | 각 행마다 숫자 하나 |

최댓값과 같은 행을 통째로 가져올 때:

```sql
SELECT *
FROM FOOD_PRODUCT
WHERE PRICE = (SELECT MAX(PRICE) FROM FOOD_PRODUCT);
```

종류별 최댓값을 구한 뒤, 그 길이와 같은 물고기를 찾을 때:

```sql
SELECT F.ID, N.FISH_NAME, F.LENGTH
FROM FISH_INFO AS F
JOIN FISH_NAME_INFO AS N ON F.FISH_TYPE = N.FISH_TYPE
WHERE (F.FISH_TYPE, F.LENGTH) IN (
    SELECT FISH_TYPE, MAX(LENGTH)
    FROM FISH_INFO
    GROUP BY FISH_TYPE
)
ORDER BY F.ID;
```

`FROM` 서브쿼리에는 반드시 별칭을 붙인다.

```sql
SELECT T.FISH_TYPE, T.MAX_LENGTH
FROM (
    SELECT FISH_TYPE, MAX(LENGTH) AS MAX_LENGTH
    FROM FISH_INFO
    GROUP BY FISH_TYPE
) AS T;
```

같은 해의 최댓값에서 각 개체의 크기를 빼 연도별 편차를 구할 때도 집계 결과를 표로 만든 뒤 붙인다.

```sql
SELECT E.YEAR, (M.MAX_SIZE - E.SIZE_OF_COLONY) AS YEAR_DEV, E.ID
FROM (
    SELECT YEAR(DIFFERENTIATION_DATE) AS YEAR, SIZE_OF_COLONY, ID
    FROM ECOLI_DATA
) AS E
JOIN (
    SELECT YEAR(DIFFERENTIATION_DATE) AS YEAR, MAX(SIZE_OF_COLONY) AS MAX_SIZE
    FROM ECOLI_DATA
    GROUP BY YEAR(DIFFERENTIATION_DATE)
) AS M ON E.YEAR = M.YEAR
ORDER BY E.YEAR, YEAR_DEV;
```

바깥 쿼리의 열을 안쪽 `WHERE`에서 참조하면 상관 서브쿼리다. 바깥 행마다 안쪽이 다시 실행된다. 행이 많으면 `JOIN`이나 `GROUP BY`가 더 낫다.

---

## 10. UNION

열 개수와 순서가 같은 두 결과를 위아래로 쌓는다. 열 이름은 첫 번째 쿼리를 따른다.

| | 중복 행 |
|---|---|
| `UNION` | 제거 |
| `UNION ALL` | 유지. 중복이 없으면 이쪽이 할 일이 적다 |

`ORDER BY`와 `LIMIT`은 전체의 맨 끝에 한 번만 둔다. 한쪽에만 정렬이 필요하면 그 쿼리를 괄호로 감싼다.

```sql
SELECT DATE_FORMAT(SALES_DATE, '%Y-%m-%d') AS SALES_DATE,
       PRODUCT_ID, USER_ID, SALES_AMOUNT
FROM ONLINE_SALE
WHERE SALES_DATE BETWEEN '2022-03-01' AND '2022-03-31'

UNION ALL

SELECT DATE_FORMAT(SALES_DATE, '%Y-%m-%d') AS SALES_DATE,
       PRODUCT_ID, NULL AS USER_ID, SALES_AMOUNT
FROM OFFLINE_SALE
WHERE SALES_DATE BETWEEN '2022-03-01' AND '2022-03-31'

ORDER BY SALES_DATE, PRODUCT_ID, USER_ID;
```

오프라인에는 `USER_ID`가 없다. 열 수를 맞추려고 `NULL AS USER_ID`를 넣는다.

합칠 대상이 "서로 짝지을 두 테이블"이 아니라 "한 목록으로 쌓을 두 기록"이면 `JOIN`이 아니라 `UNION`이다. `JOIN`은 옆으로 붙여 열이 늘고, `UNION`은 아래로 쌓아 행이 는다.

---

## 11. CASE

값이나 조건에 따라 다른 결과를 돌려준다. 집계 전에 등급, 상태, 구분을 만들 때 쓴다.

```sql
SELECT ORDER_ID,
       CASE
           WHEN DATEDIFF(OUT_DATE, IN_DATE) >= 7 THEN '장기'
           WHEN OUT_DATE IS NULL THEN '미정'
           ELSE '단기'
       END AS RENT_TYPE
FROM CAR_RENTAL;
```

`WHEN`은 위에서부터 검사하고, 처음 맞은 가지에서 멈춘다.

개수를 조건부로 세려면 `SUM`과 함께 쓴다. 참이면 1, 거짓이면 0을 더한다.

```sql
SELECT SUM(CASE WHEN AGE IS NULL THEN 1 ELSE 0 END) AS USERS
FROM USER_INFO;
```

같은 일은 `COUNT`로도 된다. `COUNT`는 NULL을 세지 않는다.

```sql
SELECT COUNT(CASE WHEN AGE IS NULL THEN 1 END) AS USERS
FROM USER_INFO;
```

MySQL의 `IF(조건, 참, 거짓)`은 가지가 하나일 때 짧다. 가지가 여러 개면 `CASE`가 읽기 쉽다.

---

## 12. 문자열

MySQL에서 `||`는 문자열 연결이 아니라 `OR`다. 연결은 `CONCAT`을 쓴다.

| 함수 | 의미 |
|---|---|
| `CONCAT(a, b, c)` | 이어 붙인다. 하나라도 NULL이면 결과도 NULL |
| `CONCAT_WS(구분자, a, b)` | 구분자로 잇는다. NULL 인자는 건너뛴다 |
| `LENGTH(s)` | 바이트 수. 한글은 글자 수와 다를 수 있다 |
| `CHAR_LENGTH(s)` | 글자 수 |
| `LEFT(s, n)`, `RIGHT(s, n)` | 왼쪽, 오른쪽 n글자 |
| `SUBSTRING(s, 시작, 길이)` | 시작은 1. `SUBSTRING(s, 3)`은 3번째부터 끝까지 |
| `UPPER(s)`, `LOWER(s)` | 대문자, 소문자 |
| `REPLACE(s, 찾을말, 바꿀말)` | 모두 바꾼다 |
| `TRIM(s)` | 양쪽 공백 제거 |
| `LPAD(s, 길이, 채울문자)` | 왼쪽을 채워 길이를 맞춘다 |
| `INSTR(s, 조각)` | 조각이 시작하는 위치. 없으면 0 |
| `REVERSE(s)` | 뒤집기 |

```sql
SELECT CONCAT('/home/grep/src/', BOARD_ID, '/', FILE_ID, FILE_NAME, FILE_EXT) AS FILE_PATH
FROM USED_GOODS_FILE;
```

카테고리 코드처럼 앞 두 글자로 묶을 때:

```sql
SELECT SUBSTRING(PRODUCT_CODE, 1, 2) AS CATEGORY, COUNT(*)
FROM PRODUCT
GROUP BY SUBSTRING(PRODUCT_CODE, 1, 2);
```

---

## 13. 날짜

프로그래머스 날짜 컬럼은 대부분 `DATETIME`이다. 일 단위만 필요하면 `DATE()` 또는 `DATE_FORMAT`으로 자른다.

| 함수 | 결과 |
|---|---|
| `YEAR(dt)`, `MONTH(dt)`, `DAY(dt)` | 숫자 |
| `HOUR(dt)`, `MINUTE(dt)`, `SECOND(dt)` | 숫자 |
| `DATE(dt)` | 시분초를 뺀 날짜 |
| `DATE_FORMAT(dt, 형식)` | 형식에 맞춘 문자열 |
| `DATEDIFF(a, b)` | `a - b`의 일 수. 시간은 버린다 |
| `TIMESTAMPDIFF(단위, 시작, 끝)` | 시작부터 끝까지의 차이 |
| `DATE_ADD(dt, INTERVAL 1 DAY)` | 날짜 더하기. `DATE_SUB`는 빼기 |

`DATE_FORMAT`에서 자주 쓰는 기호:

| 기호 | 의미 | 예 |
|---|---|---|
| `%Y` | 연 4자리 | 2022 |
| `%y` | 연 2자리 | 22 |
| `%m` | 월 2자리 | 03 |
| `%c` | 월, 앞의 0 없음 | 3 |
| `%d` | 일 2자리 | 01 |
| `%H` | 시 00–23 | 09 |
| `%i` | 분 | 05 |
| `%s` | 초 | 07 |

```sql
SELECT ANIMAL_ID, NAME, DATE_FORMAT(DATETIME, '%Y-%m-%d') AS 날짜
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;
```

`DATE_FORMAT(..., '%H')`는 문자열 `'09'`다. 숫자 정렬이 필요하면 `HOUR()`를 쓰거나, 출력만 0으로 맞추고 정렬은 숫자 열로 한다.

```sql
SELECT HOUR(DATETIME) AS HOUR, COUNT(*) AS COUNT
FROM ANIMAL_OUTS
WHERE HOUR(DATETIME) BETWEEN 9 AND 19
GROUP BY HOUR(DATETIME)
ORDER BY HOUR;
```

대여 일수는 시작일을 포함한다. `DATEDIFF(END, START)`는 시작일을 빼므로, 문제에 "당일 대여도 1일"이라고 되어 있으면 `+ 1`을 한다.

```sql
DATEDIFF(END_DATE, START_DATE) + 1
```

분기는 `QUARTER(dt)`가 1부터 4를 반환한다.

```sql
SELECT CONCAT(QUARTER(DIFFERENTIATION_DATE), 'Q') AS QUARTER, COUNT(*) AS ECOLI_COUNT
FROM ECOLI_DATA
GROUP BY QUARTER(DIFFERENTIATION_DATE)
ORDER BY QUARTER;
```

---

## 14. 비트 연산

대장균 형질은 숫자 하나에 여러 형질을 비트로 담는다. 형질 1은 `1`(이진 1), 형질 2는 `2`(이진 10), 형질 3은 `4`(이진 100)이다.

| 연산 | 의미 |
|---|---|
| `A & B` | 둘 다 1인 비트만 남김 |
| `A \| B` | 하나라도 1인 비트를 남김 |

형질 n을 가지고 있는지는 n번째 비트가 켜져 있는지로 본다.

```sql
-- 형질 1을 가짐
GENOTYPE & 1 = 1

-- 형질 2를 가짐
GENOTYPE & 2 = 2

-- 형질 1 또는 3을 가지고, 형질 2는 없음
(GENOTYPE & 1 = 1 OR GENOTYPE & 4 = 4)
AND GENOTYPE & 2 = 0
```

부모 형질을 자식이 모두 가지는 조건은, 부모 비트와 겹친 결과가 부모 자신과 같은지다.

```sql
CHILD.GENOTYPE & PARENT.GENOTYPE = PARENT.GENOTYPE
```

---

## 15. WITH

이름을 붙인 임시 결과다. 같은 서브쿼리를 여러 번 쓰지 않으려고 쓴다.

```sql
WITH MAX_LEN AS (
    SELECT FISH_TYPE, MAX(LENGTH) AS LENGTH
    FROM FISH_INFO
    GROUP BY FISH_TYPE
)
SELECT F.ID, N.FISH_NAME, F.LENGTH
FROM FISH_INFO AS F
JOIN MAX_LEN AS M ON F.FISH_TYPE = M.FISH_TYPE AND F.LENGTH = M.LENGTH
JOIN FISH_NAME_INFO AS N ON F.FISH_TYPE = N.FISH_TYPE
ORDER BY F.ID;
```

`WITH RECURSIVE`는 바로 앞 결과에 한 줄을 더해 다시 자신을 읽는다. 0시부터 23시처럼 표에 없는 축을 만들 때 쓴다.

```sql
WITH RECURSIVE HOURS AS (
    SELECT 0 AS HOUR
    UNION ALL
    SELECT HOUR + 1 FROM HOURS WHERE HOUR < 23
)
SELECT H.HOUR, COUNT(A.ANIMAL_ID) AS COUNT
FROM HOURS AS H
LEFT JOIN ANIMAL_OUTS AS A ON H.HOUR = HOUR(A.DATETIME)
GROUP BY H.HOUR
ORDER BY H.HOUR;
```

부모를 따라 올라가는 세대 문제도 같은 틀이다. 시작 행에 세대 번호 1을 두고, 자식을 붙일 때마다 세대에 1을 더한다.

```sql
WITH RECURSIVE GEN AS (
    SELECT ID, PARENT_ID, 1 AS GENERATION
    FROM ECOLI_DATA
    WHERE PARENT_ID IS NULL

    UNION ALL

    SELECT C.ID, C.PARENT_ID, G.GENERATION + 1
    FROM ECOLI_DATA AS C
    JOIN GEN AS G ON C.PARENT_ID = G.ID
)
SELECT ID
FROM GEN
WHERE GENERATION = 3
ORDER BY ID;
```

재귀의 끝 조건이 없으면 멈추지 않는다. 시간 축은 `WHERE HOUR < 23`, 세대는 부모 없는 행에서 출발해 자식이 더 없을 때 끝난다.

---

## 16. 틀리기 쉬운 지점

한 줄로 다시 보는 목록이다.

| 증상 | 확인할 곳 |
|---|---|
| 별칭을 `WHERE`에 썼더니 에러 | 별칭은 `GROUP BY`, `HAVING`, `ORDER BY`에서만 |
| `= NULL`이 아무것도 안 나옴 | `IS NULL` |
| `COUNT(*)`가 빈 조인까지 1로 셈 | 없는 쪽을 세려면 `COUNT(오른쪽.키)` |
| `LEFT JOIN` 결과가 `INNER JOIN`과 같음 | 오른쪽 열 조건을 `WHERE`가 아니라 `ON`에 두었는지 |
| 그룹별 최댓값 행이 아니라 최댓값만 나옴 | 최댓값을 서브쿼리로 구한 뒤 원본과 다시 붙인다 |
| 시간 정렬이 9 다음에 10이 아니라 19 근처 | `DATE_FORMAT '%H'`는 문자. 정렬은 `HOUR()` |
| 대여 일수가 하루 모자람 | 시작일 포함이면 `DATEDIFF + 1` |
| `UNION` 양쪽 열 수가 다름 | 없는 열은 `NULL AS 열이름` |
| `||`로 경로를 만들었더니 숫자가 나옴 | MySQL에서 `||`는 `OR`. `CONCAT` |
| 한글 `LENGTH`가 글자 수의 3배 | 글자 수는 `CHAR_LENGTH` |
| 나눗셈 결과가 기대보다 큼 | 비율은 곱하기를 먼저 하거나 `ROUND`로 자릿수를 고정 |
| 자식 없는 노드가 사라짐 | `LEFT JOIN` 후 `COUNT(자식.키)` |
| 결과 헤더가 `AVG(열)`처럼 나와서 틀림 | 문제가 컬럼명을 정해주면 `AS 컬럼명` |
| 평균이 소수로 길게 나옴 | 소수 첫째 자리에서 반올림은 `ROUND(값, 0)` |
| 서브쿼리를 `=`로 비교했더니 `more than 1 row` | 여러 행이 나오면 `IN`, 값 하나일 때만 `=` |
| `= '2021%'`로 썼더니 0행 (에러도 없음) | `%`는 `LIKE` 전용. 연도 조건은 `YEAR(열) = 2021` |
| `= 'A' OR 'B'`로 썼더니 B가 빠짐 | `OR` 양쪽에 조건을 다 쓰거나 `IN ('A', 'B')` |
| 날짜가 `2021-03-01 00:00:00`으로 나와 오답 | 출력은 `DATE_FORMAT(열, '%Y-%m-%d')` |
| 조인 결과 행이 이상하게 많음 | `FROM A, B`에 조인 조건을 뺐는지. `JOIN ... ON`으로 쓴다 |
| 서브쿼리에 바깥 별칭을 써서 조건이 풀림 | 서브쿼리 안 조건은 그 안의 테이블 별칭으로 |
| `AVG(ROUND(열), 2)`처럼 썼더니 에러 | 평균을 먼저, 반올림을 나중에. `ROUND(AVG(열), 2)` |
| 집계값이 식당별이 아니라 한 줄만 나옴 | 집계 + 일반 열을 같이 보면 `GROUP BY` |

비율은 소수 자릿수를 `ROUND`로 고정한다.

```sql
ROUND(COUNT(DISTINCT P.USER_ID) / COUNT(DISTINCT U.USER_ID) * 100, 1)
```
