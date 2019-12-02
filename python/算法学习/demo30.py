#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/12/2  14:50

import random


# 查找第一个值等于给定值的元素
def search_first_equal_item(lis, value):
    low = 0
    high = len(lis) - 1
    while low <= high:
        mid = low + (high - low) // 2
        if lis[mid] > value:
            high = mid - 1
        elif lis[mid] < value:
            low = mid + 1
        else:
            if mid == 0 or lis[mid-1] != value:
                return mid
            else:
                high = mid - 1
    return None


# 查找最后一个值等于给定值的元素
def search_last_equal_item(lis, value):
    low = 0
    high = len(lis) - 1
    while low <= high:
        mid = low + (high - low) // 2
        if lis[mid] < value:
            low = mid + 1
        elif lis[mid] > value:
            high = mid - 1
        else:
            if mid == len(lis) - 1 or lis[mid + 1] != value:
                return mid
            else:
                low = mid + 1
    return None


# 查找第一个大于等于给定值的元素
def search_first_ge_item(lis, value):
    low = 0
    high = len(lis) - 1
    while low <= high:
        mid = low + (high - low) // 2
        if lis[mid] >= value:
            if mid == 0 or lis[mid - 1] < value:
                return mid
            else:
                high = mid - 1
        else:
            low = mid + 1


# 查找最后一个小于等于给定值的元素
def search_last_le_item(lis, value):
    low = 0
    high = len(lis) - 1
    while low <= high:
        mid = low + (high - low) // 2
        if lis[mid] <= value:
            if mid == len(lis) - 1 or lis[mid + 1] > value:
                return mid
            else:
                low = mid + 1
        else:
            high = mid - 1


if __name__ == "__main__":
    # lis = [random.randint(0, 10) for i in range(10)]
    lis = [1, 1, 1, 1, 2, 4, 5, 5, 6, 6, 7, 8, 9, 9, 9, 9]
    lis.sort()
    print(lis)
    value = 9
    # item = search_first_equal_item(lis, value)
    # item = search_last_equal_item(lis, value)
    # item = search_first_ge_item(lis, value)
    item = search_last_le_item(lis, value)
    print(item)
