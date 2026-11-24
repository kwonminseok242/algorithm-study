# Ch5. 단순 반복문 (Java) — 개념 정리 노트

> Trail 1 · Chapter 5. 단순 반복문
> 각 개념은 **핵심 요약 → 예시 코드 → 주의할 점** 순서로 정리합니다.

---

## 📌 목차

1. [향상된 for문 (for-each) — `for (int x : arr)`](#1-향상된-for문-for-each--for-int-x--arr)
2. [Python ↔ Java 반복문·조건문 대응표](#2-python--java-반복문조건문-대응표)

---

## 1. 향상된 for문 (for-each) — `for (int x : arr)`

### 핵심 요약
- 배열이나 컬렉션의 원소를 **처음부터 끝까지 하나씩 다 꺼내는** for문이다.
- **조건이 없는 이유:** "전부 하나씩 꺼내라"는 뜻이라 끝을 정해 줄 필요가 없다. 다 꺼내면 알아서 끝난다.
  파이썬 `for x in arr:`에도 조건이 없는 것과 같다.
- **`:`는 "in"으로 읽는다.**

```
for (int cnt  :  map.values())
     ───┬───  ┬  ──────┬─────
  꺼낸 값을 담을 변수  in   꺼낼 대상
    (타입 + 이름)
```

| | 기본 for | 향상된 for |
|---|---|---|
| 모양 | `for (int i = 0; i < n; i++)` | `for (int x : arr)` |
| 변수에 들어가는 것 | 번호 (0, 1, 2...) | 원소 값 자체 |
| 조건 | 직접 써야 함 | 필요 없음 (끝까지 자동) |
| Python 대응 | `for i in range(n)` | `for x in arr` |

### 예시 코드

**배열에서는 둘이 같은 일을 한다**
```java
int[] arr = {3, 3, 1};

for (int i = 0; i < arr.length; i++) {
    System.out.println(arr[i]);   // 번호로 꺼냄
}

for (int x : arr) {
    System.out.println(x);        // 값을 바로 받음
}
```

**HashMap의 값 돌기** ([HashMap 노트 4번](../trail5/ch1_중급자료구조.md#4-mapvalues--값만-꺼내서-돌기--mathmax로-최댓값))
```java
for (int cnt : map.values()) {    // 3, 3, 1이 차례로 cnt에 들어옴
    ...
}
```
```python
for cnt in d.values():
    ...
```

### 주의할 점
- ⚠️ **HashMap은 번호(인덱스)가 없다.** `map.values()[0]` 같은 접근이 안 된다 → 맵을 돌 때는 향상된 for를 쓴다.
- ⚠️ 향상된 for에서는 **몇 번째인지(i)를 모른다.** index가 필요하면 기본 for를 쓴다.
- ⚠️ 꺼낸 변수 `x`를 바꿔도 배열 값은 안 바뀐다 (`x = 0;` 해도 `arr`는 그대로). 배열 값을 고치려면 `arr[i] = ...`.
- 변수 타입은 원소 타입과 맞춘다: `int[]` → `int x`, `String[]` → `String s`.

---

## 2. Python ↔ Java 반복문·조건문 대응표

### 핵심 요약

| Python | Java |
|---|---|
| `for i in range(n)` | `for (int i = 0; i < n; i++)` |
| `for i in range(1, n+1)` | `for (int i = 1; i <= n; i++)` |
| `for x in arr` | `for (int x : arr)` (향상된 for) |
| `elif` | `else if` |

- 향상된 for는 **인덱스를 모르고**, 꺼낸 값은 **복사본**이라 바꿔도 원본이 안 바뀐다 (1번 참고).
- 위치가 필요하면 기본 for, 값만 필요하면 향상된 for.

### 🧩 확인 문제
**Q. 배열에서 짝수 번째 원소만 출력하려면 기본 for와 향상된 for 중 무엇이 맞을까요?**

<details><summary>해설</summary>

**기본 for**예요. 위치(인덱스)가 필요하니까요. 값만 필요하면 향상된 for를 써요.

</details>

---

## ✅ 한눈에 복습

- [ ] `for (타입 변수 : 대상)` — `:`는 "in", 조건 없이 끝까지 자동
- [ ] 기본 for는 번호, 향상된 for는 값 자체가 들어온다
- [ ] index가 필요하거나 배열 값을 바꿔야 하면 기본 for
- [ ] HashMap은 index가 없으니 향상된 for로 돈다
- [ ] `range(1, n+1)` ↔ `for (int i = 1; i <= n; i++)`, `elif` ↔ `else if`
- [ ] 위치가 필요하면 기본 for, 값만 필요하면 향상된 for
