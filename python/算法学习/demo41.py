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


max_w = 100       # 存储背包中物品总重量的最大值
# cw表示当前已经装进去的物品的重量和；i表示考察到哪个物品了
# w背包重量；items表示每个物品的重量；n表示物品个数
# 假设背包可承受重量100，物品个数10，物品重量存储在数组a中，那可以这样调用函数：
# f(0, 0, a, 10, 100)


def f(i, cw, items, n, w):
    global max_w
    if cw == w or i == n:   # w表示装满了;i==n表示已经考察完所有的物品
        if cw > max_w:
            max_w = cw
            return
    f(i+1, cw, items, n, w)
    if cw + items[i] <= w:  # 已经超过可以背包承受的重量的时候，就不要再装了
        f(i + 1, cw+items[i], items, n, w)


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
    cal8queens(0)

