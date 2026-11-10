# Ch1. 출력 (Java) — 개념 정리 노트

> Trail 1 · Chapter 1. 출력 (lesson 2 변수와 자료형 포함)

> 각 개념은 **핵심 요약 → 예시 코드 → 주의할 점** 순서로 정리합니다.

---

## 📌 목차

1. [코드 기본 틀 — `class Main`, `main`, `import`](#1-코드-기본-틀--class-main-main-import)
2. [타입 — `int` vs `Integer`, `'a'` vs `"a"`, `==` vs `.equals()`](#2-타입--int-vs-integer-a-vs-a--vs-equals)

---

## 1. 코드 기본 틀 — `class Main`, `main`, `import`

### 핵심 요약
```java
import java.util.*;      // Scanner, HashMap, ArrayList 등 한 번에
import java.io.*;        // BufferedReader (빠른 입력용)

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
    }
}
```

| 개념 | 핵심 |
|---|---|
| `class Main` | Java는 모든 코드가 클래스 안에 있어야 한다. 채점기가 `Main`을 찾으니 **이름 고정** |
| `public static void main` | 프로그램 시작점. `static` = 객체 없이 호출 가능, `void` = 반환값 없음 |
| `import java.util.*` | `*`로 한 번에 가져와도 **실행 속도에 영향 없음**. 단, `java.io`는 따로 import 필요 |

### 주의할 점
- 파이썬은 파일에 바로 코드를 쓰지만, Java는 `class Main { main { ... } }` 안에 써야 실행된다.
- `main` 밖에 둔 변수를 `main`에서 쓰려면 `static`이 필요하다 → [1차원 배열 2번](ch7_1차원배열.md#2-main-밖에-선언하는-public-static--상수-final)

### 🧩 확인 문제
**Q. main 밖(클래스 바로 아래)에 배열을 선언하고 main에서 쓰려면 꼭 붙여야 하는 키워드는?**

<details><summary>해설</summary>

**`static`**이에요. `main`이 `static`이라 객체 없이 실행되는데, `static`이 없는 필드는 객체를 만들어야 생겨요. 그래서 `main`에서 쓸 필드에는 `static`이 필요해요.

</details>

---

## 2. 타입 — `int` vs `Integer`, `'a'` vs `"a"`, `==` vs `.equals()`

### 핵심 요약

| 비교 | 차이 |
|---|---|
| `int` vs `Integer` | 기본 타입 vs 객체. **변수·배열은 `int`, 컬렉션 `<>` 안에는 `Integer`** |
| `'a'` vs `"a"` | `char`(글자 하나) vs `String`. 파이썬과 달리 **따옴표 종류가 다르면 다른 타입** |
| `==` vs `.equals()` | `==`는 객체에서 **주소 비교**. `String`·`Integer` 내용 비교는 `.equals()` |

### 예시 코드
```java
char c = 'r';                 // ⭕ 글자 하나
String s = "red";             // ⭕ 문자열
// String s = 'red';          // ❌ 컴파일 오류

if (cmd.equals("add")) { }    // ⭕ 문자열 내용 비교
if (c == 't') { }             // ⭕ char는 기본 타입이라 == 안전
```

### 주의할 점
- ⚠️ **언박싱:** `Integer`를 `int`로 바꿀 때 값이 `null`이면 `NullPointerException`.
  (HashMap의 없는 key를 `get()`해서 `int`에 넣을 때 자주 터짐 → [HashMap 1번](../trail5/ch1_중급자료구조.md))
- ⚠️ **Integer 캐시:** `-128 ~ 127`은 `Integer`끼리 `==`가 우연히 `true`, **128부터는 `false`**.
  예제(작은 수)는 통과하고 제출하면 틀리는 원인 → `Integer`끼리는 `.equals()`.
- `char`는 기본 타입이라 `==` 비교가 안전하다.

### 🧩 확인 문제
**Q. 다음 중 컴파일 오류가 나는 것은? (a) `String s = 'red';` (b) `char c = 'r';` (c) `if (cmd.equals("add"))`**

<details><summary>해설</summary>

**(a)**예요. 작은따옴표는 `char`라서 글자 하나만 들어가요. 문자열은 반드시 `"red"`로 써야 해요.

</details>

---

## ✅ 한눈에 복습
- [ ] 클래스 이름은 `Main` 고정, 시작점은 `public static void main(String[] args)`
- [ ] `import java.util.*;` 하나로 Scanner·HashMap·ArrayList 해결 (속도 영향 없음)
- [ ] 변수·배열은 `int`, `HashMap<>` 안은 `Integer`
- [ ] `'a'`는 char, `"a"`는 String — 섞으면 컴파일 오류
- [ ] String·Integer 내용 비교는 `.equals()`, char는 `==` OK
- [ ] Integer `==`는 127까지만 우연히 맞는다 (128부터 false)
