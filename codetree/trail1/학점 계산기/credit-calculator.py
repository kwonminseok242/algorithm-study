N = int(input())
arr = list(map(float,input().split()))
mean = sum(arr)/N
print(f"{sum(arr)/N:.1f}")
if mean >= 4.0:
    print('Perfect')
elif mean >= 3.0:
    print('Good')
else:
    print('Poor')
