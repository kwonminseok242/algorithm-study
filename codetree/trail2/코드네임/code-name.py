MAX_N = 5

users = []
for _ in range(MAX_N):
    codename, score = input().split()
    users.append((codename, int(score)))

# Please write your code here.

class spy:
    def __init__(self,codename,score):
        self.cn = codename
        self.sc = score
spies = []
for u in users:
    # u[0]은 codename, u[1]은 score
    new_spy = spy(u[0], u[1]) 
    spies.append(new_spy)

max = 101
who = 0
for i in range(MAX_N):
    if spies[i].sc < max:
        max = spies[i].sc
        who = i
    

print(spies[who].cn, spies[who].sc)






        