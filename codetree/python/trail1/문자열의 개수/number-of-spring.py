s = ''
cnt = 1
arr = []
while True:
    s = input()
    if s != "0" and cnt%2 != 0:
        arr.append(s)
    elif s == '0':
        break
    
    cnt +=1

print(cnt-1)
for i in arr:
    print(i)

        
