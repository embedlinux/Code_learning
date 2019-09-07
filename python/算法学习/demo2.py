#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/9/6  8:41
# 代入法
# 递归树法
# 主方法:求解 T(n) = aT(n/b) + f(n)的递归式, a>=1,b>1,f(n)给定的函数
import math


# 最大子数组问题
def find_max_crossing_subarray(array, low, mid, high):
    max_left = 0
    max_right = 0
    left_sum = -math.inf
    sub_sum = 0
    for i in range(mid, low-1, -1):
        # print(i)
        sub_sum = sub_sum + array[i]
        if sub_sum > left_sum:
            left_sum = sub_sum
            max_left = i
    right_sum = -math.inf
    sub_sum = 0
    for j in range(mid+1, high + 1):
        # print(j)
        sub_sum = sub_sum + array[j]
        if sub_sum > right_sum:
            right_sum = sub_sum
            max_right = j
    return max_left, max_right, left_sum + right_sum


def find_maximum_subarray(array, low, high):
    # print(low, high)
    if high == low:
        return low, high, array[low]
    else:
        mid = (low + high)//2
        left_low, left_high, left_sum = find_maximum_subarray(array, low, mid)
        right_low, right_high, right_sum = find_maximum_subarray(array, mid+1, high)
        cross_low, cross_high, cross_sum = find_max_crossing_subarray(array, low, mid, high)
        if left_sum >= right_sum and left_sum >= cross_sum:
            return left_low, left_high, left_sum
        elif right_sum >= left_sum and right_sum >= cross_sum:
            return right_low, right_high, right_sum
        else:
            return cross_low, cross_high, cross_sum


if __name__ == "__main__":
    # array = [23, -57, 95, 87, -91, 57, 32, 94, 47, -324]
    array = [1, -2, 3, 5, -2, 6, -1]
    num = len(array)
    # num = int(input().split()[0])
    # array_input = input().split()
    # array = list(map(lambda x: int(x), array_input))
    ret = find_maximum_subarray(array, 0, num - 1)
    print(ret[2])

    # ret = find_max_crossing_subarray(array, 0, mid, len(array))
    # ret = find_maximum_subarray(array, 0, len(array)-1)
    # print(ret)