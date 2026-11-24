def solution(s):
    const = 0
    for i in s:
        if i == '(':
            const += 1
        else:
            const -= 1
        if const < 0:
            return False                
    return const == 0