# 문제 1: 서버 선택 시뮬레이션

## 문제 설명

- 매 1초마다 데이터가 하나씩 서버로 전송된다. (시간 $t = 0, 1, 2, \dots$)
- 각 데이터는 `dataSize`(처리량)와 `processingTime`(처리 시간)을 가진다.
- 데이터가 도착하면 서버를 아래 규칙에 따라 선택해야 한다.
  1. 현재 사용 가능한(idle) 서버 중 **누적 처리량이 가장 적은** 서버를 선택한다.
  2. 누적 처리량이 같은 서버가 여러 개면 아무거나 선택해도 된다.
  3. 사용 가능한 서버가 하나도 없으면 새 서버를 가동한다 (누적 처리량 0에서 시작).
- 선택된 서버는 해당 데이터를 처리하는 동안 `processingTime`만큼 사용 불가 상태가 되고, 누적 처리량에 `dataSize`가 더해진다.
- 예: 현재 시각이 2, 처리 시간이 3이면 이 서버는 시각 5부터 다시 사용 가능하다. (즉, `leaving_time <= current_time`이면 available)

## 구하는 값

- 전체 과정이 끝난 후, **모든 서버 중 최대 누적 처리량**.

## 제약 조건

- 데이터 개수 $\le 2\times10^5$
- `dataSize[i] \le 10^9`

## 정답 풀이

### 아이디어

- 매 순간 "가장 적게 일한(idle 상태인) 서버"에게 새 작업을 배정하는 것은 문제에서 정의한 규칙을 그대로 따르는 것이며, 별도의 그리디 전략을 고민할 필요 없이 **주어진 규칙을 효율적으로 시뮬레이션**하면 되는 문제.
- 매 시각마다 전체 서버를 순회하며 available 여부와 최솟값을 찾으면 시간초과가 나므로, 힙(우선순위 큐) 2개를 이용해 $O(\log n)$에 처리한다.

### 자료구조

- `busy` 힙: `(leaving_time, cumulative_throughput)` — leaving_time 기준 최소 힙. 아직 작업 중인 서버들을 관리.
- `idle` 힙: `cumulative_throughput` — 최소 힙. 현재 사용 가능한 서버들을 관리.

### 알고리즘

매 시각 $t$ (= 각 데이터가 도착하는 시점)마다:

1. `busy`에서 `leaving_time <= t`인 서버들을 **모두** 꺼내 `idle`에 push (while 루프로, 동시에 여러 서버가 풀릴 수 있음)
2. `idle`에서 누적 처리량이 가장 작은 서버를 pop (없으면 새 서버, 누적 처리량 0)
3. 새 누적 처리량 = 기존 누적 처리량 + `dataSize[t]`
4. `(t + processingTime[t], 새 누적 처리량)`을 `busy`에 push
5. `answer = max(answer, 새 누적 처리량)`

### 의사코드

```python
for time in TIME:
    while busy and busy[0][0] <= time:
        complete, throughput = heappop(busy)
        heappush(idle, throughput)

    if idle:
        throughput = heappop(idle)
    else:
        throughput = 0

    complete = time + processingTime[time]
    throughput += dataSize[time]
    heappush(busy, (complete, throughput))
    answer = max(answer, throughput)
```

### 검증 포인트

1. `leaving_time <= t`인 서버는 **while 루프**로 전부 꺼내야 함 (여러 서버가 동시에 풀릴 수 있음).
2. idle 힙이 비어있으면 새 서버(누적 처리량 0)를 사용한다는 조건을 빠뜨리면 안 됨.
3. `busy`에 넣는 튜플 `(complete, throughput)`은 leaving_time만 기준으로 비교해도 정확성에 문제 없음.
4. `answer` 갱신은 이번 스텝에서 배정된 서버의 새 누적 처리량과만 비교하면 충분 (다른 서버는 이번 스텝에서 변화 없음).

### 시간복잡도

- $n \le 2\times10^5$, 힙 연산 $O(\log n)$ → 전체 $O(n \log n)$.

### `dataSize[i] <= 1e9` 조건에 대한 고찰

- 이 조건은 알고리즘 로직 자체보다는 **정수 오버플로우 이슈**를 알려주는 힌트에 가깝다.
- 최악의 경우 누적 처리량의 총합은 전체 `dataSize`의 합인 최대 $2\times10^5 \times 10^9 = 2\times10^{14}$까지 커질 수 있는데, 이는 32비트 정수 범위($\approx 2.1\times10^9$)를 훌쩍 넘어선다.
- C++/Java 등에서는 `int` 대신 `long long`/`long`(64비트)을 써야 함을 암시하는 조건이며, Python에서는 정수 오버플로우가 없으므로 신경 쓸 필요가 없다.
