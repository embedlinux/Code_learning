#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/12/13  10:06

import random


# 快速排序求第K大的数
def quick_sort(arr, start, end, findx = -1):
    if start >= end:
        return
    pivot = end
    partition_index = partition(arr, pivot, start, end)
    if partition_index == findx:
        print(arr[partition_index - 1])
    quick_sort(arr, start, partition_index - 1, findx)
    quick_sort(arr, partition_index + 1, end, findx)


def partition(arr, pivot, start, end):
    pivot_value = arr[pivot]
    start_index = start
    for i in range(start, end):
        if arr[i] < pivot_value:
            arr[i], arr[start_index] = arr[start_index], arr[i]
            start_index += 1
    arr[pivot], arr[start_index] = arr[start_index], arr[pivot]

    return start_index


if __name__ == "__main__":
    arr = [random.randint(0, 200) for i in range(10)]
    print(arr)
    quick_sort(arr, 0, len(arr) - 1, 5)
    print(arr)




