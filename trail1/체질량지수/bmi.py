h , w = input().split()

b = (10000*int(w))/(int(h)**2)

if b >= 25:
    print(int(b))
    print("Obesity")
else:
    print(int(b))