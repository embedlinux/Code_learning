#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/9/5  8:43
import random


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


if __name__ == "__main__":
    li = [random.randint(0, 100) for i in range(15)]
    print(li)
    InsertSortUp(li)
    InsertSortDown(li)
