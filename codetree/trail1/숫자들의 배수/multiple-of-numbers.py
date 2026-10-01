N = int(input())

cnt = 0
cc = 1
while cnt <2:
    print(N*cc,end =' ')
    if (N*cc)%5 == 0:
        cnt +=1
    cc +=1