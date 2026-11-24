user2_id, user2_level = input().split()
user2_level = int(user2_level)

# Please write your code here.

class character:
    def __init__(self,id = 'codetree', level=10):
        self.id = id
        self.level = level

user1 = character('codetree',10)
user2 = character(user2_id,user2_level)

print(f'user {user1.id} lv {user1.level}\nuser {user2.id} lv {user2.level}')

