# Ch1. 출력 (Java) — 개념 정리 노트

> Trail 1 · Chapter 1. 출력 (lesson 2 변수와 자료형 포함)

> 각 개념은 **핵심 요약 → 예시 코드 → 주의할 점** 순서로 정리합니다.

---

## 📌 목차

1. [코드 기본 틀 — `class Main`, `main`, `import`](#1-코드-기본-틀--class-main-main-import)
2. [타입 — `int` vs `Integer`, `'a'` vs `"a"`, `==` vs `.equals()`](#2-타입--int-vs-integer-a-vs-a--vs-equals)
3. [이스케이프 문자 — `\"`, `\'`, `\\`, `\n`](#3-이스케이프-문자-----n)
4. [`printf`로 형식 맞춰 출력하기 — `%d`, `%f`, `%.2f`, `%s`](#4-printf로-형식-맞춰-출력하기--d-f-2f-s)

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

## 3. 이스케이프 문자 — `\"`, `\'`, `\\`, `\n`

### 핵심 요약
- 문자열 `"..."` 안에 큰따옴표를 넣으려면 **`\"`**처럼 앞에 `\`를 붙인다. (그냥 `"`를 쓰면 문자열이 거기서 끝나 버림)

| 이스케이프 | 출력 | 문자열 `"..."` 안에서 | 문자 `'...'` 안에서 |
|---|---|---|---|
| `\"` | `"` | **필수** | 써도 되고 안 써도 됨 |
| `\'` | `'` | 써도 되고 안 써도 됨 (`'` 그대로 OK) | **필수** (`'\''`) |
| `\\` | `\` | 필수 | 필수 |
| `\n` | 줄바꿈 | | |
| `\t` | 탭 | | |

- `\'`는 문자열 안에서도 **정상적인 이스케이프**다. 오류가 아니다. 다만 `"It's"`처럼 그냥 써도 되니 굳이 쓸 필요가 없을 뿐이다.
- 정의되지 않은 조합(`\q`, `\d` 등)만 `illegal escape character` 컴파일 오류가 난다.

### 예시 코드
**문제:** `He says "It's a really simple sentence"` 출력하기
```java
// ❌ 내가 쓴 코드 — 컴파일은 되지만 오답
System.out.println("He says \"It\' a really simple sentence\"");
// 출력: He says "It' a really simple sentence"   ← 's'가 빠짐!

// ✅ 정답
System.out.println("He says \"It's a really simple sentence\"");
// 출력: He says "It's a really simple sentence"
```

### 주의할 점
- ⚠️ **"`\'`라서 오류"는 틀린 설명이다.** (직접 `javac`로 확인함) 진짜 원인은 **`It\'` 뒤에 `s`를 빠뜨린 오타** → 출력이 달라서 오답.
- 오류가 났다면 **컴파일 오류인지, 출력이 틀린 오답인지** 먼저 구분하자. 출력 문제는 예상 출력과 한 글자씩 비교.
- 파이썬은 `'...'`와 `"..."` 둘 다 문자열이라 `'He says "It\'s ..."'`처럼 따옴표를 바꿔 피할 수 있지만,
  Java는 `'...'`가 `char`라서 문자열은 **항상 `"..."`** → 안의 `"`는 무조건 `\"`.

### 🧩 확인 문제
**Q. `System.out.println("I\'m \"OK\"");`는 컴파일될까요? 된다면 출력은?**

<details><summary>해설</summary>

**컴파일돼요.** `\'`도 `\"`도 정상 이스케이프예요. 출력은 `I'm "OK"`예요. 문자열 안의 `'`는 `\'` 없이 그냥 `'`로 써도 같은 결과예요.

</details>

---

## 4. `printf`로 형식 맞춰 출력하기 — `%d`, `%f`, `%.2f`, `%s`

### 핵심 요약
- `System.out.printf("형식", 값1, 값2, ...)`: 형식 문자열의 **`%` 자리에 값을 순서대로** 넣어 출력한다.
- `%` 뒤 글자가 **들어갈 값의 자료형**을 정한다.

| 형식 | 자료형 | 예시 → 출력 | 파이썬 f-string |
|---|---|---|---|
| `%d` | 정수 (`int`, `long`) | `printf("%d", 7)` → `7` | `f"{a}"` |
| `%f` | 실수 (기본 소수점 6자리) | `printf("%f", 3.14159)` → `3.141590` | `f"{d:f}"` |
| `%.2f` | 실수, 소수점 2자리 (반올림) | `printf("%.2f", 3.14159)` → `3.14` | `f"{d:.2f}"` |
| `%s` | 문자열 | `printf("%s", "kim")` → `kim` | `f"{s}"` |
| `%c` | 문자 (`char`) | `printf("%c", 'A')` → `A` | |
| `%n` | 줄바꿈 (`\n`과 같은 역할) | | |
| `%%` | `%` 글자 자체 | `printf("%d%%", 50)` → `50%` | |

**자리수 맞추기**

| 형식 | 출력 (`a = 7`) | 의미 |
|---|---|---|
| `%5d` | `[    7]` | 5칸, 오른쪽 정렬 |
| `%-5d` | `[7    ]` | 5칸, 왼쪽 정렬 |
| `%05d` | `[00007]` | 5칸, 빈칸을 0으로 (파이썬 `:05d`) |

### 예시 코드
```java
int a = 7;
double d = 3.14159;
String s = "kim";
char c = 'A';

System.out.printf("%d %f %.2f %s %c%n", a, d, d, s, c);
// 7 3.141590 3.14 kim A
```
- 출력하지 않고 **문자열로 만들기만** 하려면 `String.format(...)`:
  ```java
  String t = String.format("%.3f", d);   // "3.142"
  ```

### 주의할 점
- ⚠️ **`printf`는 자동 줄바꿈이 없다.** (`println`과 다름) 끝에 `%n` 또는 `\n`을 붙인다.
- ⚠️ **자료형이 안 맞으면 실행 중 오류.** `printf("%d", 3.5)` → `IllegalFormatConversionException`. 실수는 `%f`, 정수는 `%d`.
- ⚠️ 값의 개수·순서가 `%` 개수·순서와 맞아야 한다. 모자라면 `MissingFormatArgumentException`.
- 반올림이 파이썬과 다를 수 있다: `printf("%.1f", 2.25)` → Java는 **`2.3`**, 파이썬 `f"{2.25:.1f}"`은 `2.2`. (직접 실행해서 확인함)
- 문자열의 `%`를 그대로 찍고 싶으면 `%%`.

### 🧩 확인 문제
**Q. `System.out.printf("%d", 10 / 4.0);`는 어떻게 될까요?**

<details><summary>해설</summary>

**실행 중 오류**(`IllegalFormatConversionException`)가 나요. `10 / 4.0`은 `2.5`인 실수(`double`)인데 `%d`는 정수 자리예요. `%f`나 `%.1f`를 써야 해요.

</details>

---

## ✅ 한눈에 복습
- [ ] 클래스 이름은 `Main` 고정, 시작점은 `public static void main(String[] args)`
- [ ] `import java.util.*;` 하나로 Scanner·HashMap·ArrayList 해결 (속도 영향 없음)
- [ ] 변수·배열은 `int`, `HashMap<>` 안은 `Integer`
- [ ] `'a'`는 char, `"a"`는 String — 섞으면 컴파일 오류
- [ ] String·Integer 내용 비교는 `.equals()`, char는 `==` OK
- [ ] Integer `==`는 127까지만 우연히 맞는다 (128부터 false)
- [ ] 문자열 안 `"`는 `\"` 필수, `'`는 그냥 써도 됨 (`\'`도 오류 아님)
- [ ] 오류인지 오답인지 먼저 구분 — 출력은 한 글자씩 비교
- [ ] `printf`: 정수 `%d`, 실수 `%f` / `%.2f`, 문자열 `%s`, 문자 `%c` — 줄바꿈은 `%n` 직접
- [ ] `%05d`는 0 채우기, `%%`는 % 글자, 문자열로 만들기는 `String.format`

---

## 11/12 Day1 — 새로 안 것 3줄
1. 시작점 시그니처는 `public static void main(String[] args)` 고정 · 코드는 전부 `class Main` 안에.
2. Java는 `int a = 3;`처럼 **타입을 앞에 붙여** 변수를 선언한다 (파이썬과 다름).
3. 출력은 `System.out.println(...)` · 형식 맞출 땐 `System.out.printf("%d", a)` (`printf`는 줄바꿈 자동 없음 → `%n`).

## 11/13 Day2 — 새로 안 것 3줄
1. 실수는 `double` · `printf`에서 소수 자릿수는 `%.6f`처럼 `.` + 자리수 + `f`.
2. `printf`는 줄바꿈이 없으니 끝에 `%n`(또는 `\n`)을 붙인다.
3. `int`와 `double`을 곱하면 결과는 `double` → 출력 형식도 `%f` 쪽.
