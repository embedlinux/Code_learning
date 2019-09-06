#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/9/6  8:41
# 代入法
# 递归树法
# 主方法:求解 T(n) = aT(n/b) + f(n)的递归式, a>=1,b>1,f(n)给定的函数
import math


# 最大子数组问题
def find_max_crossing_subarray(array):
    max_left = 0
    max_right = 0
    left_sum = -math.inf
    sub_sum = 0
    mid = len(array)//2
    # print(mid)
    for i in range(mid, -1, -1):
        # print(i)
        sub_sum = sub_sum + array[i]
        if sub_sum > left_sum:
            left_sum = sub_sum
            max_left = i
    right_sum = -math.inf
    sub_sum = 0
    for j in range(mid+1, len(array)):
        # print(j)
        sub_sum = sub_sum + array[j]
        if sub_sum > right_sum:
            right_sum = sub_sum
            max_right = j
    return max_left, max_right, left_sum, right_sum


def find_maximum_subarray(array):
    pass


if __name__ == "__main__":
    array = [23, -57, 95, 87, -91, 57, 32, 94, 47, -324]
    ret = find_max_crossing_subarray(array)
    print(ret)