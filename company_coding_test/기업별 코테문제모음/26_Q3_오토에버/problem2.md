# 문제 2: 서버 페어 강제 연결 MST (Min/Max)

## 문제 설명

- 1부터 n까지 n개의 노드가 존재한다.
- `networks`로 주어지는 간선들 중 일부를 선택해 전체 노드를 연결하는 네트워크(스패닝 트리)를 구성해야 한다.
- 두 노드 사이에는 여러 개의 경로(간선)가 존재할 수 있다.

### 조건

1. `server_pair`로 주어진 노드쌍은 반드시 **직접 연결**(간선 하나로 직접 연결)되어야 한다.
2. 조건 1을 만족하면서 **가장 적은 선로 개수**를 사용해야 한다. (즉, 전체 n개 노드를 연결하는 스패닝 트리 = n-1개의 간선)

### 입력 형식

- `server_pair`: `[[a,b], [c,d], ...]` 형태, 항상 `a < b`.
- `networks`: `[[a,b,cost1], [c,d,cost2], ...]` 형태. 같은 노드쌍 사이에 비용이 다른 여러 간선이 존재할 수 있음.

## 구하는 값

- 조건을 만족하는 네트워크의 **최소 비용**과 **최대 비용**.

## 제약 조건

- `len(networks) <= 2*10^5`
- `n <= 5*10^4`

## 나의 풀이

- Union-Find + MST(크루스칼)를 min, max 두 번 구한다.
- `server_pair`로 주어진 노드쌍은 여러 후보 간선 중 min/max에 맞는 비용을 선택해야 하므로, `networks`를 비용 기준 정렬하고 `server_pair`도 정렬하여, 정렬된 `networks`를 순회하며 맨 앞 pair와 일치하면 그 비용을 채택 후 `pair.pop(0)` — 이중 for문(`O(n*k)`) 대신 `O(n log n)`으로 매칭.
- `server_pair`에 해당하는 간선은 union하며 강제로 `mst`에 비용을 더하고, 해당하지 않는 간선은 `edges` 후보 리스트에 모아둔다.
- 이후 `edges`를 다시 정렬해서 `build_mst`(표준 크루스칼)를 수행해 나머지 스패닝 트리를 완성한다. `server_pair`로 이미 union되어 n-1개의 간선을 채웠더라도, `build_mst`에서 `union`이 `False`를 반환하는 간선은 자동으로 스킵되므로 전체 `edges`를 순회해도 문제 없다.

```python
def solve(networks, server_pair, is_reverse):
    mst = 0
    parent = [i for i in range(n + 1)]
    edges = []
    pair = sorted(server_pair)

    for a, b, cost in networks:
        if pair and [a, b] == pair[0]:
            mst += cost
            union(parent, a, b)   # server_pair는 강제 union
            pair.pop(0)
        else:
            edges.append((cost, a, b))

    edges.sort(reverse=is_reverse)
    answer.append(build_mst(edges, parent, mst))

min_net = sorted(networks)
solve(min_net, server_pair, False)

max_net = sorted(networks, key=lambda x: (x[0], x[1], -x[2]))
solve(max_net, server_pair, True)
```

- `find`, `union`, `build_mst`는 정석대로 구현. `union`은 실제로 두 컴포넌트를 이었으면 `True`, 이미 같은 컴포넌트면 `False`를 반환.
- `build_mst`에서는 `union(parent, a, b)`가 `True`일 때만 `mst += cost`.

## 정답 풀이 검토

접근 방식과 최종 구현 모두 **맞습니다.**

### 핵심 아이디어 검증

- 결과물은 **n개 노드를 모두 연결하는 스패닝 트리(n-1개 간선)** 이면서, `server_pair`로 주어진 쌍은 반드시 직접 잇는 간선이 포함되어야 함.
- `server_pair` 간선은 일반 크루스칼이 자동으로 선택해주지 않을 수도 있으므로(더 저렴한 우회 경로가 있으면 스킵될 수 있음) **강제로 먼저 선택**해야 하고, 코드에서 `find(a)!=find(b)` 체크 없이 무조건 `union`하는 부분이 이를 정확히 구현하고 있음.
- 같은 노드쌍에 여러 후보 간선이 있을 때, min MST는 오름차순 정렬 상태에서 첫 매치, max MST는 내림차순 정렬 상태에서 첫 매치를 채택하므로 각각 최소/최대 비용이 자동으로 선택됨.
- `pair.pop(0)`으로 이미 처리한 `server_pair`를 제거하기 때문에, 같은 `(a,b)` 쌍의 중복 간선은 두 번째부터 `edges`(일반 간선)로 들어가고, `build_mst`에서 이미 union된 상태라 자연스럽게 스킵됨.

### 발견됐던 버그와 해결 여부

1. **`list.sort()`의 반환값 문제**: `networks.sort()`는 제자리 정렬 후 `None`을 반환하므로 `min_net = networks.sort()`처럼 쓰면 `min_net`이 `None`이 되는 버그가 있었으나, 최종적으로 `sorted(networks)` / `sorted(networks, key=...)`를 사용해 해결됨.
2. **`parent` 배열 스코프 문제**: `union`이 전역 `parent`를 직접 참조하는 형태였다면 `solve()` 내부 로컬 `parent`와 불일치할 위험이 있었으나, 실제로는 `union(parent, a, b)`처럼 **인자로 받아 그 안에서 수정**하는 형태이고 `solve()` 내부에서 일관되게 로컬 `parent`를 `union`, `build_mst`에 전달하고 있어 문제 없음. `solve()`가 min/max 각각 호출될 때마다 `parent`가 새로 초기화되므로 두 실행이 서로 오염되지도 않음.

### 검증 포인트

1. `server_pair` 매칭 시 `networks`와 `server_pair`가 모두 정렬되어 있어야 "첫 매치 = min/max 비용" 보장이 성립함.
2. `server_pair` 간선은 연결 여부와 상관없이 무조건 union — 입력이 유효하다는 전제(=`server_pair`들끼리 사이클을 이루지 않아 n-1개로 스패닝 트리가 가능한 케이스) 하에서 성립.
3. `edges`를 끝까지 순회해도, 이미 연결된 노드 쌍에 대한 `union` 호출은 `False`를 반환하고 `mst`에 더해지지 않으므로 결과에 영향 없음.
4. min MST와 max MST는 **정렬 방향(오름차순/내림차순)만 다르고 로직은 동일**하므로 하나의 `solve` 함수로 재사용 가능.

### 시간복잡도

- 정렬: `O(m log m)` (m = networks 길이, ≤ 2×10^5), min/max 각각 한 번씩 (server_pair 매칭용 1회 + edges 재정렬 1회).
- Union-Find 연산: `O(m α(n))`.
- 전체: `O(m log m)`, `n ≤ 5×10^4`, `m ≤ 2×10^5` 기준으로 충분히 통과.

---

## 업그레이드 버전: 힙 기반 2단계 처리 (조기 종료 없이 안전하게)

정렬 대신 힙을 쓰되, **"server_pair 강제 처리"와 "일반 간선 Kruskal"을 명확히 두 단계로 분리**하는 버전.

### 시행착오: 왜 조기 종료(`components` 기준)를 넣으면 안 되는가

- 처음엔 `components == 1 and not required`일 때 멈추는 조기 종료를 시도했으나, 이는 **위험한 접근**임이 드러남.
- `server_pair` 자체가 사이클을 만들 수 있기 때문. 예: `{1,2,3}`을 모두 직접 연결해야 하는 pair가 `(1,2),(2,3),(1,3)` 3개라면, 실제 merge는 2번만 일어나 `components`가 예상보다 먼저 줄어들 수 있음.
- 게다가 힙에서는 `required` 간선과 일반 간선이 **비용 순서로 뒤섞여서** pop되기 때문에, "지금 시점에 required가 다 처리됐는지"와 "components가 몇인지"의 타이밍이 꼬일 위험이 있음.
- 조기 종료로 얻는 이득(운 좋으면 덜 pop)은 점근적 복잡도를 줄여주지 않는데(`O(m log m)`으로 동일), 잘못 짜면 오답 위험이 있으므로 **이득 대비 리스크가 안 맞음** → 조기 종료 제거.

### 올바른 구조: 1단계(강제 처리) → 2단계(힙 Kruskal), 완전히 분리

- **1단계**: `server_pair`는 사이클 여부와 상관없이 **무조건 전부** union + cost 반영. (조기 종료 없이, 모든 required를 다 처리하고 끝)
- **2단계**: 남은 일반 간선만 힙에 넣고, `union()`이 성공(`True`)했을 때만 채택하는 **표준 Kruskal**. 힙이 빌 때까지 진행 (여기도 조기 종료 조건 불필요 — 실패하는 edge는 그냥 스킵되니 손해가 없음).
- 두 단계를 분리했기 때문에, required와 일반 간선이 뒤섞이며 생기는 타이밍 문제가 구조적으로 사라짐.

### 구현

```python
import heapq

def solve_heap(networks, server_pair, is_max=False):
    # 1단계: server_pair 강제 처리 (같은 (a,b)에 중복 간선이 있으면 min/max 비용 선택)
    best_cost = {}
    for a, b, cost in networks:
        key = (a, b)
        if key not in best_cost:
            best_cost[key] = cost
        elif is_max:
            best_cost[key] = max(best_cost[key], cost)
        else:
            best_cost[key] = min(best_cost[key], cost)

    parent = [i for i in range(n + 1)]
    mst = 0
    required = set(map(tuple, server_pair))

    for (a, b) in required:
        union(parent, a, b)          # 사이클 여부 상관없이 강제 union
        mst += best_cost[(a, b)]

    # 2단계: 나머지 간선들로 힙 기반 표준 Kruskal
    if is_max:
        heap = [(-cost, a, b) for a, b, cost in networks if (a, b) not in required]
    else:
        heap = [(cost, a, b) for a, b, cost in networks if (a, b) not in required]
    heapq.heapify(heap)

    while heap:
        raw_cost, a, b = heapq.heappop(heap)
        cost = -raw_cost if is_max else raw_cost
        if union(parent, a, b):      # 실제 merge된 경우만 채택
            mst += cost

    return mst

min_cost = solve_heap(networks, server_pair, is_max=False)
max_cost = solve_heap(networks, server_pair, is_max=True)
```

### 기존 풀이(정렬 2단계 방식)와의 차이점

| | 기존 풀이 (정렬 2단계) | 업그레이드 (힙 2단계) |
|---|---|---|
| server_pair 매칭 | `networks`·`server_pair` 둘 다 정렬 후 two-pointer(`pair.pop(0)`) | `best_cost` 딕셔너리로 `O(m)`에 min/max 비용 계산, `required` set으로 조회 |
| 일반 간선 처리 | `edges`를 다시 정렬 후 순서대로 순회 | `heapify` 후 `heappop` 반복 |
| 종료 조건 | 없음 (전체 순회, `union` 실패시 자연 스킵) | 없음 (힙이 빌 때까지, `union` 실패시 자연 스킵) — **조기 종료 시도했다가 위험성 확인 후 제거** |
| 이론적 시간복잡도 | `O(m log m)` | `O(m log m)` (동일) |

두 방식 모두 "강제 처리 단계"와 "표준 Kruskal 단계"를 분리한다는 안전한 원칙은 동일하고, 정렬을 미리 다 하느냐 힙으로 순차적으로 꺼내느냐의 구현 차이만 있다. 조기 종료는 이론적 이득이 없고 위험성만 있어 두 버전 다 사용하지 않는다.
