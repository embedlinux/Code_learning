#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/12/19  10:02
# KPM字符串匹配


def kpm(lis_a, lis_b):
    lis_next = get_next(lis_b)
    j = 0
    n = len(lis_a)
    m = len(lis_b)
    for i in range(n):
        # 一直找到lis_a[i] 和 lis_b[j]
        while j > 0 and lis_a[i] != lis_b[j]:
            j = lis_next[j-1] + 1
        if lis_a[i] == lis_b[j]:
            j += 1
        if j == m:
            return i-m+1
    return -1


def get_next(lis_b):
    m = len(lis_b)
    lis_next = [-1 for i in range(m)]
    k = -1
    for i in range(1, m):
        while k != -1 and lis_b[k+1] != lis_b[i]:
            k = lis_next[k]
        if lis_b[k+1] == lis_b[i]:
            k += 1
        lis_next[i] = k
    return lis_next


if __name__ == "__main__":
    lis_a = 'abcacabcbcbacabcabcab'     # 主串
    lis_b = 'abcc'                      # 模式串
    ret = kpm(lis_a, lis_b)
    print(ret)


