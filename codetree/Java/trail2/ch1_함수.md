# Ch1. 함수 (Java) — 개념 정리 노트

> Trail 2 · Chapter 1. 함수 (lesson 4 변수의 영역)

> 각 개념은 **핵심 요약 → 예시 코드 → 주의할 점** 순서로 정리합니다.

---

## 📌 목차

1. [변수의 위치와 스코프](#1-변수의-위치와-스코프)

---

## 1. 변수의 위치와 스코프

### 핵심 요약
- 변수는 **선언된 `{ }` 안에서만** 살아있다.
  `for (int i ...)`의 `i`는 반복문이 끝나면 사라진다. (파이썬은 반복문 뒤에도 `i`가 남아 있어서 다르다)
- `main` 안에 쓰면 **지역 변수**, 클래스 바로 아래에 쓰면 **필드**(다른 함수에서도 사용 가능, `static` 필요).
- `final`은 상수: `static final int MAX_N = 100000;`

### 예시 코드
```java
HashMap<String, Integer> map = new HashMap<>();   // ⭕ 반복문 밖 → 계속 누적
for (int i = 0; i < n; i++) {
    // HashMap<String, Integer> map = new HashMap<>();  ❌ 매 바퀴 새 빈 맵
    String s = sc.next();
    map.put(s, map.getOrDefault(s, 0) + 1);
}
// System.out.println(i);   ❌ i는 이미 사라짐 → 컴파일 오류
```

### 주의할 점
- ⚠️ 누적해야 하는 것(맵, 합계, 카운트)은 **반복문 밖에서** 만든다.

### 🧩 확인 문제
**Q. 명령 N개를 처리하며 HashMap에 계속 저장해야 해요. `new HashMap<>()`은 어디에 써야 할까요?**

<details><summary>해설</summary>

**for문보다 위(밖)**예요. 안에서 만들면 매 바퀴 초기화돼서 이전에 저장한 값이 사라져요.

</details>

---

## ✅ 한눈에 복습
- [ ] 변수는 선언된 `{ }` 안에서만 산다 (for의 i는 반복문 뒤에 없음)
- [ ] 누적할 HashMap·합계는 반복문 밖에서 생성
