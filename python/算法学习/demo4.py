#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/9/7  15:01
# 稀疏数组
#  1.记录数组一共有几行几列，有多少个不同的值
#  2.把具有不同值的元素的行列及值记录在一个小规模的数组中，从而缩小程序的规模

# json / pickle
import json
import os

filename = os.path.abspath(__file__)
dirname = os.path.dirname(filename)
loaddir = os.path.join(dirname, "file")
loadfile = os.path.join(loaddir, "spare_array.txt")
# print(loadfile)


# 创建原始数组
def create_spare_array():
    spare_array = []
    spare_array.append([11, 11, 2])
    spare_array.append([1, 2, 1])
    spare_array.append([2, 3, 2])
    str_array = json.dumps(spare_array)
    with open(loadfile, "w+", encoding="utf-8") as f:
        f.write(str_array)


# 将稀疏数组转换为原始数组
def display(spare_array):
    row = spare_array[0][0]
    col = spare_array[0][1]
    num = spare_array[0][2]
    count = 1
    for i in range(row):
        for j in range(col):
            if count <= num:
                if spare_array[count][0] == i and spare_array[count][1] == j:
                    print(spare_array[count][2], end=" ")
                    count += 1
                else:
                    print(0, end=" ")
            else:
                print(0, end=" ")
        print("\n")


# 加载稀疏数组
def load_array():
    with open(loadfile, "r", encoding="utf-8") as f:
        str_array = f.read()
    array = json.loads(str_array)
    return array


if __name__ == "__main__":
    # create_spare_array()
    array = load_array()
    display(array)
