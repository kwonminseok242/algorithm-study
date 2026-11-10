# Ch1. 중급 자료구조 (Java) — 개념 정리 노트

> Trail 5 · Chapter 1. 중급 자료구조
> 각 개념은 **핵심 요약 → 예시 코드 → 주의할 점** 순서로 정리합니다.

---

## 📌 목차

1. [HashMap — key/value 쌍을 O(1)에 다루기](#1-hashmap--keyvalue-쌍을-o1에-다루기)
2. [key를 문자열로 쓰기 — `HashMap<String, Integer>`](#2-key를-문자열로-쓰기--hashmapstring-integer)
3. [문자열 → index 역방향 저장으로 O(N) 탐색을 O(1)로](#3-문자열--index-역방향-저장으로-on-탐색을-o1로)
4. [`map.values()` — 값만 꺼내서 돌기 + `Math.max`로 최댓값](#4-mapvalues--값만-꺼내서-돌기--mathmax로-최댓값)
5. [HashMap 메서드 총정리 + 자료구조 고르기](#5-hashmap-메서드-총정리--자료구조-고르기)
6. [풀어본 문제 패턴](#6-풀어본-문제-패턴)

---

## 1. HashMap — key/value 쌍을 O(1)에 다루기

### 핵심 요약
- **해싱** 기반 자료구조. `(key, value)` 쌍으로 저장하고, key로 value를 찾는다. (파이썬의 `dict`)
- 삽입·삭제·탐색이 모두 평균 **O(1)** → **TreeMap보다 빠르다.**
- 대신 **값 자체에 순서가 없다.** (순서를 신경 쓰지 않을 때 쓰는 자료구조. 정렬된 순서가 필요하면 TreeMap)
- 선언: `import java.util.HashMap;` 후 `HashMap<K, V> m = new HashMap<>();`
  - `K` = key 타입, `V` = value 타입
  - 정수 → 정수라면 `HashMap<Integer, Integer>` (`int`가 아니라 **`Integer`**로 써야 한다)

| 메서드 | 하는 일 | 파이썬 dict |
|---|---|---|
| `m.put(K, V)` | 쌍 추가 (이미 있는 key면 value 덮어쓰기) | `m[k] = v` |
| `m.remove(K)` | key가 K인 쌍 제거 | `del m[k]` |
| `m.get(K)` | key가 K인 value 반환 | `m[k]` |
| `m.containsKey(K)` | key K가 있는지 `true/false` | `k in m` |
| `m.getOrDefault(K, D)` | 있으면 value, 없으면 D | `m.get(k, d)` |

### 예시 코드

```java
import java.util.HashMap;

public class Main {
    public static void main(String[] args) {
        HashMap<Integer, Integer> m = new HashMap<>(); // 정수 → 정수

        m.put(5, 6);
        m.put(2, 2);
        m.put(10, 1);

        if (m.containsKey(2))                 // key 2가 있으면
            System.out.println(m.get(2));     // 2 출력

        m.remove(5);                          // key 5 제거

        if (!m.containsKey(5))
            System.out.println("not exists!");

        m.put(2, 10);                         // key 2의 value를 10으로 덮어쓰기
        System.out.println(m.get(2));         // 10
    }
}
```
```
2
not exists!
10
```

### 주의할 점
- ⚠️ **없는 key를 `get()`하면 에러가 아니라 `null`이 나온다.** 이걸 `int`에 담으면 `NullPointerException`.
  → 미리 `containsKey()`로 확인하거나, **`getOrDefault(K, 0)`**를 쓴다.
- 개수 세기(count) 패턴에서 특히 많이 쓴다:
  ```java
  m.put(x, m.getOrDefault(x, 0) + 1);   // 파이썬: m[x] = m.get(x, 0) + 1
  ```
- `put()`은 같은 key가 있으면 **새 쌍이 추가되는 게 아니라 value가 바뀐다.**

---

## 2. key를 문자열로 쓰기 — `HashMap<String, Integer>`

### 핵심 요약
- key 타입을 `String`으로 하면 **"배열 index가 문자열인 것처럼"** 쓸 수 있다.

### 예시 코드

```java
import java.util.HashMap;

public class Main {
    public static void main(String[] args) {
        HashMap<String, Integer> m = new HashMap<>();
        m.put("banana", 6);
        m.put("helloworld", 2);
        m.put("apple", 5);

        System.out.println(m.get("banana")); // 6
    }
}
```

### 주의할 점
- 단어 개수 세기에 바로 응용 가능: `m.put(word, m.getOrDefault(word, 0) + 1);`
  (단어는 `sc.next()`로 받으면 된다 → [Trail1 Ch2. 입출력](../trail1/ch2_입출력.md))

---

## 3. 문자열 → index 역방향 저장으로 O(N) 탐색을 O(1)로

### 핵심 요약
- 문제: 서로 다른 문자열 n개가 주어지고, 문자열 K가 **몇 번째**로 주어졌는지 구하기.
  예) `["aba", "banana", "apple", "code", "tree", "foo"]`, K = `"banana"` → **2**
- for문으로 배열을 처음부터 훑으면 **O(N)**.
- 입력받을 때 **HashMap에 `문자열 → 몇 번째` 를 같이 저장**해 두면, 질문이 왔을 때 `get(K)` 한 번 → **O(1)**.
  - 배열 `arr`: index → 문자열 (`arr[1]` = `"banana"`)
  - HashMap `stringToIndex`: 문자열 → index (`"banana"` → 2) ← **배열의 반대 방향**

### 예시 코드

```java
import java.util.Scanner;
import java.util.HashMap;

public class Main {
    public static final int MAX_N = 6;                 // 상수 (값 변경 불가)

    public static String[] arr = new String[MAX_N];    // 문자열 6칸짜리 배열
    public static HashMap<String, Integer> stringToIndex = new HashMap<>();

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        int n = sc.nextInt();
        for (int i = 0; i < n; i++) {
            arr[i] = sc.next();                 // 단어 하나씩 받아서 배열에 저장
            stringToIndex.put(arr[i], i + 1);   // "몇 번째"는 1부터라 i + 1
        }

        String k = sc.next();
        System.out.println(stringToIndex.get(k));
    }
}
```
```
입력:
6
aba banana apple code tree foo
banana
출력:
2
```

파이썬으로 치면:
```python
n = int(input())
arr = input().split()
string_to_index = {s: i + 1 for i, s in enumerate(arr)}
print(string_to_index[input()])
```

### 주의할 점
- ⚠️ 배열 index는 0부터지만 문제는 "몇 번째"(1부터) → `put(arr[i], i + 1)`.
- 이 방법은 문자열이 **서로 다를 때**만 성립한다. 같은 문자열이 또 나오면 `put()`이 덮어써서 **마지막 위치**가 남는다.
- `public static final int MAX_N`, `public static String[] arr` 처럼 `main` **밖**에 선언하는 이유와 배열 선언법 → [Trail1 Ch7. 1차원 배열](../trail1/ch7_1차원배열.md)

---

## 4. `map.values()` — 값만 꺼내서 돌기 + `Math.max`로 최댓값

### 핵심 요약
- `map.values()`: 맵의 **값(value)들만** 꺼낸다. 파이썬 `d.values()`와 같다.
- HashMap은 index가 없어서 `map.values()[0]`은 안 된다 → **향상된 for문**으로 돈다. ([for-each 정리](../trail1/ch5_단순반복문.md))
- `<String, Integer>`의 값이 `Integer`라도 `int cnt`로 받으면 **자동 언박싱**(`Integer` → `int`)된다.
  맵에 실제로 들어있는 값이라 `null` 걱정은 없다.
- `Math.max(a, b)`: 둘 중 큰 값. 파이썬 `max(a, b)`. ([Math.max 정리](../trail1/ch7_1차원배열.md#3-mathmax--mathmin--둘-중-큰작은-값))

### 예시 코드

**가장 많이 나온 단어의 횟수 구하기** (count → 최댓값 패턴)
```java
HashMap<String, Integer> map = new HashMap<>();
for (int i = 0; i < n; i++) {
    String word = sc.next();
    map.put(word, map.getOrDefault(word, 0) + 1);   // 개수 세기
}

int ans = 0;
for (int cnt : map.values()) {      // 예: 3, 3, 1이 차례로 cnt에 들어옴
    ans = Math.max(ans, cnt);
}
System.out.println(ans);
```
```python
ans = 0
for cnt in d.values():
    ans = max(ans, cnt)
# 또는 max(d.values())
```

### 주의할 점
- 값의 **순서는 보장되지 않는다** (HashMap은 순서가 없음). 최댓값·합계처럼 순서와 상관없는 계산에 쓴다.
- key가 필요하면 `map.keySet()`, key와 value 둘 다 필요하면 `map.entrySet()` (나중에 정리).

---

## 5. HashMap 메서드 총정리 + 자료구조 고르기

### 핵심 요약

| 메서드 | 동작 | 키가 없을 때 |
|---|---|---|
| `put(k, v)` | 저장. 같은 키면 덮어씀 | 새로 추가 |
| `get(k)` | 값 꺼내기 | `null` (오류 아님) |
| `getOrDefault(k, d)` | 값 꺼내기 | 기본값 `d` |
| `remove(k)` | 삭제 | 아무 일 없음 (`null` 반환) |
| `containsKey(k)` | 키 존재 여부 | `false` |
| `putIfAbsent(k, v)` | **없을 때만** 저장 | 추가 |
| `values()` / `keySet()` / `entrySet()` | 값 / 키 / 둘 다 순회 | |

- `get`과 `remove` 자체는 오류가 안 난다. **결과를 `int`에 넣거나 `+1` 할 때 언박싱 오류**가 난다.
- 개수 세기 패턴: `map.put(s, map.getOrDefault(s, 0) + 1);`
- **자료구조 고르기:** 키가 `0 ~ N` 정수면 **배열**, 문자열이거나 띄엄띄엄 큰 숫자면 **HashMap**.
- **역방향 맵:** "값으로 위치 찾기"가 필요하면 `문자열 → 번호` HashMap을 같이 만든다. 배열을 뒤지면 O(n), 맵은 O(1) (3번 참고).

### 🧩 확인 문제
**Q. `map.put(str, map.get(str) + 1);`이 처음 나온 단어에서 터지는 이유는?**

<details><summary>해설</summary>

처음 나온 단어는 `get`이 `null`을 돌려주는데, `null + 1`을 하려고 `int`로 언박싱하다가 `NullPointerException`이 나요. 그래서 `getOrDefault(str, 0)`을 써요.

</details>

---

## 6. 풀어본 문제 패턴

| 문제 | 패턴 |
|---|---|
| [hashmap 기본](../../trail5/hashmap%20기본) | `put` / `remove` / `containsKey`로 명령 처리 |
| [가장 많은 데이터](../../trail5/가장%20많은%20데이터) | 개수 세기 (`getOrDefault + 1`) + 최댓값 (`Math.max`) — 4번 |
| 문자열 → 위치 | 역방향 HashMap — 3번 |
| [대응되는 수와 문자](../../trail5/대응되는%20수와%20문자) | 배열(번호 → 문자열) + HashMap(문자열 → 번호) **양방향** — [문자 판별](../trail1/ch9_문자열.md) |

---

## ✅ 한눈에 복습

- [ ] 선언은 `HashMap<Integer, Integer> m = new HashMap<>();` (`int` ❌ `Integer` ⭕)
- [ ] `put / remove / get / containsKey / getOrDefault` 다섯 개
- [ ] HashMap은 O(1)이고 순서 없음, 순서 필요하면 TreeMap
- [ ] 없는 key의 `get()`은 `null` → `getOrDefault(K, 0)`로 피하기
- [ ] key를 `String`으로 하면 문자열 index 배열처럼 쓸 수 있다
- [ ] "몇 번째인지" 자주 물어보면 `문자열 → index`를 HashMap에 미리 저장 → O(N)이 O(1)로
- [ ] 값만 돌 때 `for (int cnt : map.values())`, 최댓값은 `ans = Math.max(ans, cnt)`
- [ ] 없는 키: `get`→null, `remove`→아무 일 없음, 터지는 건 언박싱할 때
- [ ] `putIfAbsent`는 없을 때만 저장
- [ ] 키가 0~N 정수면 배열, 문자열·큰 수면 HashMap
- [ ] 양방향 문제는 배열(번호→문자열) + HashMap(문자열→번호) 둘 다 만든다
