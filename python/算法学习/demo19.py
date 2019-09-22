#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/9/21  22:15
import random


# 线性查找
def line_search(key, array):
    ret = None
    for index, item in enumerate(array):
        if item == key:
            ret = index
            print("%d找到, 索引为:%d" % (key, index))
            return ret
    else:
        print("没有找到%d" % key)
        return


def sub_binary_search(left, right, key, array):
    mid = (left + right) // 2
    mid_value = array[mid]

    if left > right:
        print("未找找到该元素")
        return None

    if key > mid_value:
        return sub_binary_search(mid+1, right, key, array)
    elif key < mid_value:
        return sub_binary_search(left, mid-1, key, array)
    else:
        return mid


# 二分查找
def binary_search(key, array):
    left = 0
    right = len(array) - 1
    status = sub_binary_search(left, right, key, array)
    print(status)


def sub_insert_search(left, right, key, array):

    if (left > right) or (key > array[len(array) - 1]) or (key < array[0]):
        print("未找到该元素")
        return None
    mid = left + (right - left)*(key - array[left])//(array[right] - array[left])
    print(left, mid, right)
    mid_value = array[mid]

    if key > mid_value:
        return sub_insert_search(mid+1, right, key, array)
    elif key < mid_value:
        return sub_insert_search(left, mid-1, key, array)
    else:
        return mid


# 插值查找,不同的是插值查找每次从自适应mid处开始查找, 有问题???进入了死循环?
def insert_search(key, array):
    left = 0
    right = len(array) - 1
    status = sub_insert_search(left, right, key, array)
    print(status)

# 获取斐波拉契数列
def fib(num):
    lis = [0 for i in range(num)]
    lis[0] = 1
    lis[1] = 1
    for i in range(2, num):
        lis[i] = lis[i-1] + lis[i-2]
    return lis


# 斐波拉契查找
# 斐波那契查找原理与前两种相似，仅仅改变了中间结点（mid）的位置，mid不再是中间或插值得到，
# 而是位于黄金分割点附近，即mid=low+F(k-1)-1
def fib_search(key, array):
    low = 0
    high = len(array) - 1
    # 表示斐波拉契分给数值的下标
    k = 0
    mid = 0
    # 获取斐波拉契数列
    fib_list = fib(len(array))
    # print(fib_list)
    # 获取斐波拉契分割值得下标
    while high > fib_list[k] - 1:
        k += 1
    # 因为fib_lis的值可能大于array的长度,因此我们需要对array增加元素
    temp = []
    for i in range(fib_list[k]):
        if i < len(array):
            temp.append(array[i])
        else:
            temp.append(array[high])
    # print(temp)
    # 使用循环查找
    while low <= high:
        mid = low + fib_list[k-1] - 1
        if key < temp[mid]:
            high = mid - 1
            k -= 1
        elif key > temp[mid]:
            low = mid + 1
            k -= 2
        else:
            if mid <= high:
                return mid
            else:
                return high
    return None


if __name__ == "__main__":
    array = [i*2 for i in range(100)]
    # print(array)
    num = 2
    # line_search(num, array)
    # binary_search(num, array)
    # insert_search(num, array)
    status = fib_search(num, array)
    print(status)