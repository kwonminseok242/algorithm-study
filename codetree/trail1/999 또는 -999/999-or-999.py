arr = list(map(int,input().split()))
answer =[]
for i in arr:
    if i == 999 or i == -999:
        break
    else:
        answer.append(i)

print(max(answer), min(answer))


    