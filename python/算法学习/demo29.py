#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/11/27  10:20

import random


def merge_sort_python(lis):
    if len(lis) <= 1:
        return lis
    mid = len(lis) // 2
    lisl = lis[:mid]
    lisr = lis[mid:]
    left = merge_sort_python(lisl)
    right = merge_sort_python(lisr)

    return merge(left, right)


def merge(left, right):
    ret = []
    i = 0
    j = 0
    while i < len(left) and j < len(right):
        if left[i] <= right[j]:
            ret.append(left[i])
            i += 1
        else:
            ret.append(right[j])
            j += 1
    while i < len(left):
        ret.append(left[i])
        i += 1
    while j < len(right):
        ret.append(right[j])
        j += 1
    return ret


def merge_sort(lis):
    return merge_sort_python(lis)

# ----------------------------------------------------------------------


def partition(lis, left, right):
    pivot = lis[right]
    i = left
    for j in range(left, right):
        if lis[j] < pivot:
            lis[i], lis[j] = lis[j], lis[i]
            i += 1
    lis[i], lis[right] = lis[right], lis[i]
    return i


def fast_sort_python(lis, left, right):
    if left >= right:
        return
    mid = partition(lis, left, right)
    fast_sort_python(lis, left, mid-1)
    fast_sort_python(lis, mid+1, right)


def fast_sort(lis):
    right = len(lis) - 1
    fast_sort_python(lis, 0, right)


if __name__ == "__main__":
    lis = [random.randint(0, 200) for i in range(0, 10)]
    print(lis)
    # lis = merge_sort(lis)
    fast_sort(lis)
    print(lis)


