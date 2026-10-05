# 1 a b = a번째 문자와 b번째 문자를 교환한 뒤 출력합니다.
# 2 x y = 문자 x를 전부 문자 y로 변경한 뒤 출력합니다.


s,q = input().split() # 문자열, 질문수
arr = list(s)
for i in range(int(q)):
    t,a,b = input().split()
    if int(t) == 1:
        arr[int(a)-1],arr[int(b)-1] = arr[int(b)-1],arr[int(a)-1]
    elif int(t) ==2:
        for i in range(len(arr)):
            if arr[i] == a:
                arr[i] = b
    for i in arr:
        print(i,end='')
    print()

                
    





