#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/12/26  18:33

num = 0


def count(lis_a):
    n = len(lis_a)
    merge_sort(lis_a, 0, n-1)
    return num


def merge_sort(lis_a, p, r):
    if p >= r:
        return
    q = (p + r) // 2
    merge_sort(lis_a, p, q)
    merge_sort(lis_a, q+1, r)
    merge(lis_a, p, q, r)


def merge(lis_a, p, q, r):
    global num
    i = p
    j = q + 1
    k = 0
    tmp = [-1 for i in range(r-p+1)]
    while i <= q and j <= r:
        if lis_a[i] <= lis_a[j]:
            tmp[k] = lis_a[i]
            i += 1
        else:
            num += q - i + 1  # 统计p-q之间，比a[j]大的元素个数
            tmp[k] = lis_a[j]
            j += 1
        k += 1

    while i <= q:
        tmp[k] = lis_a[i]
        k += 1
        i += 1

    while j <= r:
        tmp[k] = lis_a[j]
        k += 1
        j += 1

    for i in range(r-p+1):
        lis_a[p+i] = tmp[i]


if __name__ == "__main__":
    pass

