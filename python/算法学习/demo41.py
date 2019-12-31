#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/12/30  15:29

result = [-1 for i in range(8)]     # 全局或成员变量,下标表示行,值表示queen存储在哪一列
counter = 0


def cal8queens(row):
    global counter
    if row == 8:
        counter += 1
        print_queens(result)
        print(result)
        return
    for col in range(8):
        if is_ok(row, col) is True:
            result[row] = col
            cal8queens(row+1)


def print_queens(res):
    for row in range(8):
        for col in range(8):
            if res[row] == col:
                print("Q ", end='')
            else:
                print("* ", end='')
        print('\n')
    print('counter is {}'.format(counter))
    print('------------------')


def is_ok(row, col):                # 判断row行column列放置是否合适
    left_up = col - 1
    right_up = col + 1
    for i in range(row-1, -1, -1):  # 逐行往上考察每一行
        if result[i] == col:        # 第i行的column列有棋子吗？
            return False
        if right_up >= 0:           # 考察左上对角线：第i行left_up列有棋子吗？
            if result[i] == left_up:
                return False
        if right_up < 8:            # 考察右上对角线：第i行right_up列有棋子吗？
            if result[i] == right_up:
                return False
        left_up -= 1
        right_up += 1
    return True


max_w = -1                                          # 存储背包中物品总重量的最大值
max_v = -1
weight = [2, 2, 4, 6, 3]                            # 物品重量
values = [3, 4, 8, 9, 6]                            # 物品的价值
n = len(weight)                                     # 物品个数
w = 9                                               # 背包承受的最大重量
mem = [[False for i in range(10)] for j in range(5)]      # 备忘录，默认值false


# cw表示当前已经装进去的物品的重量总和；i表示考察到哪个物品了
def f(i, cw):
    global max_w
    if cw == w or i == n:   # w表示装满了;i==n表示已经考察完所有的物品
        if cw > max_w:
            max_w = cw
            return
    if mem[i][cw] is True:
        return
    mem[i][cw] = True           # 重复状态
    f(i+1, cw)                  # 选择不装第i个物品
    if cw + weight[i] <= w:     # 已经超过可以背包承受的重量的时候，就不要再装了
        f(i + 1, cw+weight[i])  # 选择装第i个物品


# weight:物品重量，n:物品个数，w:背包可承载重量
def knapsack(weight, n, w):
    states = [[False for i in range(w+1)] for j in range(n)]
    states[0][0] = True             # 不放第一个物品
    states[0][weight[0]] = True     # 放入第一个物品
    for i in range(1, n):           # 动态规划状态转移
        for j in range(0, w+1):     # 不把第i个物品放入背包
            if states[i-1][j] is True:
                states[i][j] = states[i-1][j]
        for j in range(0, w-weight[i]+1):   # 把第i个物品放入背包
            if states[i-1][j] is True:
                states[i][j+weight[i]] = True
    # print(states)
    for i in range(w, -1, -1):                  # 输出结果
        if states[n-1][i] is True:
            return i
    return 0


# weight:物品重量，n:物品个数，w:背包可承载重量
def knapsack2(weight, n, w):
    states = [False for i in range(w+1)]
    states[0] = True
    states[weight[0]] = True
    for i in range(n):
        for j in range(w-weight[i], -1, -1):    # 把第i个物品放入背包
            if states[j] is True:
                states[j + weight[i]] = True
    # print(states)
    for i in range(w, -1, -1):
        if states[i] is True:
            return i
    return 0


# i表示即将要决策第i个物品是否装入背包，cw表示当前背包中物品的总重量，cv表示当前背包中物品的总价值
# 回溯算法
def knapsack3(i, cw, cv):
    global max_v
    if cw == w or i == n:                   # cw==w表示装满了，i==n表示物品都考察完了
        if cv > max_v:
            max_v = cv
        return
    knapsack3(i+1, cw, cv)                  # 选择不装第i个物品
    if cw + weight[i] <= w:
        knapsack3(i+1, cw+weight[i], cv+values[i])  # 选择装第i个物品


# 动态规划
def knapsack4(weight, value, n, w):
    states = [[-1 for j in range(w+1)] for i in range(n)]
    states[0][0] = 0
    states[0][weight[0]] = value[0]
    for i in range(1, n):
        for j in range(0, w+1):
            if states[i-1][j] >= 0:         # 不选择第i个物品
                states[i][j] = states[i-1][j]
        for j in range(0, w-weight[i]):     # 选择第i个物品
            v = states[i-1][j] + value[i]
            if v > states[i][j+weight[i]]:
                states[i][j+weight[i]] = v
    max_value = -1
    for j in range(w+1):
        if states[n-1][j] > max_value:
            max_value = states[n-1][j]
    return max_value


class Patten(object):
    def __init__(self, pattern, plen):
        self.matched = False
        self.pattern = pattern
        self.plen = plen

    def match(self, text, tlen):
        self.matched = False
        self.rmatch(0, 0, text, tlen)
        return self.matched

    def rmatch(self, ti, pj, text, tlen):
        if self.matched is True:    # 如果已经匹配了，就不要继续递归了
            return
        if pj == self.plen:         # 正则表达式到结尾了
            if ti == tlen:          # 文本串也到结尾了
                self.matched = True
                return
            if self.pattern[pj] == '*':     # *匹配任意个字符
                for k in range(tlen-ti+1):
                    self.rmatch(ti+k, pj+1, text, tlen)
            elif self.pattern[pj] == "?":   # ?匹配0个或者1个字符
                self.rmatch(ti, pj+1, text, tlen)
                self.rmatch(ti+1, pj+1, text, tlen)
            elif ti < tlen and self.pattern[pj] == text[ti]:    # 纯字符匹配才行
                self.rmatch(ti+1, pj+1, text, tlen)


if __name__ == "__main__":
    # cal8queens(0)
    # print(mem)
    print(knapsack(weight, n, w))
    print(knapsack2(weight, n, w))
    knapsack3(0, 0, 0)
    print(max_v)
    print(knapsack4(weight, values, n, w))

