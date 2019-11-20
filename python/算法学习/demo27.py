#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/11/20  21:31

# 背包问题,动态规划
# 背包问题主要是指一个给定容量的背包、若干具有一定价值和重量的物品，如何选择物品放入背包使物品的价值最大。
# 其中又分01背包和完全背包(完全背包指的是：每种物品都有无限件可用)

weight = [1, 4, 3]                  # 物品的重量
value = [1500, 3000, 2000]          # 物品的价值
m = 4                               # 背包的重量
n = len(value)                      # 物品的个数


def display_value(lis):
    for item in range(len(lis)):
        print(lis[item])


def display_path(lis):
    i = len(lis) - 1        # 行的最大下标
    j = len(lis[0]) - 1
    while i > 0 and j > 0:
        if lis[i][j] == 1:
            print("第%d个商品放入到背包" % (i))
            j -= weight[i-1]
        i -= 1


if __name__ == "__main__":

    # v[i][j]表示钱i个物品中能够装入容量为j的背包中的最大价值
    v = [[0 for i in range(m+1)] for j in range(n+1)]
    path = [[0 for i in range(m+1)] for j in range(n+1)]
    # print(v)
    for i in range(1, len(v)):          # 不处理第一行
        for j in range(1, len(v[0])):   # 不处理第一列
            if weight[i-1] > j:
                v[i][j] = v[i-1][j]
            else:
                # i 从1开始的
                # v[i][j] = max(v[i-1][j], value[i-1] + v[i-1][j-weight[i-1]])
                if v[i-1][j] < value[i-1] + v[i-1][j-weight[i-1]]:
                    v[i][j] = value[i-1] + v[i-1][j-weight[i-1]]
                    path[i][j] = 1
                else:
                    v[i][j] = v[i-1][j]

    display_value(v)
    display_path(path)


