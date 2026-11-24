# Ch2. 입출력 (Java) — 개념 정리 노트

> Trail 1 · Chapter 2. 입출력
> 각 개념은 **핵심 요약 → 예시 코드 → 주의할 점** 순서로 정리합니다.

---

## 📌 목차

1. [`Scanner`로 입력받기 — 자료형마다 메서드가 다르다](#1-scanner로-입력받기--자료형마다-메서드가-다르다)
2. [Scanner는 토큰 단위 + 커서 / `Integer.parseInt`](#2-scanner는-토큰-단위--커서--integerparseint)

---

## 1. `Scanner`로 입력받기 — 자료형마다 메서드가 다르다

### 핵심 요약
- Java는 `Scanner`로 입력을 받는다. `import java.util.Scanner;`가 필요하다.
- 파이썬의 `input()`은 **무조건 문자열**로 받고 `int()`로 바꿨지만,
  Java는 **받을 때부터 어떤 자료형으로 읽을지 메서드로 고른다.**

| 메서드 | 읽는 것 | 반환 타입 | 파이썬으로 치면 |
|---|---|---|---|
| `sc.nextInt()` | 공백/줄바꿈 전까지의 **정수 하나** | `int` | `int(...)` 한 토큰 |
| `sc.nextLong()` | 큰 정수 하나 | `long` | `int(...)` |
| `sc.nextDouble()` | 실수 하나 | `double` | `float(...)` |
| `sc.next()` | 공백/줄바꿈 전까지의 **단어(문자열) 하나** | `String` | `input().split()`의 한 칸 |
| `sc.nextLine()` | **줄 전체** (공백 포함) | `String` | `input()` |
| `sc.next().charAt(0)` | 문자 하나 | `char` | `input()[0]` |

- `nextInt()`와 `next()`는 **공백 기준으로 하나씩(토큰 단위)** 읽는다.
  그래서 `3 5`처럼 한 줄에 여러 값이 있어도 `split()` 없이 그냥 두 번 호출하면 된다.

### 예시 코드

```java
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        int a = sc.nextInt();       // 정수
        int b = sc.nextInt();       // 같은 줄에 있어도 OK
        String name = sc.next();    // 단어 하나 (공백 전까지)

        System.out.println(a + b);
        System.out.println(name);
    }
}
```
```
입력:
3 5
apple
출력:
8
apple
```

### 주의할 점
- ⚠️ `next()`는 **공백 앞까지만** 읽는다. `"hello world"`를 `next()`로 받으면 `"hello"`만 들어온다.
  공백 포함 한 줄 전체가 필요하면 `nextLine()`.
- ⚠️ **`nextInt()` 뒤에 바로 `nextLine()`을 쓰면 빈 문자열이 들어온다.**
  `nextInt()`는 숫자만 읽고 줄바꿈(`\n`)을 남겨두기 때문에, 다음 `nextLine()`이 그 남은 줄바꿈만 읽고 끝난다.
  ```java
  int n = sc.nextInt();
  sc.nextLine();              // 남은 줄바꿈 버리기
  String line = sc.nextLine(); // 이제 진짜 다음 줄
  ```
- 문자열 비교는 `==`가 아니라 `.equals()` (`name.equals("apple")`).

---

## 2. Scanner는 토큰 단위 + 커서 / `Integer.parseInt`

### 핵심 요약
- Scanner는 줄 단위가 아니라 **단어(토큰) 단위**로 읽는다.
  입력 전체를 공백·줄바꿈으로 나뉜 단어들의 한 줄로 보고, **커서가 하나씩 앞으로 이동**한다.
- `sc.nextLine()`만 예외로 **커서부터 그 줄 끝까지** 읽는다.
- `Integer.parseInt(s)`: 문자열 → 정수. 파이썬 `int(s)`.
- `next()` / `nextInt()`만 쓰면 `split()`이 필요 없다.

### 예시 코드
```java
// 입력: add 3 5
String cmd = sc.next();     // "add"  → 커서는 같은 줄의 3 앞
int a = sc.nextInt();       // 3
int b = sc.nextInt();       // 5

String q = sc.next();       // "123" 같은 문자열로 받았다면
int num = Integer.parseInt(q);   // 123
```

### 주의할 점
- 입력이 아주 크면 Scanner가 느리다 → `BufferedReader` + `split`을 쓴다 (`import java.io.*` 필요).
- 함정 복습: `nextInt()` 다음 `nextLine()` → 남은 줄바꿈 때문에 `""` (1번 참고).

### 🧩 확인 문제
**Q. 입력이 `add 3 5`일 때, `sc.next()`로 "add"를 읽은 직후 커서는 어디에 있을까요?**

<details><summary>해설</summary>

같은 줄의 **3 바로 앞**이에요. 다음 줄로 넘어가지 않아요. 그래서 이어서 `nextInt()`를 부르면 3이 읽혀요.

</details>

---

## ✅ 한눈에 복습

- [ ] 정수는 `nextInt()`, 단어는 `next()`, 한 줄 전체는 `nextLine()`
- [ ] 한 줄에 여러 값이 있어도 `nextInt()`를 여러 번 부르면 된다 (split 필요 없음)
- [ ] `nextInt()` 다음 `nextLine()`은 빈 줄을 먹는다 → 중간에 `sc.nextLine()` 한 번 더
- [ ] Scanner는 토큰 단위, 커서가 단어 하나씩 이동 (줄을 넘지 않음)
- [ ] 문자열 → 정수는 `Integer.parseInt(s)`
- [ ] 입력이 크면 `BufferedReader`
