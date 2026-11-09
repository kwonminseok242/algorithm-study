# Oracle 치트시트 (케이뱅크 코테용)

MySQL로 이미 아는 것만 **문법 치환**. 자세한 일정은 `KBANK 시험 대비 계획 v1.md`.

## 바로 감점되는 습관

| 쓰지 말 것 (MySQL) | 쓸 것 (Oracle) |
|---|---|
| `LIMIT N` | `WHERE ROWNUM <= N` (**정렬은 서브쿼리 안**) |
| `IFNULL(c,'x')` | `NVL(c,'x')` |
| `DATE_FORMAT(d,'%Y-%m-%d')` | `TO_CHAR(d,'YYYY-MM-DD')` |
| `HOUR(d)` | `TO_CHAR(d,'HH24')` |

## ROWNUM (가장 중요)

```sql
-- 정렬 후 1행
SELECT name
FROM (
  SELECT name FROM animal_ins ORDER BY datetime
)
WHERE ROWNUM = 1;
```

`ORDER BY`와 같은 레벨에 `ROWNUM`을 두면 **정렬 전에** 잘린다.

## JOIN · NULL · 그룹별 최댓값 행

```sql
-- LEFT JOIN으로 없는 쪽
SELECT O.id, O.name
FROM outs O
LEFT JOIN ins I ON O.id = I.id
WHERE I.id IS NULL;

-- 그룹별 최댓값 "행"
SELECT A.*
FROM t A
JOIN (
  SELECT k, MAX(v) AS mv FROM t GROUP BY k
) B ON A.k = B.k AND A.v = B.mv;
```

## 문자열·날짜 한 줄

```sql
SELECT a || b FROM dual;
SELECT TO_CHAR(datetime, 'YYYY-MM-DD') FROM animal_ins;
SELECT TO_CHAR(datetime, 'HH24') AS hour, COUNT(*)
FROM animal_outs
WHERE TO_CHAR(datetime, 'HH24') BETWEEN '09' AND '19'
GROUP BY TO_CHAR(datetime, 'HH24')
ORDER BY hour;
```
