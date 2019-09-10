#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/9/5  8:43
import random
import math


# 升序
def InsertSortUp(args):
    for i in range(1, len(args)):
        key = args[i]
        j = i - 1
        while j >= 0 and args[j] > key:
            args[j+1] = args[j]
            j = j - 1
        args[j+1] = key
    print(args)


# 降序
def InsertSortDown(args):
    for i in range(1, len(args)):
        key = args[i]
        j = i - 1
        while j >= 0 and args[j] < key:
            args[j+1] = args[j]
            j = j - 1
        args[j+1] = key
    print(args)


# 分治法思想, 归并排序
def Merge(left, right):
    '''
    :param left:  列表
    :param right:
    :return:
    '''
    # print(left, mid, right)
    ret = []
    left.append(math.inf)
    right.append(math.inf)
    print(left, right)
    i = 0
    j = 0
    for k in range(0, len(left) + len(right) - 2):
        if left[i] <= right[j]:
            ret.append(left[i])
            i += 1
        else:
            ret.append(right[j])
            j += 1
    return ret


def MergeSort(li):
    if len(li) == 1:
        return li
    else:
        mid = len(li) // 2
        lil = li[:mid]
        lir = li[mid:]
        left = MergeSort(lil)
        right = MergeSort(lir)
        return Merge(left, right)


if __name__ == "__main__":
    li = [random.randint(0, 100) for i in range(15)]
    print(li)
    # InsertSortUp(li)
    # InsertSortDown(li)
    # Merge(li, 0, len(li)//2, len(li))
    ret = MergeSort(li)
    print(ret)