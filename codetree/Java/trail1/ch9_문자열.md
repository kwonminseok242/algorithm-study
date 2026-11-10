# Ch9. 문자열 (Java) — 개념 정리 노트

> Trail 1 · Chapter 9. 문자열

> 각 개념은 **핵심 요약 → 예시 코드 → 주의할 점** 순서로 정리합니다.

---

## 📌 목차

1. [문자 다루기 — `charAt`, `Character.isDigit` / `isLetter`](#1-문자-다루기--charat-characterisdigit--isletter)

---

## 1. 문자 다루기 — `charAt`, `Character.isDigit` / `isLetter`

### 핵심 요약

| Java | Python | 의미 |
|---|---|---|
| `s.charAt(i)` | `s[i]` | i번째 글자 (`char`) |
| `s.length()` | `len(s)` | 길이 (배열은 괄호 없는 `arr.length`) |
| `Character.isDigit(c)` | `c.isdigit()` | 숫자 글자인가 |
| `Character.isLetter(c)` | `c.isalpha()` | 알파벳인가 |
| `Integer.parseInt(s)` | `int(s)` | 문자열 → 정수 |

- Java는 문자열에 **`s[0]`처럼 대괄호를 못 쓴다** → `s.charAt(0)`.
- **판별은 첫 글자로, 변환은 전체로:** `isDigit(q.charAt(0))`로 숫자 질문인지 확인하고, `Integer.parseInt(q)`로 전체를 변환.

### 예시 코드
```java
String q = sc.next();
if (Character.isDigit(q.charAt(0))) {     // 숫자로 시작 → 숫자 질문
    int num = Integer.parseInt(q);
    System.out.println(words[num]);
} else {                                   // 문자열 질문
    System.out.println(wordToNum.get(q));
}
```

### 주의할 점
- 첫 글자만 보는 건 "문자열은 알파벳으로만 구성"이라는 **문제 조건이 있어서** 가능한 것이다.
- `charAt()`의 결과는 `char` → 비교는 `'t'` (작은따옴표).

### 🧩 확인 문제
**Q. `q.charAt(0) == "t"`가 컴파일 오류인 이유는?**

<details><summary>해설</summary>

`charAt`은 `char`를 돌려주는데 `"t"`는 `String`이라 타입이 달라요. `'t'`로 써야 해요.

</details>

---

## ✅ 한눈에 복습
- [ ] `s[i]` ❌ → `s.charAt(i)`, 결과는 char라 `'t'`와 비교
- [ ] 숫자 판별은 `Character.isDigit(q.charAt(0))`, 변환은 `Integer.parseInt(q)`
