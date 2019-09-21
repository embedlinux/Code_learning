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
        # print(gap)
        # break


def sub_quick_sort(left, right, array):
    l = left
    r = right
    while l < r:
        pv = array[l]
        while l < r and pv < array[r]:
            r -= 1
        array[l], array[r] = array[r], array[l]

        while l < r and pv > array[l]:
            l += 1
        array[l], array[r] = array[r], array[l]

    piv = l
    if left < piv:
        sub_quick_sort(left, piv - 1, array)
    if right > piv:
        sub_quick_sort(piv + 1, right, array)


# 快速排序:冒泡排序的改进
@running_timer
def quick_sort(array):
    left = 0
    right = len(array) - 1
    sub_quick_sort(left, right, array)


def merge_sort_partion(left, mid, right, array):
    ret = []
    l = left                    # 左边序列索引
    r = mid + 1                 # 右边序列索引
    # print(l, mid, r)

    while l <= mid and r <= right:
        if array[l] < array[r]:
            ret.append(array[l])
            l += 1
        else:
            ret.append(array[r])
            r += 1
    if l <= mid:
        for i in range(l, mid+1):
            ret.append(array[i])

    if r <= right:
        for i in range(r, right+1):
            ret.append(array[i])

    # 将ret数组中的元素拷贝到array中
    templeft = left
    t = 0
    while templeft <= right:
        array[templeft] = ret[t]
        templeft += 1
        t += 1


def sub_merge_sort(left, right, array):
    # print(left, right)
    if left < right:
        mid = (right + left) // 2
        sub_merge_sort(left, mid, array)        # 左递归分解
        sub_merge_sort(mid+1, right, array)     # 右递归分解
        merge_sort_partion(left, mid, right, array)  # 合并


# 归并排序
@running_timer
def merge_sort(array):
    left = 0
    right = len(array) - 1
    sub_merge_sort(left, right, array)


'''
将所有待比较数值统一为同样的数位长度，数位较短的数前面补零。然后，从最低位开始，依次进行一次排序。
这样从最低位排序一直到最高位排序完成以后, 数列就变成一个有序序列。
'''
# 基数排序, 分配式排序, 空间换时间
@running_timer
def radix_sort(array):
    # 数字都是五位数,因此比较5轮
    for t in range(5):
        n = pow(10, t)
        # print(n)
        bucket = [[] for i in range(10)]            # 桶
        bucket_count = [0 for i in range(10)]       # 桶计数
        for item in array:
            temp = item // n % 10                   # 取出每一位数据
            bucket[temp].append(item)
            bucket_count[temp] += 1
        k = 0
        for i in range(len(bucket)):
            if bucket_count[i] != 0:
                for j in range(bucket_count[i]):
                    array[k] = bucket[i][j]
                    k += 1
        # 桶计数清零
        # for i in range(len(bucket_count)):
        #     bucket_count[i] = 0
    # print(bucket)


if __name__ == "__main__":
    array = [random.randint(0, 20000) for i in range(10)]
    # array = [i for i in range(10)]
    # bubble_sort(array)
    # select_sort(array)
    # insert_sort(array)
    # shell_sort(array)
    # quick_sort(array)
    # merge_sort(array)
    radix_sort(array)
