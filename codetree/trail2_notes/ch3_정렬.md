# Ch3. 정렬 — 개념 정리 노트

> 공부하면서 몰랐던 개념을 모아 두는 복습용 노트입니다.
> 각 개념은 **핵심 요약 → 예시 코드 → 주의할 점** 순서로 정리합니다.

---

## 📌 목차

1. [원본이 바뀌는가 — `sort()` vs `sorted()`](#1-원본이-바뀌는가--sort-vs-sorted)
2. [리스트가 아닌 것들 — 튜플·문자열·딕셔너리](#2-리스트가-아닌-것들--튜플문자열딕셔너리)
3. [내림차순 — `reverse=True` vs `reversed()`](#3-내림차순--reversetrue-vs-reversed)
4. [기준이 두 개일 때 — `key=lambda s: (-s[1], s[0])`](#4-기준이-두-개일-때--keylambda-s--s1-s0)
5. [`reversed()` 만의 용도 — 정렬 없이 뒤집기](#5-reversed-만의-용도--정렬-없이-뒤집기)
6. [파이썬의 일관된 규칙 — 메서드는 바꾸고, 함수는 준다](#6-파이썬의-일관된-규칙--메서드는-바꾸고-함수는-준다)
7. [클래스 — 흩어진 변수를 하나로 묶기](#7-클래스--흩어진-변수를-하나로-묶기)
8. [tuple — 가벼운 묶음과 언패킹](#8-tuple--가벼운-묶음과-언패킹)
9. [만든 뒤에 값 바꾸기 — 클래스는 되고, 튜플은 안 된다](#9-만든-뒤에-값-바꾸기--클래스는-되고-튜플은-안-된다)
10. [객체를 원소로 하는 리스트 — 학생 여러 명 담기](#10-객체를-원소로-하는-리스트--학생-여러-명-담기)
11. [객체 정렬 — 따로 두면 따로 논다](#11-객체-정렬--따로-두면-따로-논다)
12. [정렬 기준 만들기 — 우선순위 여러 개, 계산식, comparator](#12-정렬-기준-만들기--우선순위-여러-개-계산식-comparator)
13. [번호표 붙이기 — 정렬해도 "누구였는지" 알려면](#13-번호표-붙이기--정렬해도-누구였는지-알려면)

---

## 1. 원본이 바뀌는가 — `sort()` vs `sorted()`

### 핵심 요약

- ⭐⭐ **차이는 하나뿐이다 — 원본을 바꾸느냐, 새것을 돌려주느냐.**

  ```python
  a = [3, 1, 2]

  b = sorted(a)
  print(a, b)      # [3, 1, 2] [1, 2, 3]    ⭐ 원본 그대로, 새 리스트를 받는다

  r = a.sort()
  print(a, r)      # [1, 2, 3] None         ⭐ 원본이 바뀌고, 돌려주는 건 None
  ```

- ⚠️⚠️⭐⭐ **가장 흔한 실수는 `a = a.sort()`** 다. `a` 가 **`None`** 이 돼 버린다.

  ```python
  a = [3, 1, 2]
  a = a.sort()         # ⚠️
  print(a)             # None
  print(a[0])          # ⚠️ TypeError: 'NoneType' object is not subscriptable
  ```

  → ch1 의 [`return print(cnt)`](ch1_함수.md#3-return-printcnt-는-틀렸다--반환과-출력은-다른-일) 와 **같은 함정**이다.
  **"일만 하고 돌려주지 않는 것"에 `=` 를 쓰면 `None` 이 들어온다.**

- ⭐ **고르는 기준**

  | 상황 | 쓸 것 |
  | --- | --- |
  | 원본을 그대로 두고 싶다 | **`sorted(a)`** |
  | 원본 순서가 더 이상 필요 없다 | **`a.sort()`** |
  | 리스트가 아니다 (튜플·문자열·딕셔너리) | **`sorted()` 뿐** |
  | 헷갈린다 | ⭐ **`sorted()`** — 원본을 안 건드려서 안전하다 |

### 주의할 점

- ⚠️⭐⭐ **`a.sort()` 는 `None` 을 돌려준다.** `print(a.sort())`, `for x in a.sort():`, `sum(a.sort())` 전부 틀린다.
- ⭐ `a.sort()` 는 **새 리스트를 안 만들어서 메모리를 덜 쓴다.** 코테에서 의미가 생기는 건 원소가 수십만 개일 때다.
- ⭐ 둘 다 **옵션은 똑같다** — `key`, `reverse` 를 그대로 쓸 수 있다.

---

## 2. 리스트가 아닌 것들 — 튜플·문자열·딕셔너리

### 핵심 요약

- ⭐⭐ **`sorted()` 의 결과는 무엇을 넣든 항상 리스트다.**

  ```python
  t = (3, 1, 2)
  sorted(t)            # [1, 2, 3]   ⭐ 튜플을 넣어도 리스트가 나온다
  t.sort()             # ⚠️ AttributeError: 'tuple' object has no attribute 'sort'
  ```

  **튜플은 못 바꾸는 타입**이라 `sort()` 자체가 없다. (ch1 "튜플은 수정 불가")

- ⭐ **문자열도 글자 리스트로 나온다.** 문자열로 되돌리려면 **`''.join()`**.

  ```python
  sorted('banana')             # ['a', 'a', 'a', 'b', 'n', 'n']
  ''.join(sorted('banana'))    # 'aaabnn'      ⭐
  ```

- ⭐⭐ **딕셔너리를 그냥 넣으면 "키"만 정렬된다.**

  ```python
  sorted({'b': 2, 'a': 1})     # ['a', 'b']    ⚠️ 값은 사라진다
  ```

  `for k in d` 가 키를 주는 것과 같은 이야기다 (ch5 7번 항목).

### 🤔 딕셔너리를 **값 기준**으로 정렬하려면?

**`.items()` 로 (키, 값) 쌍을 꺼내서, 값을 `key` 로 지정한다.**

```python
d = {'b': 2, 'a': 1}

sorted(d.items(), key=lambda x: x[1])     # [('a', 1), ('b', 2)]   ⭐ 튜플의 리스트
```

- ⭐ `x` 는 `('a', 1)` 같은 **쌍 하나**다. `x[0]` 이 키, `x[1]` 이 값.
- ⭐ 값이 큰 순으로 **상위 3개**만 뽑는 식이 코테에서 자주 나온다.

  ```python
  sorted(d.items(), key=lambda x: -x[1])[:3]
  ```

- ⭐ 결과를 다시 딕셔너리로 만들고 싶으면 **`dict(...)`** 로 감싼다.
  (파이썬 3.7+ 는 넣은 순서를 유지하므로 정렬된 순서가 보존된다.)

### 주의할 점

- ⚠️⭐ **`sorted()` 는 항상 리스트를 준다.** 문자열이 필요하면 `''.join()`, 튜플이 필요하면 `tuple()`.
- ⚠️ **`d.items()` 를 빠뜨리고 `sorted(d, key=...)` 로 쓰면** `key` 에 **키만** 들어온다. 값은 못 본다.
- ⚠️⭐⭐ **타입이 섞이면 정렬이 터진다.** `sorted([1, '2'])` → `TypeError`.
  입력을 받을 때 `map(int, ...)` 을 빼먹었는지 의심하자.
- ⚠️⭐⭐ **숫자를 문자열로 정렬하면 사전순이 된다.**

  ```python
  sorted(['10', '9', '100'])              # ['10', '100', '9']   ⚠️
  sorted(['10', '9', '100'], key=int)     # ['9', '10', '100']   ⭐
  ```

- ⭐ 대소문자가 섞인 문자열은 **대문자가 먼저** 온다 (`'Z'`(90) < `'a'`(97)).

  ```python
  sorted(['apple', 'Banana'])                  # ['Banana', 'apple']
  sorted(['apple', 'Banana'], key=str.lower)   # ['apple', 'Banana']   ⭐
  ```

---

## 3. 내림차순 — `reverse=True` vs `reversed()`

### 핵심 요약

- ⭐ **`reverse=True` 는 `sorted()` 의 옵션, `reversed()` 는 별개의 함수다.**

  ```python
  a = [3, 1, 2]

  sorted(a, reverse=True)      # [3, 2, 1]                      ⭐ 리스트
  reversed(sorted(a))          # <list_reverseiterator ...>     ⚠️ 이터레이터
  list(reversed(sorted(a)))    # [3, 2, 1]                      ⭐ list() 로 감싸야 한다
  ```

- ⚠️⚠️⭐⭐ **숫자만 있으면 결과가 같지만, 동점이 있으면 달라진다.**

  ```python
  scores = [('민수', 90), ('지영', 80), ('철수', 90)]

  sorted(scores, key=lambda s: s[1], reverse=True)
  # [('민수', 90), ('철수', 90), ('지영', 80)]    ⭐ 동점은 원래 순서 유지

  list(reversed(sorted(scores, key=lambda s: s[1])))
  # [('철수', 90), ('민수', 90), ('지영', 80)]    ⚠️ 동점 순서까지 뒤집힌다
  ```

- ⭐⭐ **이유: 파이썬 정렬은 "안정 정렬(stable sort)" 이다.**
  **같은 값끼리는 원래 순서를 그대로 둔다.**

  ```
  reverse=True   정렬할 때부터 큰 것부터 놓는다   → 동점은 원래 순서 ⭐
  reversed(...)  다 정렬한 결과를 통째로 뒤집는다  → 동점도 같이 뒤집힌다 ⚠️
  ```

  **"내림차순"을 원했지 "결과를 뒤집기"를 원한 게 아니다.** 둘은 다른 일이다.

### 주의할 점

- ⚠️⭐⭐ **내림차순은 `reverse=True`.** `reversed()` 는 내림차순 도구가 아니다.
- ⚠️ `reversed()` 는 **이터레이터**라 `print` 하면 내용이 안 보이고, **한 번 쓰면 비워진다.**
  (ch1 의 `map` 과 같은 성질 — **두 번 쓸 거면 `list()` 로 받아 둔다.**)
- ⭐ **안정 정렬은 버그가 아니라 쓸모 있는 보장**이다. 4번 항목에서 이걸 적극적으로 써먹는다.

---

## 4. 기준이 두 개일 때 — `key=lambda s: (-s[1], s[0])`

### 🤔 "점수 내림차순, 동점이면 이름 오름차순"

**`reverse=True` 를 쓰면 이름까지 내림차순이 된다.** 방향이 서로 다르기 때문이다.

### 핵심 요약

- ⭐⭐⭐ **숫자는 음수로 뒤집는다. 그러면 `reverse` 없이 방향을 섞을 수 있다.**

  ```python
  scores = [('민수', 90), ('지영', 80), ('철수', 90)]

  sorted(scores, key=lambda s: (-s[1], s[0]))
  # [('민수', 90), ('철수', 90), ('지영', 80)]
  ```

  - `-90 < -80` 이므로 **큰 점수가 앞**으로 온다 → 점수 **내림차순**
  - 이름은 그대로 → **오름차순**
  - ⭐ **코테에서 정말 자주 쓰는 패턴이다.**

- ⭐⭐ **`key` 가 튜플을 돌려주면 "앞에서부터" 비교한다.** 앞이 같을 때만 뒤를 본다.

  ```
  (-90, '민수')  vs  (-90, '철수')     첫 칸이 같다 → 둘째 칸 비교 → 민수 < 철수
  (-90, ...)    vs  (-80, ...)        첫 칸에서 결판 → 둘째 칸은 안 본다
  ```

  → 기준이 셋이면 **`(-점수, 이름, 나이)`** 처럼 계속 붙이면 된다.

### 음수로 못 뒤집을 때 — 두 번 정렬한다 ⭐⭐

**기준 둘 다 문자열이고 방향이 다르면** 음수 트릭을 못 쓴다. 이때는 **안정 정렬을 이용해 두 번** 돌린다.

```python
people = [('kim', 'B'), ('ahn', 'A'), ('lee', 'B'), ('cho', 'A')]

step1 = sorted(people, key=lambda p: p[0])                 # ⭐ 덜 중요한 기준 먼저 (이름 오름차순)
step2 = sorted(step1, key=lambda p: p[1], reverse=True)    # ⭐ 중요한 기준 나중 (등급 내림차순)

# [('kim', 'B'), ('lee', 'B'), ('ahn', 'A'), ('cho', 'A')]
```

- ⭐⭐ **순서가 거꾸로다 — 덜 중요한 기준을 먼저, 중요한 기준을 나중에.**
  나중 정렬이 동점을 건드리지 않으므로(안정 정렬) 먼저 맞춰 둔 순서가 살아남는다.

### 주의할 점

- ⚠️⭐⭐ **`reverse=True` 는 모든 기준에 한꺼번에 걸린다.** 기준마다 방향을 다르게 할 수 없다.
- ⚠️⭐ **음수 뒤집기는 숫자에만 된다.** `-'abc'` 는 `TypeError`.
- ⭐ `key` 로 쓸 함수를 그냥 넘겨도 된다 — **`key=len`**, **`key=int`**, **`key=str.lower`** (괄호 없이).
- ⭐ `key` 는 **원소마다 딱 한 번** 계산되어 비교에 쓰인다. 무거운 계산을 넣어도 `n log n` 번이 아니라 `n` 번이다.
- ⭐ 람다가 길어지면 **`def` 로 빼는 게** 읽기 좋다.

  ```python
  def by_score(s):
      return (-s[1], s[0])

  sorted(scores, key=by_score)
  ```

---

## 5. `reversed()` 만의 용도 — 정렬 없이 뒤집기

### 핵심 요약

- ⭐ **`reversed()` 의 본업은 정렬이 아니라 "그냥 역순"이다.**

  ```python
  a = [3, 1, 2]

  list(reversed(a))   # [2, 1, 3]   ⭐ 정렬이 아니다. 그냥 뒤집은 것
  a[::-1]             # [2, 1, 3]   ⭐ 같은 결과, 새 리스트
  a.reverse()         # a 가 [2, 1, 3] 으로 바뀐다 (제자리)
  ```

- ⭐⭐ **뒤에서부터 순회할 때 가장 쓸모 있다.** 복사본을 안 만든다.

  ```python
  for x in reversed(a):      # ⭐ 새 리스트를 만들지 않는다
      print(x)

  for x in a[::-1]:          # 같은 결과지만 리스트를 하나 더 만든다
      print(x)
  ```

- ⭐ 인덱스가 필요하면 **`range` 를 거꾸로** 돌리는 쪽이 낫다.

  ```python
  for i in range(len(a) - 1, -1, -1):     # 마지막 번호부터 0 까지
      print(i, a[i])
  ```

### 세 가지 고르는 기준

| 하고 싶은 것 | 쓸 것 |
| --- | --- |
| 뒤에서부터 **순회만** | **`for x in reversed(a)`** ⭐ |
| 뒤집은 **새 리스트**가 필요 | **`a[::-1]`** ⭐ |
| **원본을** 뒤집어 버리기 | **`a.reverse()`** |

### 주의할 점

- ⚠️ **`a.reverse()` 도 `None` 을 돌려준다.** `a = a.reverse()` 는 1번과 똑같은 사고다.
- ⚠️ `reversed(a)` 는 **원본을 보고 있다.** 도는 중에 `a` 를 바꾸면 결과가 꼬인다.
- ⭐ **`a[::-1]` 은 문자열에도 된다** — `'abc'[::-1]` → `'cba'`. (`reversed('abc')` 는 이터레이터)

---

## 6. 파이썬의 일관된 규칙 — 메서드는 바꾸고, 함수는 준다

### 🤔 `sort()`/`sorted()` 와 똑같은 짝이 여기에도 보이는데?

**`a.reverse()` 와 `reversed(a)` 다.** 우연이 아니라 **파이썬의 일관된 규칙**이다.

### 핵심 요약

- ⭐⭐⭐ **메서드(`a.___()`)는 원본을 바꾸고 `None` 을 돌려준다.**
  **내장 함수(`___(a)`)는 원본을 두고 새 결과를 돌려준다.**

  | 하는 일 | 메서드 (제자리, `None`) | 내장 함수 (새 결과) |
  | --- | --- | --- |
  | 정렬 | `a.sort()` | `sorted(a)` |
  | 뒤집기 | `a.reverse()` | `reversed(a)` |

- ⭐⭐ **이 규칙을 알면 "방법이 왜 여러 개인지"가 납득된다.** 외울 게 두 개가 아니라 **규칙 하나**다.

  ```
  a.무엇()   →  a 가 바뀐다.   받아 봐야 None   ⚠️ = 를 쓰지 않는다
  무엇(a)    →  a 는 그대로.   결과를 받는다    ⭐ = 를 쓴다
  ```

- ⭐ 같은 규칙이 다른 데서도 보인다.

  ```python
  a.append(1)     # 원본이 바뀐다, None
  a.pop()         # ⚠️ 예외 — 꺼낸 값을 돌려준다 (바꾸면서 주기도 한다)
  ```

  → ⚠️ **절대 법칙은 아니다.** 하지만 **"`=` 를 썼는데 `None` 이 나오면 메서드를 의심"** 하는 감각이 생긴다.

### 주의할 점

- ⚠️⭐⭐ **`= ` 를 썼는데 `None` 이 나오면 90% 는 제자리 메서드다.** `sort`, `reverse`, `append`, `extend`, `clear`.
- ⭐ 자기 검증: **`print(a.메서드())` 를 찍어 봐서 `None` 이면 `=` 로 받으면 안 되는 것**이다.
- ⭐ 파이썬 정렬은 **Timsort**, 시간복잡도 **O(n log n)**, 그리고 **안정 정렬**이다.
  코테에서 직접 정렬 알고리즘을 구현할 일은 거의 없다. **`sorted` 를 믿고 `key` 를 잘 쓰는 게 실력**이다.

---

## 7. 클래스 — 흩어진 변수를 하나로 묶기

### 🤔 학생 두 명의 (국어, 영어, 수학) 점수를 어떻게 담지?

가장 먼저 떠오르는 건 **변수를 늘리는 것**이다.

```python
kor1, eng1, math1 = 90, 80, 90
kor2, eng2, math2 = 80, 70, 60
```

학생이 3명이면 변수 9개, 30명이면 90개다. **감당이 안 된다.**
게다가 "이 3개가 한 사람 것"이라는 사실이 **이름 뒤의 숫자에만** 적혀 있다. 코드는 그걸 모른다.

### 핵심 요약

- ⭐⭐⭐ **"한 덩어리로 다뤄야 하는 값들"이 보이면 클래스로 묶는다.**

  ```python
  class Student:
      def __init__(self, kor, eng, math):
          self.kor = kor
          self.eng = eng
          self.math = math

  student1 = Student(90, 80, 90)

  print(student1.kor)     # 90
  print(student1.eng)     # 80
  print(student1.math)    # 90
  ```

  변수 3개가 **객체 1개**가 됐다. 학생이 30명이어도 **리스트 하나**면 된다.

- ⭐⭐ **`__init__` 은 생성자(constructor)** — "이 클래스는 어떤 값을 갖는가"를 정하는 곳이다.
  **`Student(90, 80, 90)` 라고 쓰는 순간 자동으로 호출된다.** 직접 부르는 게 아니다.

- ⭐⭐⭐ **`self` 는 항상 첫 번째 인자**이고, **"지금 만들어지고 있는 객체 자신"** 이다.

  ```
  student1 = Student(90, 80, 90)
                        │   │   │
                        ▼   ▼   ▼
      def __init__(self, kor, eng, math):
                    ▲
                    └── 만들어지는 중인 빈 객체 (파이썬이 알아서 넣어 준다)

          self.kor = kor        ← 그 객체 안에 값을 적어 둔다
  ```

  넘긴 값은 3개인데 인자가 4개인 이유가 이것이다.

- ⭐ **`self.` 를 붙인 변수를 멤버 변수**, 만들어진 **`student1` 을 객체(instance)** 라고 부른다.

- ⭐ **멤버 변수 이름은 인자 이름과 달라도 된다.**

  ```python
  class Student:
      def __init__(self, kor, eng, math):
          self.k = kor
          self.e = eng
          self.m = math

  student1 = Student(90, 80, 90)
  print(student1.k)      # 90
  ```

  바깥에서 쓰는 이름은 **`self.` 뒤에 붙인 쪽**이다. 이제 `student1.kor` 는 에러다.

### 왜 "정렬" 챕터에서 클래스가 나오나 ⭐⭐

**다음 lesson 이 "객체 정렬"이기 때문이다.** 점수를 따로 놓으면 정렬할 때 같이 움직이지 못하지만, **묶어 두면 통째로 움직인다.**

```python
students = [Student(90, 80, 90), Student(80, 70, 60)]

sorted(students, key=lambda s: s.kor)              # ⭐ 국어 점수 오름차순
sorted(students, key=lambda s: (-s.kor, s.eng))    # ⭐ 4번의 패턴 그대로
```

→ **4번에서 `s[1]` 이던 자리가 `s.kor` 로 바뀐 것뿐**이다. 정렬 문법은 하나도 새로 배울 게 없다.

### 주의할 점

- ⚠️⭐⭐ **`self` 를 빠뜨리면 즉시 터진다.**

  ```python
  def __init__(kor, eng, math):     # ⚠️
  # TypeError: Student.__init__() takes 3 positional arguments but 4 were given
  ```

  **"4개를 줬다"는 에러 메시지의 4번째가 바로 `self`** 다.

- ⚠️⚠️⭐⭐ **`self.` 를 빠뜨리면 조용히 사라진다.**

  ```python
  def __init__(self, kor, eng, math):
      kor = kor             # ⚠️ 그냥 지역 변수. 함수가 끝나면 없어진다

  print(student1.kor)       # ⚠️ AttributeError: 'Student' object has no attribute 'kor'
  ```

  **만들 때가 아니라 쓸 때** 에러가 나서 더 찾기 어렵다.

- ⚠️ **`__init__` 에서 값을 `return` 하면 안 된다.** 객체를 돌려주는 건 파이썬이 한다.
  (`return self` 라고 써도 `TypeError: __init__() should return None, not 'Student'`)

- ⚠️⭐⭐ **객체끼리는 그냥 비교가 안 된다.**

  ```python
  sorted(students)     # ⚠️ TypeError: '<' not supported between instances of 'Student' and 'Student'
  ```

  **`key=` 를 반드시 줘야 한다.** 리스트·튜플과 다른 점이다.

- ⚠️ `print(student1)` 은 `<__main__.Student object at 0x104...>` 를 찍는다.
  디버깅할 땐 **멤버를 직접** 찍는다 — `print(student1.kor, student1.eng)`.

- ⚠️ 언더스코어는 **두 개**다. `_init_` 로 쓰면 생성자로 인식되지 않아
  `TypeError: Student() takes no arguments` 라는 **엉뚱한 에러**가 난다.

---

## 8. tuple — 가벼운 묶음과 언패킹

### 🤔 값 두세 개 묶자고 매번 클래스를 만들어야 하나?

**아니다.** 간단한 경우엔 **튜플**이면 충분하다. 사실 **이미 쓰고 있었다.**

### 핵심 요약

- ⭐⭐ **함수가 값을 2개 이상 반환하면, 그건 이미 튜플이다.**

  ```python
  def hello():
      return 1, 2

  print(hello())      # (1, 2)   ⭐ 괄호를 안 썼는데 괄호가 붙어 나온다
  ```

  **튜플을 만드는 건 괄호가 아니라 `,` 다.** 괄호는 읽기 좋으라고 있는 것뿐이다.

- ⭐⭐ **튜플은 리스트와 거의 같지만 "못 바꾼다"(immutable).**

  | | 리스트 | 튜플 |
  | --- | --- | --- |
  | 값 수정 `t[0] = 5` | ⭐ 된다 | ⚠️ TypeError |
  | `append` / `remove` | ⭐ 된다 | ⚠️ 없다 |
  | `.sort()` | ⭐ 있다 | ⚠️ 없다 → `sorted()` 뿐 (2번 항목) |

- ⭐⭐⭐ **튜플의 진짜 쓸모는 언패킹(Tuple Unpacking)이다.**

  ```python
  a, b = hello()
  print(a, b, a + b)      # 1 2 3
  ```

  **"함수는 값을 하나만 반환한다"는 제약을 푸는 게 바로 이것**이다.
  값 여러 개를 튜플 하나로 묶어 보내고, 받는 쪽에서 풀어 쓴다.
  (ch1 의 [언패킹](ch1_함수.md#1-tuplemapint-inputsplit-의-tuple--없어도-된다) 과 완전히 같은 이야기)

- ⭐ **반대 방향은 패킹**이다. 괄호 없이 `,` 로 나열하면 튜플이 된다.

  ```python
  dt = [1, 2, 3, 4, 5]      # 리스트
  dt = 1, 2, 3, 4, 5        # ⭐ 튜플 (패킹)
  ```

  ```
  묶기(패킹)    dt = 1, 2, 3        →  (1, 2, 3)
  풀기(언패킹)  a, b, c = dt        →  1  2  3
  ```

### 클래스 대신 튜플로 묶기 ⭐

```python
student1 = (90, 89, 90)
print(student1[0], student1[1], student1[2])      # 90 89 90
```

- ⚠️⭐⭐ **문제는 `student1[0]` 만 봐서는 그게 국어인지 알 수 없다는 것**이다. 인덱스는 의미를 안 알려 준다.
- ⭐⭐ **그래서 값을 쓸 때는 언패킹으로 이름을 붙여 두는 게 권장된다.**

  ```python
  kor, eng, math = student1
  print(kor, eng, math)      # 90 89 90
  ```

  꺼내 쓰는 줄이 **`student1[2] * 0.3` 이 아니라 `math * 0.3`** 이 된다. 실수가 줄어든다.

### 셋 중 무엇을 쓰나

| 상황 | 쓸 것 |
| --- | --- |
| 값 2~3개를 잠깐 묶어서 넘긴다 | **튜플** ⭐ |
| 나중에 값을 바꾸거나 `append` 한다 | **리스트** |
| 묶음에 **이름**이 필요하고 항목이 많다 | **클래스** ⭐ |

### 주의할 점

- ⚠️⚠️⭐⭐ **원소가 1개인 튜플은 `,` 를 꼭 붙인다.**

  ```python
  t = (1)       # ⚠️ 그냥 정수 1 이다
  t = (1,)      # ⭐ 튜플
  ```

  반대로 **`return cnt,` 처럼 `,` 를 실수로 남기면** 값 하나가 아니라 `(cnt,)` 가 간다.
  받는 쪽에서 `+ 1` 하다가 **엉뚱한 TypeError** 를 본다.

- ⚠️⭐ **언패킹은 개수가 딱 맞아야 한다.**
  `a, b = (1, 2, 3)` → `ValueError: too many values to unpack` (ch1 [2번](ch1_함수.md#2-인자가-2개-이상일-때--기본값-c0-과-args))

- ⭐⭐ **튜플은 정렬 기준으로 그대로 쓸 수 있다** — 앞에서부터 비교한다(4번 항목).
  `key=lambda s: (-s[1], s[0])` 가 동작하는 게 바로 이 성질이다.

- ⭐⭐ **튜플은 딕셔너리의 키·집합의 원소가 될 수 있다. 리스트는 안 된다.**

  ```python
  visited = {(0, 0): True}      # ⭐ 된다 — 격자 좌표를 키로 쓸 때 자주 나온다
  visited = {[0, 0]: True}      # ⚠️ TypeError: unhashable type: 'list'
  ```

  **"못 바꾸니까 키로 쓸 수 있다"** — 튜플이 따로 있는 또 하나의 이유다.

- ⚠️ **"못 바꾼다"는 건 튜플 자신**이다. 튜플 안에 리스트가 들어 있으면 **그 리스트는 바뀐다.**

  ```python
  t = ([1, 2], 3)
  t[0].append(9)      # ⭐ 된다 → ([1, 2, 9], 3)
  t[0] = [5]          # ⚠️ TypeError
  ```

---

## 9. 만든 뒤에 값 바꾸기 — 클래스는 되고, 튜플은 안 된다

### 🤔 `Student()` 처럼 값 없이 만들 순 없나?

**없다. 그냥 터진다.**

```python
class Student:
    def __init__(self, kor, eng, math):
        self.kor = kor
        self.eng = eng
        self.math = math

student = Student()
# ⚠️ TypeError: Student.__init__() missing 3 required positional arguments: 'kor', 'eng', and 'math'
```

**`__init__` 도 결국 함수**라서, 인자를 정해 놨으면 **그만큼 줘야 한다.**

### 핵심 요약 — 클래스: 기본값과 대입

- ⭐⭐ **기본값을 주면 "안 넘겨도 되는 인자"가 된다.** (ch1 [2번](ch1_함수.md#2-인자가-2개-이상일-때--기본값-c0-과-args) 의 `c=0` 과 같은 문법)

  ```python
  class Student:
      def __init__(self, kor=0, eng=0, math=0):
          self.kor = kor
          self.eng = eng
          self.math = math

  student1 = Student(90, 80, 90)    # ⭐ 넘긴 값 사용
  student2 = Student()              # ⭐ 기본값 0 으로 생성
  student3 = Student(90)            # ⭐ 앞에서부터 채운다 → 90, 0, 0
  ```

- ⭐⭐⭐ **이미 만든 객체의 값은 그냥 대입하면 바뀐다.**

  ```python
  student2 = Student()
  print(student2.kor)      # 0

  student2.kor = 90        # ⭐ 객체.멤버변수 = 값
  student2.eng = 80
  student2.math = 90

  print(student2.kor)      # 90
  ```

  **읽을 때 쓰던 `student2.kor` 를 `=` 왼쪽에 놓으면 쓰기**가 된다. 그게 전부다.

### 🤔 튜플도 똑같이 바꾸면 되나?

**안 된다. 튜플은 immutable 이다** (8번 항목).

```python
student1 = (0, 0, 0)
student1[2] = 90        # ⚠️ TypeError: 'tuple' object does not support item assignment
```

### 핵심 요약 — 튜플: 바꾸려면 새로 만든다

- ⭐⭐⭐ **"풀고 → 바꿔서 → 다시 묶는다."** 튜플의 값 변경은 항상 이 3단계다.

  ```python
  student1 = (0, 0, 0)

  kor, eng, math = student1        # ① 언패킹해서 풀고
  student1 = (kor, eng, 90)        # ② 바꿀 자리만 갈아 끼워 새 튜플을 만든다

  print(kor, eng, math)            # 0 0 0
  print(student1)                  # (0, 0, 90)
  ```

  ```
  클래스   student2.math = 90      →  그 객체를 고친다        (같은 객체)
  튜플     student1 = (kor, eng, 90) →  새 튜플로 갈아 끼운다  ⚠️ 다른 객체
  ```

- ⭐ 바꾼 뒤 변수로도 쓰려면 **다시 언패킹**해 준다.

  ```python
  student1 = (kor, eng, 90)
  kor, eng, math = student1
  print(kor, eng, math)            # 0 0 90
  ```

### Side Note — 필요 없는 값은 `_` 로 받는다 ⭐

**수학 점수만 필요한데 셋 다 이름을 지어야 하나?** 안 써도 된다.

```python
student1 = (90, 80, 90)

_, _, math = student1      # ⭐ 앞의 둘은 안 쓰겠다는 표시
print(math)                # 90
```

- ⭐ 개수는 **여전히 딱 맞아야 한다.** `_` 는 자리를 비우는 게 아니라 **"이름을 안 붙이겠다"** 는 관습이다.
- ⭐ 뒤쪽을 통째로 버리려면 **`*_`** 를 쓴다. (ch1 의 `*rest` 와 같은 문법)

  ```python
  kor, *_ = student1         # kor = 90, 나머지는 _ 에 리스트로 들어간다
  ```

### 주의할 점

- ⚠️⚠️⭐⭐⭐ **기본값으로 리스트를 쓰면 안 된다.** 객체마다 생기는 게 아니라 **전부가 같은 리스트 하나를 공유**한다.

  ```python
  class Student:
      def __init__(self, scores=[]):     # ⚠️ 함정
          self.scores = scores

  a, b = Student(), Student()
  a.scores.append(90)
  print(b.scores)                        # ⚠️ [90]   건드린 적도 없는데 들어 있다

  # ⭐ 바른 방법
  def __init__(self, scores=None):
      self.scores = [] if scores is None else scores
  ```

  **기본값은 함수를 정의할 때 딱 한 번 만들어진다.** 숫자·문자열은 못 바꾸니 안전하지만, **리스트·딕셔너리는 위험**하다.

- ⚠️⭐ **기본값은 뒤쪽부터만 줄 수 있다.**

  ```python
  def __init__(self, kor=0, eng, math):
  # ⚠️ SyntaxError: parameter without a default follows parameter with a default
  ```

- ⚠️⭐ **오타로 없는 멤버에 대입해도 에러가 안 난다.** 새 멤버가 **조용히 생긴다.**

  ```python
  student2.mat = 90          # ⚠️ math 오타인데 통과한다
  print(student2.math)       # 0    ⚠️ 바뀐 줄 알았는데 그대로
  ```

  **값이 안 바뀌면 멤버 이름 철자부터 본다.**

- ⚠️⭐⭐ **튜플을 "바꾸면" 그건 다른 튜플이다.** 다른 변수나 리스트가 옛 튜플을 들고 있으면 **그쪽은 안 바뀐다.**

  ```python
  students = [(0, 0, 0)]
  s = students[0]
  s = (0, 0, 90)             # ⚠️ s 만 새 튜플을 가리킬 뿐
  print(students[0])         # (0, 0, 0)

  students[0] = (0, 0, 90)   # ⭐ 리스트 칸을 직접 갈아 끼워야 한다
  ```

  **클래스였다면 `s.math = 90` 한 줄로 리스트 안의 것까지 같이 바뀐다.**
  → **값을 자주 고쳐야 하면 튜플보다 클래스(또는 리스트)** 가 맞다.

---

## 10. 객체를 원소로 하는 리스트 — 학생 여러 명 담기

### 🤔 학생이 한 명이 아니라 n 명이면?

**객체를 리스트에 담으면 된다.** 새로 배울 문법이 없다 — **"리스트의 원소가 정수가 아니라 객체"** 일 뿐이다.

### 핵심 요약 — 직접 나열하기

```python
class Student:
    def __init__(self, kor, eng, math):
        self.kor = kor
        self.eng = eng
        self.math = math

students = [
    Student(90, 80, 90),      # 0번째 학생
    Student(80, 70, 60),      # 1번째 학생
    Student(50, 60, 70),      # 2번째 학생
]

print(students[2].kor)        # ⭐ 50
print(students[2].eng)        # 60
```

- ⭐⭐⭐ **`students[2].kor` 를 끊어 읽는다 — `students[2]` 로 학생을 고르고, `.kor` 로 그 학생의 점수를 꺼낸다.**

  ```
  students[2].kor
  └──┬───┘ └┬┘
   학생 하나  그 학생의 멤버
  ```

- ⚠️⭐⭐ **`students.kor` 는 에러다.** 리스트에는 `kor` 가 없다. 멤버를 가진 건 **리스트가 아니라 그 안의 객체**다.
  → `AttributeError: 'list' object has no attribute 'kor'`

### 핵심 요약 — n 명을 미리 만들어 두기

**기본값을 줘 두면 빈 학생을 찍어낼 수 있다** (9번 항목).

```python
class Student:
    def __init__(self, kor=0, eng=0, math=0):
        self.kor = kor
        self.eng = eng
        self.math = math

students = []
for _ in range(3):
    students.append(Student())      # ⭐ 0점짜리 학생 3명

print(students[2].kor)              # 0
```

- ⭐⭐ **반복 변수를 안 쓰니 `_`** 다 (9번 Side Note 와 같은 관습).

- ⭐⭐ **이 부분은 리스트 컴프리헨션으로 한 줄이 된다.**
  (ch7 [5번](../trail1_notes/ch7_1차원배열.md#5-리스트-컴프리헨션--식-for-x-in-반복할것-if-조건))

  ```python
  students = [Student() for _ in range(3)]
  ```

### ⚠️⚠️⚠️ `[Student()] * 3` 은 함정이다

```python
students = [Student()] * 3        # ⚠️
students[0].kor = 90
print(students[1].kor)            # ⚠️ 90    건드린 적 없는데 바뀌어 있다
```

- ⭐⭐⭐ **`*` 는 객체를 3개 만드는 게 아니라, 같은 객체 하나를 3칸에 꽂는다.**
  `Student()` 는 **딱 한 번만** 실행된다.
- **반드시 `[Student() for _ in range(3)]`** — 컴프리헨션은 **매번 새로 만든다.**
- ⭐ ch8 의 [`[[0] * m] * n` 금지](../trail1_notes/ch8_2차원배열.md) 와 **완전히 같은 함정**이다.
  9번의 **기본값 리스트 공유**와도 뿌리가 같다 — **"하나를 여러 곳이 같이 보고 있다."**

### 핵심 요약 — 입력받아 리스트 만들기 ⭐⭐⭐

**코테에서 실제로 쓰는 형태는 이것이다.**

```python
n = int(input())
students = []

for _ in range(n):
    kor, eng, math = map(int, input().split())
    students.append(Student(kor, eng, math))

print(students[1].kor, students[1].eng, students[1].math)
```

- ⭐ 한 줄로 줄이면 **`students.append(Student(*map(int, input().split())))`** 도 된다.
  (`*` 는 "묶음을 풀어 인자 자리에 하나씩" — ch1 2번)

### tuple 버전 — 더 짧다 ⭐

```python
students = [
    (90, 80, 90),      # 0번째 학생
    (80, 70, 60),      # 1번째 학생
    (50, 60, 70),      # 2번째 학생
]

kor, eng, math = students[2]      # ⭐ 꺼내면서 이름을 붙인다 (8번 항목)
print(kor, eng, math)             # 50 60 70
```

**입력받는 경우는 컴프리헨션 한 줄로 끝난다.**

```python
students = [tuple(map(int, input().split())) for _ in range(n)]
```

- ⭐⭐ 클래스 버전과 달리 **`class` 정의가 통째로 필요 없다.** 항목이 2~3개면 이쪽이 빠르다.
- ⚠️ 대신 꺼낼 때 **`students[1][0]` 이 뭔지 알 수 없다.** 그래서 **언패킹해서 이름을 붙여 쓴다.**

### 어느 쪽을 쓰나 ⭐⭐

| | 클래스 리스트 | 튜플 리스트 |
| --- | --- | --- |
| 만들기 | `[Student() for _ in range(n)]` | `[tuple(map(int, input().split())) for _ in range(n)]` ⭐ 짧다 |
| 꺼내기 | `students[i].kor` ⭐ 의미가 보인다 | `students[i][0]` ⚠️ / 언패킹 필요 |
| 값 바꾸기 | `students[i].kor = 90` ⭐ | `students[i] = (90, eng, math)` ⚠️ 칸을 갈아 끼워야 (9번) |
| 정렬 | `key=lambda s: s.kor` | `key=lambda s: s[0]` ⭐ **키 없이도** 앞에서부터 비교된다 |

→ ⭐ **값이 2~3개이고 읽기만 한다 → 튜플. 항목이 많거나 고쳐야 한다 → 클래스.**

### 그리고 이게 정렬로 이어진다 ⭐⭐⭐

```python
sorted(students, key=lambda s: -s.kor)            # 클래스: 국어 내림차순
sorted(students, key=lambda s: (-s[0], s[1]))     # 튜플: 4번 패턴 그대로
sorted(students)                                  # ⭐ 튜플이면 이것만으로도 된다
```

- ⭐⭐ **튜플 리스트는 `key` 없이도 정렬된다** — 앞 원소부터 비교하니까(4번·8번).
  **클래스는 `key` 가 반드시 필요**하다(7번).
- → **정렬 기준이 "맨 앞 항목부터 그대로"면 튜플이 압도적으로 편하다.**

### 주의할 점

- ⚠️⭐⭐ **`students.kor` ↔ `students[i].kor`** 를 섞지 않는다. 리스트에는 멤버가 없다.
- ⚠️⚠️⭐⭐⭐ **`[Student()] * n` 금지.** 항상 **`[Student() for _ in range(n)]`**.
- ⚠️⭐ **입력 줄 수와 `range(n)` 이 안 맞으면** `EOFError` 또는 조용한 오답이 난다. `n` 을 먼저 읽었는지 확인한다.
- ⭐ 객체 리스트는 **`for s in students:` 로 그대로 순회**할 수 있다. `s.kor` 로 바로 쓴다.

  ```python
  total = sum(s.kor for s in students)      # ⭐ 국어 총점
  best = max(students, key=lambda s: s.kor) # ⭐ 국어 1등 (객체가 나온다)
  ```

- ⚠️ `max(students)` 도 **클래스면 TypeError** 다. `key=` 를 줘야 한다(7번).

---

## 11. 객체 정렬 — 따로 두면 따로 논다

### 🤔 그런데 왜 굳이 객체로 묶어서 정렬하나?

**과목별로 리스트를 따로 만들어 보면 바로 알 수 있다.**

```python
kors  = [90, 20, 90, 60, 80]
engs  = [80, 80, 30, 10, 20]
maths = [90, 80, 60, 50, 10]

kors.sort()

print(kors)      # [20, 60, 80, 90, 90]    ⭐ 정렬됐다
print(engs)      # [80, 80, 30, 10, 20]    ⚠️ 그대로다
print(maths)     # [90, 80, 60, 50, 10]    ⚠️ 그대로다
```

- ⚠️⚠️⭐⭐⭐ **국어 점수만 움직이고 영어·수학은 제자리에 남는다.**
  이제 `kors[0]` 과 `engs[0]` 은 **다른 사람의 점수**다. 줄이 통째로 어긋났다.
- ⭐⭐⭐ **한 사람의 값들은 같이 움직여야 한다.** 그래서 **묶어 두고(7·8번), 묶음째로 정렬**한다.
  → **이게 객체 정렬을 쓰는 유일하고 충분한 이유다.**

### lambda 가 뭐였더라 ⭐⭐

**`lambda` 는 이름 없이 쓰는 함수(익명 함수)** 다. `def` 로 쓰면 이렇다.

```python
def f(x):
    return x * 2

print(f(3))      # 6
```

**똑같은 것을 한 줄로:**

```python
f = lambda x: x * 2
print(f(3))      # 6
```

```
lambda x : x * 2
       ▲    ▲
     인자  반환할 값 (return 을 안 쓴다)
```

- ⭐⭐⭐ **`key=lambda x: x.kor` 에서 `x` 는 "리스트의 원소 하나"** 다.
  정렬할 때 파이썬이 원소를 하나씩 `x` 에 넣어 부르고, **돌아온 값으로 비교**한다.
- ⭐⭐ **그래서 `x` 가 무엇이냐에 따라 뒤가 달라질 뿐이다.**

  ```
  원소가 객체면   x 는 Student      →  x.kor
  원소가 튜플이면 x 는 (90, 80, 90)  →  x[0]
  ```

  **차이는 이것뿐이다.**

### 핵심 요약 — class 객체 정렬

```python
students = [
    Student(90, 80, 90),
    Student(20, 80, 80),
    Student(90, 30, 60),
    Student(60, 10, 50),
    Student(80, 20, 10),
]

students.sort(key=lambda x: x.kor)       # ⭐ 국어 오름차순

for student in students:
    print(student.kor, student.eng, student.math)

# 20 80 80
# 60 10 50
# 80 20 10
# 90 80 90      ⭐ 90점 두 명은 원래 순서 그대로 (안정 정렬, 3번)
# 90 30 60
```

- ⭐⭐ **영어·수학 점수가 국어를 따라 같이 움직였다.** 위의 `kors.sort()` 와 비교해 보자.
- ⭐ `sort()` 든 `sorted()` 든 똑같다 — **원본을 바꿀 거냐만 다르다**(1번).

### 내림차순 — `-x.kor` ⭐⭐⭐

```python
students.sort(key=lambda x: -x.kor)      # ⭐ 국어 내림차순

# 90 80 90
# 90 30 60
# 80 20 10
# 60 10 50
# 20 80 80
```

- ⭐⭐ **`reverse=True` 와 결과가 같다.** 둘 다 **동점의 원래 순서를 지킨다**(안정 정렬).
- ⚠️⭐⭐ **`reversed()` 로 뒤집으면 90점 두 명의 순서까지 뒤집힌다**(3번). **쓰지 않는다.**
- ⭐⭐⭐ **`-x.kor` 를 더 많이 쓰는 이유는 기준이 둘 이상일 때 섞어 쓸 수 있기 때문**이다.

  ```python
  students.sort(key=lambda x: (-x.kor, x.eng))    # ⭐ 국어 내림차순, 동점이면 영어 오름차순
  ```

  **4번에서 `s[1]` 이던 자리가 `x.kor` 로 바뀐 것뿐이다.**

- ⭐⭐ 위 결과에서 **국어 90점이 두 명**이었다. **"누가 앞인지 모호하면 기준이 하나 더 필요하다"** 는 신호다.
  코테는 보통 **"동점이면 ○○ 순"** 을 문제에 적어 둔다. **빠뜨리면 틀린다.**

### 핵심 요약 — tuple 객체 정렬

**`x.kor` 가 `x[0]` 이 될 뿐이다.**

```python
students = [
    (90, 80, 90),
    (20, 80, 80),
    (90, 30, 60),
    (60, 10, 50),
    (80, 20, 10),
]

students.sort(key=lambda x: x[0])        # ⭐ 국어 오름차순
students.sort(key=lambda x: -x[0])       # ⭐ 국어 내림차순

for kor, eng, math in students:
    print(kor, eng, math)

# 90 80 90
# 90 30 60      ⭐ 동점은 여기서도 원래 순서 그대로
# 80 20 10
# 60 10 50
# 20 80 80
```

- ⭐⭐⭐ **순회하면서 바로 언패킹하면 훨씬 깔끔하다.**

  ```python
  for kor, eng, math in students:        # ⭐ for 와 언패킹을 동시에
      print(kor, eng, math)
  ```

  **`student[0]` 이 뭔지 세지 않아도 된다**(8번의 "이름을 붙여 쓰기"를 루프에서 하는 것).

- ⭐ **`key` 없이 `students.sort()` 만 해도 국어 오름차순**이 된다 — 튜플은 앞에서부터 비교하니까(10번).
  다만 **동점일 때 영어·수학까지 기준에 끌려 들어간다.** 의도한 게 아니면 `key` 를 명시한다.

### Side Note — 문자열 멤버로 정렬 ⭐

**방법이 완전히 같다. 문자열은 사전순으로 비교된다.**

```python
students = [
    ("lee",  80, 90),
    ("kim",  80, 80),
    ("park", 30, 60),
]

students.sort(key=lambda x: x[0])        # ⭐ 이름 사전순

for name, eng, math in students:
    print(name, eng, math)

# kim 80 80
# lee 80 90
# park 30 60
```

- ⚠️⭐⭐ **문자열에는 `-` 를 못 붙인다.** `-x[0]` → `TypeError: bad operand type for unary -: 'str'`
  **문자열 내림차순은 `reverse=True`**, 숫자와 방향을 섞어야 하면 **두 번 정렬**한다(4번).
- ⚠️ **대문자가 먼저 온다** (`'Z' < 'a'`) → 필요하면 `key=lambda x: x[0].lower()` (2번).

### 주의할 점

- ⚠️⚠️⭐⭐⭐ **값을 따로따로 리스트에 담아 두면 정렬이 어긋난다.** 묶어서 통째로 정렬한다.
- ⚠️⭐⭐ **`key=lambda x: x.kor()` 처럼 괄호를 붙이지 않는다.** `kor` 는 멤버 변수지 함수가 아니다.
  → `TypeError: 'int' object is not callable`
- ⚠️⭐⭐ **`students.sort(lambda x: x.kor)` 는 에러**다. **`key=` 를 반드시 붙인다.**
  → `TypeError: sort() takes no positional arguments`
- ⚠️ `students.sort(...)` 는 **`None` 을 돌려준다**(1·6번). `students = students.sort(...)` 금지.
- ⭐ 정렬 뒤 **1등만 필요하면 정렬할 필요가 없다** — `max(students, key=lambda x: x.kor)` 가 더 빠르다(`O(n)`).

---

## 12. 정렬 기준 만들기 — 우선순위 여러 개, 계산식, comparator

### 🤔 "국어 오름차순, 같으면 영어 오름차순"

11번에서 **동점이 생기면 기준이 하나 더 필요하다**고 했다. 그 "하나 더"를 쓰는 법이다.

### 왜 튜플을 돌려주면 되나 — 튜플 비교 연산 ⭐⭐⭐

**튜플끼리는 `>` `<` 로 직접 비교된다. 앞 원소부터 본다.**

```python
print((2, 3) > (1, 9))      # True    ⭐ 2 > 1 에서 끝. 뒤는 안 본다
print((2, 3) > (2, 8))      # False   ⭐ 앞이 같다 → 3 < 8 로 결판
print((2, 3) > (3, 1))      # False   ⭐ 2 < 3 에서 끝
```

- ⭐⭐⭐ **"앞이 같을 때만 뒤를 본다"가 곧 우선순위다.**
  그래서 **`key` 에 튜플을 돌려주고, 우선순위 순서대로 적어 두면 끝**이다. (4번과 같은 원리)
- ⭐ 원소가 2개든 5개든 똑같이 적용된다.

### 핵심 요약 — class 객체에 적용

```python
students = [
    Student(90, 80, 90),
    Student(20, 80, 80),
    Student(90, 30, 60),
    Student(60, 10, 50),
    Student(80, 20, 10),
]

# 1순위 국어 오름차순, 국어가 같으면 2순위 영어 오름차순
students.sort(key=lambda x: (x.kor, x.eng))

for student in students:
    print(student.kor, student.eng, student.math)

# 20 80 80
# 60 10 50
# 80 20 10
# 90 30 60      ⭐ 국어 90 동점 → 영어 30 이 앞
# 90 80 90
```

**영어만 내림차순으로 바꾸고 싶으면 그 자리에만 `-` 를 붙인다.**

```python
students.sort(key=lambda x: (x.kor, -x.eng))     # ⭐ 국어 오름, 영어 내림

# 20 80 80
# 60 10 50
# 80 20 10
# 90 80 90      ⭐ 영어 80 이 앞으로 왔다
# 90 30 60
```

- ⭐⭐⭐ **기준마다 방향을 따로 정할 수 있다는 게 `-` 의 전부**다.
  `reverse=True` 는 **전부 한꺼번에** 뒤집으니 이걸 못 한다(4번).

### tuple 객체도 똑같다

**`x.kor` 자리가 `x[0]` 이 될 뿐이다.**

```python
students.sort(key=lambda x: (x[0], -x[1]))       # ⭐ 국어 오름, 영어 내림

for kor, eng, math in students:
    print(kor, eng, math)

# 20 80 80
# 60 10 50
# 80 20 10
# 90 80 90
# 90 30 60
```

### 기준이 멤버가 아닐 때 — 계산식을 돌려준다 ⭐⭐⭐

**"세 과목 총점 순으로 정렬하라"** 처럼, **정렬 기준이 저장돼 있지 않은** 경우가 있다.
**`key` 는 값을 돌려주기만 하면 되므로, 그 자리에서 계산하면 된다.**

```python
students.sort(key=lambda x: x.kor + x.eng + x.math)      # ⭐ 총점 오름차순

for student in students:
    print(student.kor, student.eng, student.math)

# 80 20 10      합 110
# 60 10 50      합 120
# 20 80 80      합 180
# 90 30 60      합 180      ⭐ 합이 같으면 원래 순서 (안정 정렬)
# 90 80 90      합 260
```

```python
students.sort(key=lambda x: x[0] + x[1] + x[2])          # 튜플 버전
students.sort(key=lambda x: sum(x))                      # ⭐ 튜플이면 이렇게도 된다
```

- ⭐⭐⭐ **`key` 는 "비교에 쓸 값을 만들어 주는 함수"** 다. 멤버를 꺼내든, 계산하든, 상관없다.

  ```python
  key=lambda x: x.math - x.kor              # 차이
  key=lambda x: (x.kor + x.eng) / 2         # 평균
  key=lambda x: (-sum, x.kor)               # ⚠️ 계산 결과를 두 번 쓰려면 변수로 못 뺀다 → 아래 참고
  ```

- ⭐ **계산이 길어지면 `def` 로 뺀다.** 람다에 억지로 넣지 않는다(4번).

  ```python
  def total_then_kor(x):
      total = x.kor + x.eng + x.math
      return (-total, x.kor)                # ⭐ 총점 내림차순, 같으면 국어 오름차순

  students.sort(key=total_then_kor)
  ```

### Side Note — lambda 로 안 되면 `cmp_to_key` ⭐

**"총점이 3의 배수인 학생을 먼저, 그 다음은 총점 오름차순"** 처럼
**두 원소를 직접 비교해야만 정해지는 규칙**은 `key` 하나로 적기 어려울 때가 있다.
이럴 땐 **비교 함수(comparator)를 직접 쓰고 `cmp_to_key` 로 감싼다.**

```python
from functools import cmp_to_key

def total(x):
    return x[0] + x[1] + x[2]

def compare(a, b):
    a3, b3 = total(a) % 3 == 0, total(b) % 3 == 0
    if a3 != b3:
        return -1 if a3 else 1              # ⭐ 3의 배수인 쪽을 앞으로
    if total(a) != total(b):
        return -1 if total(a) < total(b) else 1
    return 0

students.sort(key=cmp_to_key(compare))
```

- ⭐⭐ **반환값의 뜻은 딱 세 가지다.**

  ```
  -1 (음수)  →  a 가 앞
   1 (양수)  →  b 가 앞
   0        →  순서 상관없음
  ```

- ⚠️⭐⭐ **파이썬3 에는 `sort(cmp=...)` 가 없다.** 반드시 **`key=cmp_to_key(함수)`** 로 넣는다.
- ⚠️⭐⭐ **그런데 코테에서 이게 필요한 경우는 거의 없다.** 위 예시도 사실 `key` 로 써진다.

  ```python
  students.sort(key=lambda x: (total(x) % 3 != 0, total(x)))     # ⭐ 같은 결과
  ```

  **`False(0) < True(1)` 이라 "조건을 만족하는 쪽이 앞"이 자동으로 된다.** 이 요령을 먼저 떠올리자.
- ⚠️ `cmp_to_key` 는 **원소마다 비교 객체를 만들어서 느리다.** `key` 로 되면 `key` 를 쓴다.

### 주의할 점

- ⚠️⭐⭐ **우선순위 순서대로 적는다.** `(x.eng, x.kor)` 와 `(x.kor, x.eng)` 는 완전히 다른 결과다.
- ⚠️⭐⭐ **튜플 괄호를 빠뜨리면 안 된다.** `key=lambda x: x.kor, x.eng` 는
  `,` 뒤가 **`sort` 의 또 다른 인자**로 읽혀 `SyntaxError: positional argument follows keyword argument` 가 난다.
  (변수에 담을 땐 **에러도 없이 "람다와 값으로 된 튜플"** 이 돼 버려 더 나쁘다.)
- ⚠️⭐⭐⭐ **`-` 는 숫자에만 된다.** 문자열이 섞여 방향이 다르면 **두 번 정렬**한다(4번).
- ⚠️⭐ **`key` 안에서 `bool` 은 숫자다** — `False=0`, `True=1`. 조건을 그대로 기준에 넣을 수 있다.

  ```python
  key=lambda x: (x.kor < 60, x.kor)        # ⭐ 60점 이상인 학생을 먼저
  ```

- ⭐ `key` 는 **원소마다 한 번만** 계산된다(4번). 총합을 매번 더해도 비용은 `O(n)` 이다.

---

## 13. 번호표 붙이기 — 정렬해도 "누구였는지" 알려면

### 🤔 정렬하고 나면 몇 번 학생이었는지 어떻게 아나?

**점수만 담아 두면 알 수 없다.** 정렬하는 순간 원래 자리가 사라진다.
**"1등의 번호를 출력하라"** 같은 문제가 바로 이걸 묻는다.

### 핵심 요약 — 튜플 뒤에 번호를 붙인다

```python
n = int(input())
students = [tuple(map(int, input().split())) + (i + 1,) for i in range(n)]
```

**입력이 이렇다면,**

```
2
80 90 100
50 60 70
```

**`students` 는 이렇게 된다.**

```python
[
    (80, 90, 100, 1),      # 1번 학생
    (50, 60, 70, 2),       # 2번 학생
]
```

- ⭐⭐ **`i` 는 `range(n)` 에서 오니 0부터다.** 문제는 보통 **1번부터** 세므로 **`i + 1`**.
- ⭐⭐⭐ **`(i + 1,)` 의 쉼표는 필수다.** `(i + 1)` 은 **그냥 괄호 친 숫자**다(8번).
  ```python
  (80, 90, 100) + (1,)     # ⭐ (80, 90, 100, 1)
  (80, 90, 100) + (1)      # ⚠️ TypeError: can only concatenate tuple (not "int") to tuple
  ```
- ⭐ **튜플끼리 `+` 는 이어붙이기**다. 원본을 바꾸는 게 아니라 **새 튜플을 만든다**(9번).
- ⭐ 전체를 리스트 컴프리헨션으로 감싸 **n 줄을 한 번에** 읽는다(10번).

### ⚠️⚠️⭐⭐⭐ 번호는 반드시 **뒤**에 붙인다

```python
students = [(i + 1,) + tuple(map(int, input().split())) for i in range(n)]   # ⚠️
```

**번호가 맨 앞에 오면 번호가 1순위 정렬 기준이 된다.** 정렬이 아무 의미가 없어진다.

```python
bad = [(1, 80, 90, 100), (2, 50, 60, 70), (3, 80, 70, 60)]
sorted(bad)      # ⚠️ [(1, ...), (2, ...), (3, ...)]   번호순 그대로다
```

- ⭐ **앞은 "정렬 기준", 뒤는 "딸려 다니는 꼬리표"** 로 생각한다.

### 왜 이렇게 하나 ⭐⭐⭐

**정렬한 뒤에도 꼬리표가 같이 움직이기 때문**이다.

```python
students = [(80, 90, 100, 1), (50, 60, 70, 2), (80, 70, 60, 3)]

students.sort(key=lambda x: -x[0])          # 국어 내림차순

# [(80, 90, 100, 1), (80, 70, 60, 3), (50, 60, 70, 2)]

print(students[0][3])                       # ⭐ 1 → 1등은 1번 학생
```

- ⭐⭐ **11번의 "따로 두면 따로 논다"를 번호에도 적용한 것**이다. 번호도 묶음 안에 넣어야 같이 움직인다.
- ⭐⭐⭐ **동점 처리에도 그대로 쓴다.** 보통 **"동점이면 번호가 작은 순"** 이 문제 조건이다.

  ```python
  students.sort(key=lambda x: (-x[0], x[3]))      # ⭐ 점수 내림, 동점이면 번호 오름
  ```

### 번호 대신 `enumerate` ⭐

**`enumerate` 로도 같은 일을 할 수 있다.** (ch7 [6번](../trail1_notes/ch7_1차원배열.md#6-배열에서-원소-찾기--enumerate-in--not-in))

```python
rows = [(80, 90, 100), (50, 60, 70), (80, 70, 60)]

sorted(enumerate(rows, 1), key=lambda x: -x[1][0])
# [(1, (80, 90, 100)), (3, (80, 70, 60)), (2, (50, 60, 70))]
```

- ⭐ **`enumerate(rows, 1)` 의 `1` 은 "번호를 1부터 세라"** 는 뜻이다. `i + 1` 을 안 써도 된다.
- ⚠️ 대신 **`(번호, (점수들))` 처럼 중첩**돼서 `x[1][0]` 같은 참조가 생긴다.
  → ⭐ **번호가 앞에 오므로 `key` 를 반드시 줘야 한다.** 안 주면 번호순이 된다(위 함정과 같은 이유).

### 클래스라면 멤버로 넣는다 ⭐

```python
class Student:
    def __init__(self, idx, kor, eng, math):
        self.idx = idx               # ⭐ 번호도 그냥 멤버 하나
        self.kor = kor
        self.eng = eng
        self.math = math

students = [Student(i + 1, *map(int, input().split())) for i in range(n)]

students.sort(key=lambda x: (-x.kor, x.idx))
print(students[0].idx)
```

- ⭐⭐ **클래스는 "앞/뒤" 고민이 없다.** 순서가 정렬에 영향을 주지 않으니 `idx` 를 맨 앞에 둬도 된다.
- ⭐ **항목이 많아지거나 번호·이름까지 붙기 시작하면 클래스가 편해지는 지점**이다(10번 표).

### 주의할 점

- ⚠️⚠️⭐⭐⭐ **`(i + 1,)` 의 쉼표를 빠뜨리면 `TypeError`** 다. 원소 1개 튜플은 항상 `,` 가 붙는다(8번).
- ⚠️⭐⭐ **번호를 앞에 붙이면 정렬이 망가진다.** 꼬리표는 **뒤**에.
- ⚠️⭐⭐ **문제가 0번부터 세는지 1번부터 세는지 확인한다.** `i` 와 `i + 1` 을 헷갈리면 **답이 전부 1씩 밀린다.**
- ⭐ 출력할 때 **점수는 빼고 번호만** 필요한 경우가 많다 — `print(students[0][3])`, 또는 `_, _, _, idx = students[0]` (9번).
- ⭐ **등수를 매기는 문제**면 정렬 후 `enumerate` 로 한 번 더 번호를 붙이면 된다.

  ```python
  for rank, s in enumerate(students, 1):
      print(rank, s[3])            # 등수, 학생 번호
  ```

---

## ✅ 한눈에 복습

- [ ] ⭐⭐ **`sorted(a)` 는 새 리스트, `a.sort()` 는 원본 변경 + `None` 반환.**
- [ ] ⚠️⚠️⭐⭐ **`a = a.sort()` 금지** — `a` 가 `None` 이 된다.
- [ ] ⭐ 헷갈리면 **`sorted()`** (원본을 안 건드려서 안전).
- [ ] ⭐⭐ **`sorted()` 의 결과는 무엇을 넣든 항상 리스트** — 문자열로 되돌리려면 **`''.join()`**.
- [ ] ⚠️ **튜플엔 `.sort()` 가 없다** (못 바꾸는 타입).
- [ ] ⚠️ **딕셔너리를 그냥 넣으면 "키"만** 나온다 → 값 기준은 **`sorted(d.items(), key=lambda x: x[1])`**.
- [ ] ⚠️⭐⭐ **숫자를 문자열로 정렬하면 사전순** — `['10','100','9']`. **`key=int`** 로 고친다.
- [ ] ⚠️ 타입이 섞이면 **`TypeError`** — `map(int, ...)` 를 빠뜨렸는지 의심.
- [ ] ⭐ 대문자가 먼저 온다 (`'Z' < 'a'`) → **`key=str.lower`**.
- [ ] ⚠️⚠️⭐⭐ **내림차순은 `reverse=True`.** `list(reversed(sorted(...)))` 는 **동점 순서까지 뒤집힌다**.
- [ ] ⭐⭐ 파이썬 정렬은 **안정 정렬** — 같은 값끼리는 **원래 순서를 유지**한다.
- [ ] ⚠️ `reversed()` 는 **이터레이터** — `list()` 로 감싸야 보이고, 한 번 쓰면 비워진다.
- [ ] ⭐⭐⭐ 방향이 섞이면 **`key=lambda s: (-s[1], s[0])`** — 숫자는 **음수로 뒤집는다**.
- [ ] ⭐⭐ `key` 가 **튜플이면 앞에서부터** 비교. 앞이 같을 때만 뒤를 본다.
- [ ] ⚠️ **`reverse=True` 는 모든 기준에 한꺼번에** 걸린다. 기준별로 방향을 못 나눈다.
- [ ] ⭐⭐ 둘 다 문자열이라 음수를 못 쓰면 **두 번 정렬** — **덜 중요한 기준 먼저, 중요한 기준 나중에**.
- [ ] ⭐ `key=len`, `key=int`, `key=str.lower` 처럼 **함수 이름만** 넘겨도 된다 (괄호 없이).
- [ ] ⭐ **`reversed()` 의 본업은 정렬이 아니라 역순 순회** — `for x in reversed(a)` 는 복사본을 안 만든다.
- [ ] ⭐ 뒤집은 새 리스트는 **`a[::-1]`**, 원본을 뒤집는 건 **`a.reverse()`** (이것도 `None`).
- [ ] ⭐⭐⭐ 규칙 하나로 외우기 — **메서드(`a.___()`)는 바꾸고 `None`, 내장 함수(`___(a)`)는 새 결과를 준다.**
- [ ] ⭐ **`=` 를 썼는데 `None` 이 나오면 제자리 메서드를 의심**한다.
- [ ] ⭐⭐⭐ 한 덩어리로 다룰 값이 보이면 **클래스로 묶는다** — 변수 9개 대신 객체 1개.
- [ ] ⭐⭐ **`__init__` 은 생성자** — `Student(...)` 라고 쓰는 순간 **자동 호출**된다.
- [ ] ⭐⭐⭐ **`self` 는 항상 첫 인자**이자 **만들어지는 객체 자신**. 파이썬이 알아서 넣어 준다.
- [ ] ⚠️⭐⭐ `self` 를 빼면 **`takes 3 positional arguments but 4 were given`**.
- [ ] ⚠️⚠️⭐⭐ **`self.` 를 빼면 지역 변수로 사라진다** → 나중에 `AttributeError`.
- [ ] ⭐ 멤버 변수 이름은 인자 이름과 **달라도 된다**. 바깥에서 쓰는 건 **`self.` 뒤 이름**.
- [ ] ⚠️⭐⭐ **객체는 그냥 정렬이 안 된다** — `sorted(students, key=lambda s: s.kor)` 처럼 **`key=` 필수**.
- [ ] ⭐⭐ 객체 정렬은 4번 패턴 그대로 — **`s[1]` 자리가 `s.kor` 로 바뀔 뿐**이다.
- [ ] ⭐⭐ **튜플을 만드는 건 괄호가 아니라 `,`** — `return 1, 2` 는 이미 튜플이다.
- [ ] ⭐⭐ **튜플은 못 바꾼다** — 수정·`append`·`.sort()` 전부 없다.
- [ ] ⭐⭐⭐ **함수가 값을 여러 개 돌려줄 수 있는 건 언패킹 덕분** — `a, b = hello()`.
- [ ] ⭐ 반대는 **패킹** — `dt = 1, 2, 3` 은 튜플.
- [ ] ⚠️⭐⭐ **튜플로 묶으면 `student1[0]` 이 뭔지 알 수 없다** → 쓸 때 **언패킹으로 이름을 붙인다**.
- [ ] ⚠️⚠️⭐⭐ **원소 1개 튜플은 `(1,)`** — `(1)` 은 그냥 정수. `return cnt,` 오타 조심.
- [ ] ⭐⭐ **튜플은 딕셔너리 키가 된다** (리스트는 `unhashable`) — 격자 좌표에 자주 쓴다.
- [ ] ⚠️ 튜플 안의 **리스트는 바뀐다** — 못 바꾸는 건 튜플 자신이다.
- [ ] ⭐ 고르기 — 잠깐 묶기 **튜플**, 바꿀 것 **리스트**, 이름이 필요하면 **클래스**.
- [ ] ⭐⭐ **`__init__` 도 함수다** — 인자를 안 주면 `missing 3 required positional arguments`.
- [ ] ⭐⭐ **기본값(`kor=0`)을 주면 `Student()` 로도 만들 수 있다.** 앞에서부터 채워진다.
- [ ] ⭐⭐⭐ **객체 값 변경은 그냥 대입** — `student2.math = 90`.
- [ ] ⚠️⭐ **없는 멤버에 대입해도 에러가 안 난다** — 오타면 새 멤버가 조용히 생긴다.
- [ ] ⚠️⚠️⭐⭐⭐ **기본값에 리스트 금지** — 모든 객체가 하나를 공유한다. `=None` 후 안에서 `[]`.
- [ ] ⚠️⭐ 기본값은 **뒤쪽 인자부터만** 줄 수 있다.
- [ ] ⭐⭐⭐ **튜플 값 변경은 "풀고 → 바꿔서 → 다시 묶기"** — `kor, eng, math = t` → `t = (kor, eng, 90)`.
- [ ] ⚠️⭐⭐ 튜플을 바꾸면 **다른 객체**다. 리스트 안의 튜플은 **칸을 직접 갈아 끼워야** 바뀐다.
- [ ] ⭐ 안 쓸 값은 **`_`** 로 받는다 — `_, _, math = student1`. 개수는 여전히 맞아야 한다.
- [ ] ⭐ 값을 **자주 고쳐야 하면 튜플보다 클래스**가 맞다.
- [ ] ⭐⭐⭐ **`students[2].kor` 는 끊어 읽는다** — `students[2]` 로 학생을 고르고 `.kor` 로 멤버를 꺼낸다.
- [ ] ⚠️⭐⭐ **`students.kor` 는 에러.** 멤버를 가진 건 리스트가 아니라 **그 안의 객체**다.
- [ ] ⭐⭐ n 명 미리 만들기는 **`[Student() for _ in range(n)]`** (기본값을 줘 뒀을 때).
- [ ] ⚠️⚠️⭐⭐⭐ **`[Student()] * n` 금지** — `Student()` 가 한 번만 실행돼 **같은 객체가 n 칸**에 들어간다. (`[[0]*m]*n` 과 같은 함정)
- [ ] ⭐⭐⭐ 입력 패턴 — `for _ in range(n): kor, eng, math = map(int, input().split())` → `append(Student(...))`.
- [ ] ⭐ 튜플이면 **`[tuple(map(int, input().split())) for _ in range(n)]`** 한 줄.
- [ ] ⭐⭐ **튜플 리스트는 `key` 없이도 정렬된다** (앞에서부터 비교). **클래스는 `key=` 필수.**
- [ ] ⭐ 객체 리스트는 그대로 순회·집계된다 — `sum(s.kor for s in students)`, `max(students, key=lambda s: s.kor)`.
- [ ] ⭐ 고르기 — **읽기만 하고 항목이 적다 → 튜플**, **항목이 많거나 고친다 → 클래스**.
- [ ] ⚠️⚠️⭐⭐⭐ **과목별로 리스트를 따로 두면 `kors.sort()` 때 영어·수학이 안 따라온다** — 줄이 어긋난다. **이게 객체 정렬을 쓰는 이유.**
- [ ] ⭐⭐ **`lambda x: x * 2` 는 `def f(x): return x * 2` 와 같다** — 이름 없는 함수, `return` 을 안 쓴다.
- [ ] ⭐⭐⭐ **`key` 의 `x` 는 "원소 하나"** — 객체면 **`x.kor`**, 튜플이면 **`x[0]`**. 차이는 이것뿐.
- [ ] ⭐⭐ 내림차순은 **`key=lambda x: -x.kor`** — `reverse=True` 와 결과가 같고, **기준을 섞어 쓸 수 있어** 더 많이 쓴다.
- [ ] ⚠️⭐⭐ **동점이 보이면 기준이 하나 더 필요하다** — 문제의 "동점이면 ○○ 순"을 빠뜨리면 틀린다.
- [ ] ⭐⭐⭐ 튜플 리스트는 **`for kor, eng, math in students:`** — 순회와 언패킹을 한 번에.
- [ ] ⚠️⭐⭐ **문자열에는 `-` 를 못 붙인다** — 문자열 내림차순은 `reverse=True`, 방향이 섞이면 두 번 정렬.
- [ ] ⚠️⭐⭐ **`key=` 를 빼먹으면 `sort() takes no positional arguments`**, `x.kor()` 로 괄호를 붙이면 `'int' object is not callable`.
- [ ] ⭐ **1등만 필요하면 정렬하지 않는다** — `max(students, key=...)` 가 `O(n)` 으로 더 빠르다.
- [ ] ⭐⭐⭐ **튜플은 `>` `<` 로 직접 비교된다** — `(2,3) > (2,8)` 은 False. **앞이 같을 때만 뒤를 본다 = 우선순위.**
- [ ] ⭐⭐⭐ 우선순위가 여럿이면 **`key` 가 튜플을 돌려주게** 한다 — `(x.kor, x.eng)`, 적는 순서가 곧 순위.
- [ ] ⭐⭐⭐ **방향은 자리마다 `-` 로** 정한다 — `(x.kor, -x.eng)`. `reverse=True` 는 전부 한꺼번에 뒤집는다.
- [ ] ⚠️⭐⭐ **`(x.eng, x.kor)` 과 `(x.kor, x.eng)` 는 다른 결과.** 순서를 틀리면 조용히 오답.
- [ ] ⚠️⭐⭐ **튜플 괄호를 빼면** `,` 뒤가 `sort` 의 인자로 읽혀 **`SyntaxError`** — `key=lambda x: (x.kor, x.eng)`.
- [ ] ⭐⭐⭐ **기준이 멤버가 아니어도 된다** — `key=lambda x: x.kor + x.eng + x.math` 처럼 **그 자리에서 계산**한다.
- [ ] ⭐ 계산이 길면 **`def` 로 빼서 `key=함수이름`**.
- [ ] ⭐⭐ **`key` 안의 조건식은 숫자다** (`False=0 < True=1`) — `key=lambda x: (x.kor < 60, x.kor)` 로 "조건 만족하는 쪽 먼저".
- [ ] ⭐ lambda 로 안 되면 **`from functools import cmp_to_key`** → `key=cmp_to_key(compare)`. **`-1`=a 앞, `1`=b 앞, `0`=무관.**
- [ ] ⚠️⭐⭐ 파이썬3 에 **`sort(cmp=...)` 는 없다.** 그리고 **대부분 `key` 로 써진다** — `cmp_to_key` 는 느리니 마지막 수단.
- [ ] ⭐⭐⭐ 정렬 후 **"누구였는지"가 필요하면 번호를 묶음에 넣어 둔다** — `tuple(map(int, input().split())) + (i + 1,)`.
- [ ] ⚠️⚠️⭐⭐⭐ **`(i + 1,)` 의 쉼표 필수** — `(i + 1)` 은 그냥 숫자라 `can only concatenate tuple (not "int") to tuple`.
- [ ] ⚠️⚠️⭐⭐⭐ **번호는 뒤에 붙인다.** 앞에 붙이면 **번호가 1순위 기준**이 돼 정렬이 무의미해진다.
- [ ] ⭐⭐ **`i` 는 0부터** — 문제가 1번부터 세면 `i + 1`. 헷갈리면 답이 전부 1씩 밀린다.
- [ ] ⭐⭐⭐ 동점 조건은 보통 **"번호가 작은 순"** — `key=lambda x: (-x[0], x[3])`.
- [ ] ⭐ `enumerate(rows, 1)` 로도 된다 — 번호가 **앞**에 오니 **`key` 를 반드시** 줘야 한다.
- [ ] ⭐ 클래스면 **`self.idx` 멤버 하나**로 끝 — 앞뒤 순서 고민이 없다.
- [ ] ⭐ 등수 출력은 정렬 후 **`for rank, s in enumerate(students, 1)`**.
