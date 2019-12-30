#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/12/28  21:08
import random


def hail_stone(n, li):
    if n <= 1:
        li.append(1)
        return
    if n % 2 == 0:
        li.append(n)
        hail_stone(n//2, li)
    else:
        li.append(n)
        hail_stone(3*n+1, li)


def bubble_sort(li):
    flag = False
    while not flag:
        flag = True
        for i in range(1, len(li)):
            if li[i] < li[i-1]:
                li[i], lis[i-1] = li[i-1], li[i]
                flag = False


def reverse_lis(li, lo, hi):
    if lo < hi:
        li[lo], li[hi] = li[hi], li[lo]
        reverse_lis(li, lo+1, hi-1)


def sum_lis(li, low, high):
    if low == high:
        return li[low]
    mid = low + (high - low) // 2
    return sum_lis(li, low, mid) + sum_lis(li, mid+1, high)


# 找出最大的两个元素
def max2_lis(li, low, high):
    x1 = low
    x2 = low + 1
    if li[x1] < li[x2]:
        x1, x2 = x2, x1
    for i in range(low+2, high):
        if li[x2] < li[i]:
            x2 = i
            if li[x1] < li[x2]:
                x1, x2 = x2, x1
    return li[x1], li[x2]


# 找出最大的两个元素, 分而治之版本
def max2_lis_m(li, low, high):
    if (low + 1 == high) or (low + 2 == high):
        x1 = low
        x2 = low + 1
        if li[x1] < li[x2]:
            x1, x2 = x2, x1
        if low + 2 == high:
            if li[x1] < li[low + 2]:
                x2 = x1
                x1 = low + 2
            elif li[x2] < li[low + 2]:
                x2 = low + 2
        return x1, x2

    mid = (low + high) // 2
    x1l, x2l = max2_lis_m(li, low, mid)
    x1r, x2r = max2_lis_m(li, mid+1, high)

    if li[x1l] > li[x1r]:
        x1 = x1l
        x2 = x2l if (li[x2l] > li[x1r]) else x1r
    else:
        x1 = x1r
        x2 = x1l if (li[x1r] > li[x2r]) else x2r
    return x1, x2


# 最长公共子序列longest common sub-sequence,不要求连续
def lcs_recursion(str_a, m, str_b, n):
    if m == -1 or n == -1:
        return ''
    if str_a[m] == str_b[n]:
        return lcs_recursion(str_a, m-1, str_b, n-1) + str_a[m]
    else:
        sub_a = lcs_recursion(str_a, m, str_b, n-1)
        sub_b = lcs_recursion(str_a, m-1, str_b, n)

        if len(sub_a) > len(sub_b):
            return sub_a
        else:
            return sub_b


if __name__ == "__main__":
    lis = []
    hail_stone(163, lis)
    print(lis, len(lis))

    lis = [random.randint(1, 1000) for i in range(10)]
    print(lis)
    # bubble_sort(lis)
    # print(lis)

    reverse_lis(lis, 0, len(lis)-1)
    print(lis)

    print(sum_lis(lis, 0, len(lis)-1))
    print(max2_lis(lis, 0, len(lis)-1))
    print(max2_lis_m(lis, 0, len(lis)-1))

    stra = 'immaculate'      # 'advantage'
    strb = 'computer'        # 'educational'
    print(lcs_recursion(stra, len(stra)-1, strb, len(strb)-1))

