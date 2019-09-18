#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/9/18  15:04
MAXN = 7    # 设置每一注彩票的位数
NUM = 8     # 设置组成彩票的数字
num = [i+1 for i in range(NUM)]
lottery = [0 for i in range(MAXN)]


def combine(nums, maxs):
    global lottery
    for i in range(nums, maxs-1, -1):
        lottery[maxs-1] = num[i-1]   # 保留一位数字
        if maxs > 1:
            combine(i-1, maxs-1)
        else:
            print(lottery)


if __name__ == "__main__":
    # print(num)
    # print(lottery)
    combine(NUM, MAXN)
