# 오늘 할 일 — 11/10(화) · 케이뱅크 D-4

**목표:** Java로 코드트리 제출이 되고, HashMap·정렬을 통과한 뒤 Oracle `ROWNUM`/`NVL`을 손에 넣는다.  
**총 시간:** 4시간 (첫날 · 아침 재인출 없음)  
**표기:** `Tn-Cn-Ln` = Trail · Chapter · Lesson

---

## 세팅 · 10분

- [x] 코드트리 언어 → **Java**
- [x] 프로그래머스 SQL → 언어 **Oracle**
- [x] (선택) 로컬 `javac`/`java` 또는 IDE

## 치트시트 · 20분

- [x] 계획 **부록 A**를 공책에 한 번 손으로 쓰기  -> 나는 자바 왕초보라 파이썬과 비교하면서 보고 아직 머리속에 완전히 들어오지는 않았어
  (`ArrayList`, `HashMap`, `HashSet`, `.equals`, `StringBuilder`, `Arrays.sort`)

## Java 해시 · 55분

경로: **Trail 5 → Ch1 중급 자료구조 → L1 HashMap** (마지막 1문제는 **L3 HashSet**)

- [x] `T5-C1-L1 hashmap 기본` — [링크](https://www.codetree.ai/trails/complete/curated-cards/intro-hashmap-basic)  입력받는것과 for문의 구조를 몰라서 찾아보면서 작성함
- [x] `T5-C1-L1 가장 많은 데이터` — [링크](https://www.codetree.ai/trails/complete/curated-cards/intro-most-frequent-data) 여기서는 어떻게 해쉬맵의 개수를 세는 지 몰라서 찾아보고 getOrDefault를 이용해서 할 수 있다는 것을 알아냈음) 보고함, 또한 반복문에서 python의 for i in value와 같이 for문을 자바에서 작성하는 방법을 터득함 (for (int cnt : map.value()){} 와 같이
- [x] `T5-C1-L1 대응되는 수와 문자` — [링크](https://www.codetree.ai/trails/complete/curated-cards/challenge-corresponding-numbers-and-characters)   모르는 개념들이 또 많이 나옴 이제 어느정도 변수 선언이나 원시타입, 객체타입은 이해가 되었지만 파이썬에서 바로 배열 번호로 접근하는것과 다르게 자바에서는 Character.isDigit(c) 식으로 숫자글자인가 알파벳인가를 구분해서 가야한다는것을 알 수 있었음
- [x] `T5-C1-L3 서로 다른 수의 개수` — [링크](https://www.codetree.ai/trails/complete/curated-cards/challenge-distinct-numbers)  set에 대해서 배웠고 length대신에 size사용 배움

→ Python 풀이 **닫고**. 15분 막히면 부록 A만 보고 덮고 다시.

## Java 정렬 · 40분

경로: **Trail 2 → Ch3 정렬**

- [ ] `T2-C3-L1 단어 정렬` — [링크](https://www.codetree.ai/trails/complete/curated-cards/intro-sorting-words)
- [ ] `T2-C3-L3 키를 기준으로 정렬` — [링크](https://www.codetree.ai/trails/complete/curated-cards/intro-sort-by-height)
- [ ] `T2-C3-L3 국영수 순이지` (또는 `T2-C3-L3 총점 비교`) — [링크](https://www.codetree.ai/trails/complete/curated-cards/intro-korean-english-math-order)

## Oracle 기초 · 55분 (전부 Oracle)

- [ ] `상위 n개 레코드` (**ROWNUM**)
- [ ] `NULL 처리하기` (**NVL**)
- [ ] `DATETIME에서 DATE로 형 변환` (**TO_CHAR**)
- [ ] `없어진 기록 찾기` (LEFT JOIN … IS NULL)
- [ ] (여유) `동명 동물 수 찾기`

## 재작성 · 30분

- [ ] `T5-C1-L1` HashMap Easy 1개 블라인드
- [ ] `상위 n개` Oracle 블라인드

## 마감 · 10분

- [ ] 내일 아침 카드:  
  ① `map.getOrDefault` / `.equals`  
  ② Comparator  
  ③ `ROWNUM`은 정렬 후 서브쿼리 밖 · `NVL`
- [ ] 계획 §7에 11/10 한 줄
- [ ] **23:30 취침**

---

**최소 라인 (2시간만):** 세팅 10 + 부록 A 15 + `T5-C1-L1` 2문제 40 + `상위 n개`+`NULL 처리` Oracle 40 + HashMap 재작성 15.
