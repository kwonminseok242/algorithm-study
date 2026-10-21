n, k = map(int,input().split())
coin = [int(input()) for _ in range(n)]
coin_re = sorted(coin,reverse=True)

coin_num = 0


for c in coin_re:
    num = k//c
    coin_num += num
    k = k%c

print(coin_num)

    