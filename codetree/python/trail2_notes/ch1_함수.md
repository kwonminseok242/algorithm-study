# Ch1. 함수 — 개념 정리 노트

> 공부하면서 몰랐던 개념을 모아 두는 복습용 노트입니다.
> 각 개념은 **핵심 요약 → 예시 코드 → 주의할 점** 순서로 정리합니다.

---

## 📌 목차

1. [`tuple(map(int, input().split()))` 의 `tuple` — 없어도 된다](#1-tuplemapint-inputsplit-의-tuple--없어도-된다)
2. [인자가 2개 이상일 때 — 기본값 `c=0` 과 `*args`](#2-인자가-2개-이상일-때--기본값-c0-과-args)
3. [`return print(cnt)` 는 틀렸다 — 반환과 출력은 다른 일](#3-return-printcnt-는-틀렸다--반환과-출력은-다른-일)
4. [루프 변수 이름 겹침 + 한 수를 여러 번 세는 실수](#4-루프-변수-이름-겹침--한-수를-여러-번-세는-실수)

---

## 1. `tuple(map(int, input().split()))` 의 `tuple` — 없어도 된다

### 핵심 요약

- ⭐⭐ **결론부터: `tuple` 을 빼도 똑같이 동작한다.**

  ```python
  row_num, col_num = tuple(map(int, input().split()))   # 코드트리 코드
  row_num, col_num = map(int, input().split())           # ⭐ 이게 가장 흔한 형태
  ```

  둘은 **결과가 완전히 같다.** 변수에 값이 하나씩 들어가는 건 `tuple` 이 해 주는 일이 아니다.

- ⭐ **값을 하나씩 나눠 담는 건 `tuple` 이 아니라 왼쪽의 `,` 다.** 이걸 **언패킹**이라 한다.

  ```
  row_num, col_num  =  map(int, input().split())
  └────── 왼쪽 ─────┘     └──────── 오른쪽 ────────┘
   변수를 개수에 맞춰        순서대로 꺼낼 수 있는 것
   나열하면 하나씩 들어간다        (= 반복 가능한 것)
  ```

- ⭐⭐ **언패킹은 오른쪽이 무엇인지 가리지 않는다.** "순서대로 꺼낼 수 있는 것"이면 전부 된다.

  ```python
  a, b = (1, 2)                       # 튜플   → 된다
  a, b = [1, 2]                       # 리스트 → 된다
  a, b = map(int, ['1', '2'])         # map   → 된다  ⭐
  a, b = '35'                         # 문자열 → 된다 (a='3', b='5')
  a, b = range(2)                     # range → 된다
  ```

  → 그래서 `tuple()` 로 한 번 감싸는 건 **"이미 되는 걸 한 번 더 확인시켜 주는" 군더더기**다.

- 역할 분담을 다시 정리하면 **일을 하는 건 `split()` 과 `map()` 둘뿐이다.**

  ```
  input()  .  split()      →  map(int, ...)        →  a, b = ...
    ↓           ↓                  ↓                     ↓
  한 줄 읽기  공백으로 자르기      문자열 → 정수         변수에 하나씩
            ['3', '5']           3, 5                 (언패킹)

  tuple(...)  ←  이 자리에 끼워 넣어도 하는 일이 없다  ⚠️
  ```

  (ch9 에서 정리한 [`split()` / 언패킹 / `tuple()`](../trail1_notes/ch9_문자열.md#1-공백으로-나눠-여러-개-입력받기--split--언패킹--tuple) 과 같은 이야기다.)

### 그럼 왜 코드트리는 `tuple` 을 써 뒀나

- ⭐ **"오른쪽은 값 여러 개가 묶여 있는 덩어리"라는 걸 눈에 보이게** 하려는 교재식 표기다.
  C++·Java 처럼 묶음 타입을 꼭 적어야 하는 언어에서 오는 습관이기도 하다.
- `map` 은 화면에 찍어 봐도 내용이 안 보여서 **초보자에게 불친절**하다. `tuple` 로 감싸면 보인다.

  ```python
  print(map(int, '3 5'.split()))          # <map object at 0x10...>   ⚠️ 안 보인다
  print(tuple(map(int, '3 5'.split())))   # (3, 5)                    ⭐ 보인다
  ```

  → **디버깅할 때만 감싸 보는 용도**로 기억해 두면 쓸모가 있다.

### `tuple` / `list` 가 정말 필요한 경우 ⭐⭐

**언패킹할 때는 필요 없지만, 변수 하나에 받아 둘 때는 거의 항상 필요하다.**
`map` 이 돌려주는 건 **한 번 꺼내면 사라지는 일회용**이기 때문이다.

```python
nums = map(int, '1 2 3'.split())
print(sum(nums))    # 6
print(sum(nums))    # 0   ⚠️⚠️ 이미 다 꺼내 써서 비어 있다!

nums = list(map(int, '1 2 3'.split()))   # ⭐ list 로 받아 두면
print(sum(nums))    # 6
print(sum(nums))    # 6   ⭐ 몇 번이든 다시 쓸 수 있다
```

```python
nums = map(int, '1 2 3'.split())
print(len(nums))    # ⚠️ TypeError: object of type 'map' has no len()
print(nums[0])      # ⚠️ TypeError: 'map' object is not subscriptable
```

- ⭐ 기준은 하나다 — **변수 개수에 맞춰 왼쪽에 나열하면 감쌀 필요 없고, 덩어리로 하나에 담으면 감싼다.**

  ```python
  n, m = map(int, input().split())              # ⭐ 개수가 정해져 있다 → 그냥 언패킹
  arr  = list(map(int, input().split()))        # ⭐ 개수가 몇 개든 통째로 → list 로 감싼다
  ```

- `tuple` 과 `list` 중 **어느 걸 쓰나?** 입력 받을 때는 보통 **`list`** 를 쓴다.
  나중에 `arr[0] = 5` 처럼 **값을 바꾸거나 `append`** 해야 할 때가 많은데 **튜플은 못 바꾼다.**

  ```python
  arr = tuple(map(int, '1 2 3'.split()))
  arr[0] = 5     # ⚠️ TypeError: 'tuple' object does not support item assignment
  ```

### 예시 코드 — 이 문제에 적용

```python
def print_rect(n, m):
    for _ in range(n):
        print("*" * m)


row_num, col_num = map(int, input().split())   # ⭐ tuple 없이
print_rect(row_num, col_num)
```

```
입력: 3 5

*****
*****
*****
```

**함수 챕터와 이어지는 이야기 — `*` 로 바로 넘기기** (알아 두면 좋음)

```python
nums = list(map(int, input().split()))
print_rect(*nums)        # ⭐ nums = [3, 5] 를 print_rect(3, 5) 로 풀어서 넘긴다
```

- `*` 는 **"묶음을 풀어서 인자 자리에 하나씩 놓아라"** 는 뜻이다. 언패킹의 함수 인자 버전.
- 다만 이 문제처럼 **인자가 2개로 정해져 있으면** `print_rect(row_num, col_num)` 이 더 읽기 쉽다.

### 주의할 점

- ⚠️⭐ **개수가 안 맞으면 바로 에러**다. `tuple` 로 감싸든 안 감싸든 똑같이 난다.

  ```python
  a, b = map(int, '1 2 3'.split())   # ⚠️ ValueError: too many values to unpack (expected 2)
  a, b = map(int, '1'.split())       # ⚠️ ValueError: not enough values to unpack (expected 2, got 1)
  ```

  → 즉 **`tuple` 이 개수를 맞춰 주는 안전장치도 아니다.**

- ⚠️ 개수가 들쭉날쭉하면 **`*` 로 나머지를 받는다.**

  ```python
  n, *rest = map(int, input().split())   # 첫 수는 n, 나머지는 rest 리스트로
  ```

  (`*rest` 는 **항상 리스트**다. 튜플이 아니다.)

- ⚠️⭐ **`split()` 의 결과는 언제나 문자열**이다. 숫자로 쓸 거면 `map(int, ...)` 가 **진짜로 필요한** 부분이다.
  빼먹으면 `"*" * m` 에서 `m` 이 `'5'` 라서 `TypeError` 가 난다. — **빼도 되는 건 `tuple`, 빼면 안 되는 건 `map(int, ...)`.**
- ⚠️ `map` 을 두 번 쓰려다 **빈 결과**가 나오는 실수가 흔하다. 두 번 쓸 거면 **처음부터 `list()` 로 받아 둔다.**
- ⭐ 한 줄로 요약: **`tuple(...)` 은 지워도 되는 글자다. 지우고 쓰는 습관을 들이자.**

---

## 2. 인자가 2개 이상일 때 — 기본값 `c=0` 과 `*args`

### 핵심 요약

- ⭐⭐ **파이썬은 인자 개수가 안 맞으면 그냥 에러를 낸다.** 알아서 0을 채워 주지 않는다.

  ```python
  def add(a, b, c):
      return a + b + c

  print(add(1, 3, 5))   # 9
  print(add(1, 3))      # ⚠️ TypeError: add() missing 1 required positional argument: 'c'
  print(add(1, 3, 5, 7))# ⚠️ TypeError: add() takes 3 positional arguments but 4 were given
  ```

  → 에러 문구를 읽을 줄 알면 된다. **`missing ... 'c'`** = 모자람, **`takes 3 ... but 4 were given`** = 넘침.

- ⭐⭐ **안 넘길 수도 있는 인자에는 기본값을 적어 둔다.** `=` 로 적으면 끝.

  ```python
  def add(a, b, c=0):     # ⭐ c 를 안 넘기면 0 으로 친다
      return a + b + c

  print(add(1, 3, 5))   # 9
  print(add(1, 3))      # 4   ⭐ 에러 없이 a + b 만 계산
  ```

- ⭐⭐ **개수를 아예 모르겠으면 `*args`.** 넘어온 값이 **전부 하나의 튜플로 묶여** 들어온다.

  ```python
  def add(*args):
      print(f"args: {args}")

  add(1, 2)        # args: (1, 2)
  add(1, 2, 3)     # args: (1, 2, 3)
  add()            # args: ()        ⭐ 하나도 안 넘겨도 된다
  ```

  ```python
  def add(*args):
      return sum(args)      # ⭐ 튜플이니까 sum() 한 방

  print(add(1, 3, 2, 6, 5, 4))   # 21
  ```

### 1번 항목과 이어지는 이야기 — `*` 는 같은 기호다 ⭐⭐

**`*` 는 한 가지 뜻뿐이다. 어디에 쓰느냐에 따라 방향만 반대가 된다.**

```
  정의할 때   def add(*args):      ←  흩어져 온 값들을  묶는다   (1, 2, 3) → args
  부를 때     add(*nums)           →  묶여 있는 값들을  푼다     nums=[1,2,3] → add(1,2,3)
```

```python
def print_rect(n, m):
    for _ in range(n):
        print("*" * m)

nums = list(map(int, input().split()))
print_rect(*nums)       # ⭐ [3, 5] 를 풀어서 print_rect(3, 5) 로
```

- 1번에서 본 **언패킹(`a, b = ...`)** 과도 같은 발상이다. **묶기 ↔ 풀기**, 이게 전부다.
- 이름이 `args` 여야 하는 건 아니다. **`*` 가 일을 하고 이름은 관습**이다 (`*nums` 라고 써도 된다).

### 예시 코드 — 세 가지를 한눈에

```python
def add_fixed(a, b, c):        # 정확히 3개
    return a + b + c

def add_default(a, b, c=0):    # 2개 또는 3개   ⭐ 몇 개일지 "정해져" 있을 때
    return a + b + c

def add_any(*args):            # 몇 개든       ⭐ 몇 개일지 "모를" 때
    return sum(args)

print(add_fixed(1, 3, 5))      # 9
print(add_default(1, 3))       # 4
print(add_any(1, 3, 2, 6, 5))  # 17
print(add_any())               # 0    ⭐ sum(()) 은 에러가 아니라 0
```

### 주의할 점

- ⚠️⭐⭐ **기본값이 있는 인자는 반드시 뒤쪽에** 와야 한다. 앞에 두면 **함수를 정의하는 순간** 에러다.

  ```python
  def add(a=0, b, c):   # ⚠️ SyntaxError: non-default argument follows default argument
      ...
  ```

  (파이썬 3.12 부터는 문구가 `parameter without a default follows parameter with a default` 로 바뀌었다. 뜻은 같다.)
  → 이유는 간단하다. `add(1, 3)` 이라고 썼을 때 **1, 3 을 어디에 넣어야 할지 알 수 없기** 때문이다.

- ⚠️⚠️⭐ **기본값으로 리스트를 쓰면 안 된다.** 파이썬에서 가장 유명한 함정이다.

  ```python
  def f(arr=[]):          # ⚠️ 하지 말 것
      arr.append(1)
      return arr

  print(f())   # [1]
  print(f())   # [1, 1]      ⚠️ 비어 있을 줄 알았는데 지난번 게 그대로 남아 있다
  print(f())   # [1, 1, 1]
  ```

  기본값은 **함수를 정의할 때 딱 한 번 만들어져 계속 재사용**된다. 리스트는 **원본이 직접 바뀌는** 타입이라 흔적이 쌓인다.
  → **고치는 법:** 기본값은 `None` 으로 두고 안에서 만든다.

  ```python
  def f(arr=None):
      if arr is None:
          arr = []
      arr.append(1)
      return arr
  ```

  (`0`, `''`, `False` 같은 **안 바뀌는 값**은 기본값으로 써도 안전하다. `c=0` 은 문제없다.)

- ⚠️ **`args` 는 튜플이라 값을 바꿀 수 없다.**

  ```python
  def f(*args):
      args[0] = 9     # ⚠️ TypeError: 'tuple' object does not support item assignment
  ```

  바꿔야 하면 안에서 **`arr = list(args)`** 로 옮긴다. (1번의 "통째로 담을 땐 `list`" 와 같은 이야기.)

- ⚠️ **`*args` 는 맨 뒤에.** 일반 인자 → 기본값 인자 → `*args` → `**kwargs` 순서다.

  ```python
  def k(a, b=0, *args, **kwargs):
      print(a, b, args, kwargs)

  k(1, 2, 3, 4, x=5)    # 1 2 (3, 4) {'x': 5}
  ```

  `**kwargs` 는 **이름을 붙여 넘긴 인자**를 딕셔너리로 모은다. 코딩테스트에서 직접 쓸 일은 거의 없지만 **`*` 한 개 = 튜플, `*` 두 개 = 딕셔너리**만 기억해 두면 된다.

- ⚠️ `*args` 를 받아 놓고 **인덱스로 꺼낼 때 개수를 확인하지 않으면** `IndexError` 가 난다. `len(args)` 로 먼저 세거나, 개수가 정해져 있다면 **애초에 `*args` 를 쓰지 말고 기본값**을 쓴다.
- ⭐ **고르는 기준:** 개수가 **몇 개일지 정해져 있으면 기본값**(`c=0`), **몇 개일지 모르면 `*args`**. 코딩테스트에서는 대부분 **기본값으로 충분**하다.

---

## 3. `return print(cnt)` 는 틀렸다 — 반환과 출력은 다른 일

### 핵심 요약

- ⭐⭐ **`print()` 는 아무것도 돌려주지 않는다.** 화면에 찍고 **`None`** 을 돌려준다.

  ```python
  def f():
      return print(5)

  x = f()        # 화면에는 5 가 찍히지만
  print(x)       # None   ⚠️ 돌려받은 값은 None 이다
  ```

  → `return print(cnt)` 는 **"cnt 를 돌려준다"가 아니라 "None 을 돌려준다"** 는 뜻이다.

- ⭐⭐ **두 일을 분리한다. 함수는 계산해서 `return`, 출력은 밖에서 `print`.**

  ```python
  def count_369(a, b):
      ...
      return cnt          # ⭐ 값만 돌려준다

  print(count_369(a, b))  # ⭐ 찍는 건 밖에서
  ```

- 이게 바로 **lesson 1 (값을 반환하지 않는 함수) → lesson 2 (값을 반환하는 함수)** 의 차이다.

  ```
  반환하지 않는 함수   def print_rect(n, m):  …  print(…)      → 안에서 찍고 끝. return 없음
  반환하는 함수       def count_369(a, b):   …  return cnt    → 값을 주고, 쓰는 쪽이 알아서 함
  ```

- ⭐ **왜 분리하는 게 좋은가** — 돌려받은 값은 **다시 쓸 수 있기** 때문이다.

  ```python
  c = count_369(1, 20)
  print(c * 2)                    # ⭐ 계산에 다시 쓸 수 있다
  print(count_369(1, 10) + count_369(11, 20))

  # 반면 안에서 print 만 하면
  c = condition_cal(1, 20)        # c 는 None → c * 2 는 TypeError ⚠️
  ```

### 주의할 점

- ⚠️ `return` 을 아예 안 써도 함수는 **`None` 을 돌려준다.** `return print(x)` 와 결과가 같다.
- ⚠️⭐ **`return` 을 만나면 함수는 그 자리에서 끝난다.** 뒤에 코드가 있어도 실행되지 않는다. (반복문의 `break` 보다 센 놈 — 함수 전체를 빠져나온다.)
- ⚠️ 그래서 **반복문 안에서 `return` 을 쓰면 "찾자마자 끝내기"** 가 된다. 개수를 세는 중이라면 의도치 않게 1개만 세고 끝날 수 있다.
- ⭐ 습관: **함수 안에 `print` 가 보이면 "이건 출력 전용 함수인가?" 를 한 번 묻는다.** 값이 필요하면 `return`.

---

## 4. 루프 변수 이름 겹침 + 한 수를 여러 번 세는 실수

### 핵심 요약

- ⚠️⚠️⭐⭐ **바깥 루프와 안쪽 루프에 같은 이름을 쓰면 안 된다.** 안쪽이 바깥 값을 **덮어쓴다.**

  ```python
  for i in range(10, 13):
      for i in str(i):      # ⚠️ 같은 i
          pass
      print(i)              # 0, 1, 2   ← 10, 11, 12 가 아니다!
  ```

  `str(i)` 의 마지막 글자가 `i` 에 남는다. **"안쪽 루프가 끝나면 바깥 `i` 는 이미 다른 값"** 이다.

- ⭐ 이름을 다르게 쓰면 끝이다. **`for num in ...` / `for c in str(num)`** 처럼 **뜻이 보이는 이름**을 쓴다.

  ```python
  for num in range(a, b + 1):
      for c in str(num):     # ⭐ 겹치지 않는다
          ...
  ```

- ⭐⭐ **개수를 셀 때는 "무엇을" 세는지부터 정한다.** 둘은 완전히 다른 숫자다.

  ```
  수의 개수        33 → 1   (조건에 맞는 "수"가 하나)
  자릿수(박수) 횟수  33 → 2   (3 이 두 번)
  ```

  **`수의 개수`를 셀 거라면 한 수에서 조건이 맞는 순간 그 수는 끝내야 한다.**

- ⚠️⭐⭐ 이때 쓰는 건 **`continue` 가 아니라 `break`** 다.

  ```
  continue  →  이번 것만 건너뛰고 "계속 돈다"     (안 끝난다 ⚠️)
  break     →  루프를 "빠져나온다"               (⭐ 이게 필요한 것)
  ```

  반복문의 **마지막 줄에 있는 `continue` 는 아무 일도 하지 않는다.** 어차피 다음으로 넘어가니까.

### 예시 코드 — 틀린 코드와 고친 코드

```python
# ⚠️ 틀린 코드
def condition_cal(a, b):
    cnt = 0
    arr = []                                  # ⚠️ 쓰지도 않는다
    for i in range(min(a, b), max(a, b) + 1):
        k = str(i)
        for i in k:                           # ⚠️ 바깥 i 를 덮어쓴다
            if i == '3' or i == '6' or i == '9' or int(k) % 3 == 0:
                cnt += 1
                continue                      # ⚠️ 아무 일도 안 한다 (break 여야)
    return print(cnt)                         # ⚠️ None 을 돌려준다
```

```
1 ~ 20 입력 →  12 가 나온다 (정답은 9)
33 하나만 넣어도 → 2     ⚠️ '3' 이 두 번이라 두 번 세었다
12 하나만 넣어도 → 2     ⚠️ 3의 배수 조건이 자릿수마다 다시 걸렸다
```

```python
# ⭐ 고친 코드 — 안쪽 루프 자체가 필요 없다
def count_369(a, b):
    cnt = 0
    for num in range(min(a, b), max(a, b) + 1):
        s = str(num)
        if num % 3 == 0 or '3' in s or '6' in s or '9' in s:
            cnt += 1
    return cnt

a, b = map(int, input().split())
print(count_369(a, b))
```

- ⭐⭐ **`'3' in s`** — 문자열 안에 그 글자가 있는지 **한 번에** 묻는다. 자릿수를 **돌 필요가 없다.**
- 세 개를 한 번에 묻고 싶으면 `any(c in '369' for c in s)` 도 된다. 다만 **`or` 세 번이 더 읽기 쉽다.**
- `int(k) % 3` 처럼 **되돌릴 필요도 없다.** 애초에 `num` 이 숫자니까 **`num % 3`** 이면 된다.
  (원래 코드가 `int(k)` 를 써야 했던 건 **`i` 를 뺏겼기 때문**이다 — 이름 겹침이 만든 2차 피해.)

### 안쪽 루프를 꼭 쓰고 싶다면

```python
for num in range(a, b + 1):
    if num % 3 == 0:
        cnt += 1
        continue                 # ⭐ 이 continue 는 일을 한다 (아래 검사를 건너뛴다)
    for c in str(num):
        if c in '369':
            cnt += 1
            break                # ⭐⭐ 이 수는 셌으니 자릿수 검사를 끝낸다
```

- 3의 배수 검사는 **수 하나당 한 번**이므로 **바깥**에 있어야 한다. 원래 코드의 가장 큰 버그가 이것이다.
- 여기서의 `continue` 는 **"이미 셌으니 아래로 내려가지 마라"** 는 진짜 역할이 있다.

### 주의할 점

- ⚠️⭐ **`i` 같은 이름을 습관적으로 쓰지 말 것.** 이중 반복문에서는 `i, j` 로, 뜻이 있으면 `num, c` 로.
- ⚠️ 이 버그는 **에러가 안 난다.** 그냥 **답만 틀린다** — 그래서 더 위험하다.
- ⚠️⭐ **한 자리 수만 테스트하면 안 드러난다.** `1~5` 로 돌려 보면 맞는 것처럼 보인다. **`33`, `36`, `12` 같은 두 자리**를 꼭 넣어 본다.
- ⚠️ 안 쓰는 변수(`arr = []`)는 **지운다.** 남겨 두면 "뭔가 하는 줄" 알고 디버깅할 때 헷갈린다.
- ⭐ `min(a, b)` / `max(a, b)` 는 **a > b 로 들어올 수도 있을 때만** 의미가 있다. 문제에 `a ≤ b` 라고 적혀 있으면 **`range(a, b + 1)`** 로 충분하다.

---

## ✅ 한눈에 복습

- [ ] ⭐⭐ **`tuple(map(int, input().split()))` 의 `tuple` 은 빼도 똑같다.**
- [ ] ⭐⭐ 값을 하나씩 나눠 담는 건 `tuple` 이 아니라 **왼쪽의 `,` (언패킹)** 이다.
- [ ] ⭐ 언패킹은 **튜플·리스트·`map`·문자열·`range` 를 가리지 않는다.**
- [ ] 일하는 건 **`split()` (자르기) + `map(int, ...)` (타입 변환)** 둘뿐.
- [ ] 코드트리가 `tuple` 을 쓴 건 **"묶음이다"를 눈에 보이게** 하려는 교재식 표기.
- [ ] ⭐ `print(map(...))` 은 `<map object>` 만 나온다 → **디버깅할 때 `tuple()` 로 감싸면 보인다.**
- [ ] ⚠️⚠️ `map` 은 **일회용** — 두 번 `sum()` 하면 두 번째는 **0**.
- [ ] ⚠️ `map` 에는 **`len()` 도 `[0]` 도 못 쓴다** (TypeError).
- [ ] ⭐⭐ 기준: **왼쪽에 변수 나열 → 안 감싼다 / 하나에 통째로 담기 → `list()` 로 감싼다.**
- [ ] ⭐ 통째로 담을 땐 **`list`** (값을 바꾸거나 `append` 해야 하니까). 튜플은 **수정 불가**.
- [ ] ⚠️⭐ 개수가 안 맞으면 **`ValueError`** — `tuple` 은 안전장치가 **아니다**.
- [ ] 개수가 가변이면 **`n, *rest = ...`** (`*rest` 는 항상 **리스트**).
- [ ] ⭐ 묶음을 **함수 인자로** 풀어 넣을 때도 `*` — `print_rect(*nums)`.
- [ ] ⚠️ 빼도 되는 건 **`tuple`**, 빼면 안 되는 건 **`map(int, ...)`**.
- [ ] ⭐⭐ 인자 개수가 안 맞으면 **에러**다 — 파이썬이 알아서 안 채워 준다.
- [ ] 에러 읽기: **`missing 1 required positional argument: 'c'`** = 모자람 / **`takes 3 ... but 4 were given`** = 넘침.
- [ ] ⭐⭐ 안 넘길 수도 있는 인자는 **기본값** — `def add(a, b, c=0)`.
- [ ] ⚠️⭐⭐ **기본값 인자는 반드시 뒤쪽** — 앞에 두면 **SyntaxError** (정의하는 순간 에러).
- [ ] ⚠️⚠️⭐ **기본값에 리스트 금지** (`arr=[]`) — 호출할수록 쌓인다. **`None` 으로 두고 안에서 만든다.**
- [ ] ⭐⭐ 개수를 모르면 **`*args`** — 넘어온 값이 **튜플 하나**로 묶인다.
- [ ] ⭐ `return sum(args)` 한 줄이면 끝. **`add()` 처럼 비어도 `sum(()) == 0`** 이라 에러 없음.
- [ ] ⭐⭐ **`*` 는 하나의 기호, 방향만 반대** — 정의부에선 **묶고**, 호출부에선 **푼다**(`print_rect(*nums)`).
- [ ] 이름 `args` 는 **관습**일 뿐, 일하는 건 **`*`**.
- [ ] ⚠️ `args` 는 **튜플** → 값 수정 불가. 바꾸려면 **`list(args)`**.
- [ ] ⚠️ 순서는 **일반 → 기본값 → `*args` → `**kwargs`**. `*` 하나=튜플, `**` 둘=딕셔너리.
- [ ] ⭐ 고르는 기준: 개수가 **정해져 있으면 기본값**, **모르면 `*args`** (코테는 대개 기본값이면 충분).
- [ ] ⭐⭐ **`print()` 는 `None` 을 돌려준다** → `return print(cnt)` 는 **cnt 를 돌려주지 않는다**.
- [ ] ⭐⭐ **계산은 `return`, 출력은 밖에서 `print`** — `print(count_369(a, b))`.
- [ ] ⭐ 돌려받은 값은 **다시 쓸 수 있다** (`c * 2`, 함수끼리 더하기). `None` 은 못 쓴다.
- [ ] ⚠️ `return` 이 없는 함수도 **`None`** 을 돌려준다.
- [ ] ⚠️⭐ `return` 을 만나면 **함수 전체가 끝난다** (`break` 보다 세다).
- [ ] ⚠️⚠️⭐⭐ **바깥·안쪽 루프에 같은 이름(`i`) 금지** — 안쪽이 **덮어쓴다**.
- [ ] ⚠️ 그 버그는 **에러가 안 나고 답만 틀린다**. 한 자리 수로는 **안 드러난다** (`33`, `36`, `12` 로 테스트).
- [ ] ⭐ 이름은 뜻이 보이게 — **`for num in ...` / `for c in str(num)`**.
- [ ] ⭐⭐ 세기 전에 정한다 — **수의 개수**(33→1) vs **자릿수 횟수**(33→2).
- [ ] ⚠️⭐⭐ 한 수를 한 번만 세려면 **`continue` 가 아니라 `break`**.
- [ ] ⚠️ 반복문 **마지막 줄의 `continue` 는 아무 일도 안 한다**.
- [ ] ⚠️⭐ **"수 하나당 한 번" 검사(`num % 3`)는 안쪽 루프에 넣으면 자릿수만큼 중복된다.**
- [ ] ⭐⭐ 자릿수에 특정 글자가 있는지는 **`'3' in s`** — 루프 자체가 필요 없다.
- [ ] ⭐ `num` 이 이미 숫자면 **`int(str(num))` 처럼 되돌리지 않는다**.
- [ ] ⚠️ 안 쓰는 변수(`arr = []`)는 **지운다**.
- [ ] `min(a, b)`/`max(a, b)` 는 **a > b 가 가능할 때만** 필요.
