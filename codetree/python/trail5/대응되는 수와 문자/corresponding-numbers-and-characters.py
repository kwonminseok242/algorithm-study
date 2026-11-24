n, m = map(int, input().split())

num_to_word = {}
word_to_num = {}
for i in range(1, n + 1):
    w = input()
    num_to_word[i] = w
    word_to_num[w] = i

for _ in range(m):
    q = input()
    if q.isdigit():
        print(num_to_word[int(q)])
    else:
        print(word_to_num[q])