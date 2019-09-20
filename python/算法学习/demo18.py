#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/9/18  18:16
import random
import time


def running_timer(func):
    def inner(array):
        print("%s算法排序前:" % func.__name__, array)
        # start_time = time.time()
        start_time = time.strftime("%Y-%m-%d %X")
        print("排序执行前的时间", start_time)
        func(array)
        print("%s算法排序后:" % func.__name__, array)
        # end_time = time.time()
        end_time = time.strftime("%Y-%m-%d %X")
        print("排序执行后的时间", end_time)
        # running_time = end_time - start_time
        # print("%s算法执行时间:" % func.__name__, running_time)
    return inner


# 选择排序
@running_timer
def select_sort(array):
    for i in range(len(array)-1):
        for j in range(i+1, len(array)):
            if array[i] > array[j]:
                array[i], array[j] = array[j], array[i]


# 冒泡排序
@running_timer
def bubble_sort(array):
    # print("排序前:", array)
    flag = False
    for i in range(len(array)-1):
        # temp = -1
        for j in range(len(array) - i - 1):
            if array[j] > array[j+1]:
                # temp = array[j]
                # array[j] = array[j+1]
                # array[j+1] = temp
                array[j], array[j+1] = array[j+1], array[j]
                flag = True
        if flag is False:
            break
        else:
            flag = False
    # print("排序后:", array)


# 插入排序
@running_timer
def insert_sort(array):
    for i in range(1, len(array)):
        k = i
        temp = array[k]
        for j in range(i-1, -1, -1):
            if temp < array[j]:
                array[j+1] = array[j]
                k = j
        array[k] = temp
        # print(array)


def shell_sub_sort(gap, array):
    for i in range(gap, len(array), gap):
        k = i
        temp = array[k]
        for j in range(i-gap, -1, -gap):
            if temp < array[j]:
                array[j+gap] = array[j]
                k = j
        array[k] = temp


# 希尔排序, 插入排序的一种特殊形式
@running_timer
def shell_sort(array):
    gap = len(array)
    while gap > 1:
        gap = gap // 3 + 1
        shell_sub_sort(gap, array)


if __name__ == "__main__":
    array = [random.randint(0, 100) for i in range(10)]
    # array = [i for i in range(10)]
    # bubble_sort(array)
    # select_sort(array)
    # insert_sort(array)
    shell_sort(array)
