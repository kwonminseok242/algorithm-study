eyes_mean = float(input())

if eyes_mean >= 0.5:
    if eyes_mean < 1.0:
        print('Middle')
    elif eyes_mean >= 1.0:
        print("High")
else:
    print('Low')