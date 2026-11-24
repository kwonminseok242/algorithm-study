def solution(phone_book):
    phone_book.sort()
    for i in range(len(phone_book) -1): # 이거 왜 -1 하지 어차피 0부터 시작하니까 개수는 상관없지 않나?
        cur = phone_book[i]
        nxt = phone_book[i+1]
        if nxt[:len(cur)] == cur:
            return False
    return True