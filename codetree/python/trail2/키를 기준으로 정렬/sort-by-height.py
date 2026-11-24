n = int(input())
name = []
height = []
weight = []

for _ in range(n):
    n_i, h_i, w_i = input().split()
    name.append(n_i)
    height.append(int(h_i))
    weight.append(int(w_i))

# Please write your code here.

class human:
    def __init__(self, name, height, weight):
        self.n = name
        self.h = height
        self.w = weight

humans = []
for i in range(n):
    new_human = human(name[i],height[i],weight[i])
    humans.append(new_human)


humans.sort(key=lambda x: x.h)

for h in humans:
    print(h.n, h.h, h.w)

