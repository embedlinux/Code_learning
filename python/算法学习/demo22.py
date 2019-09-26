#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/9/26  22:03
import random

# 将给定无序序列构造成一个大顶堆（一般升序采用大顶堆，降序采用小顶堆)
# 将堆顶元素与末尾元素进行交换，使末尾元素最大。然后继续调整堆，再将堆顶元素与末尾元素交换，得到第二大元素。
# 如此反复进行交换、重建、交换。
# 堆排序


def heap_sort(array):
    # 将数组调整为大顶堆:升序
    for index in range(len(array)//2 - 1, -1, -1):
        adjust_heap(array, index, len(array))

    # 对接下来n-2个元素重新调整
    for j in range(len(array)-1, -1, -1):
        array[0], array[j] = array[j], array[0]
        adjust_heap(array, 0, j)


def adjust_heap(array, index, len):
    """
    func:以index对应的非叶子节点的子树调整为大顶堆
    :param array: 列表
    :param index: 非叶子节点的索引
    :param len: 需要调整的元素个数
    """
    temp = array[index]
    k = 2 * index + 1
    # k 是 i的左子结点点
    while k < len:
        if k+1 < len and array[k] < array[k+1]:
            # 左子结点小于右子结点
            k += 1
        if array[k] > temp:             # 子结点大于父节点
            array[index] = array[k]     # 把较大的值赋值给当前结点
            index = k                   # index指向k, 继续循环比较
        else:
            break
        k = 2 * k + 1
    # for 循环结束, index为父节点的树局部最大
    array[index] = temp


if __name__ == "__main__":
    array = [random.randint(0, 200) for i in range(0, 7)]
    # array = [0, 29, 3, 20, 45, 42, 4]
    print(array)
    heap_sort(array)
    print(array)
