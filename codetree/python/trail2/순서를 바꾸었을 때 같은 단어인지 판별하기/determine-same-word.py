word1 = input()
word2 = input()

# 두 단어를 알파벳 순서대로 정렬한 리스트가 완전히 똑같은지 비교합니다.
# 예: 'apple' -> ['a', 'e', 'l', 'p', 'p']
if sorted(word1) == sorted(word2):
    print('Yes')
else:
    print('No')