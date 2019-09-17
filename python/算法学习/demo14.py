#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/9/17  21:18

method_num = 0


def print_queue(array):
    global method_num
    method_num += 1
    print('-----第%d种方法------------' % method_num)
    for item in array:
        print(item, end=' ')
    print('\n')


# check是每次递归时,进入到check中都有for i in range(8):
def check_queue(num, array):
    if num == 8:
        print_queue(array)
    else:
        for i in range(8):
            # 先把第n个皇后放在该行的第一列
            array[num] = i
            if judge_queen(num, array):
                check_queue(num+1, array)
            # 如果冲突,继续执行 array[n] = i;即将第n个皇后放在本行后移的一个位置


# 查看放第n个皇后时,检测该皇后是否和前面的皇后冲突
def judge_queen(num, array):
    for i in range(num):
        # array[i] == array[num], 判断第n个皇后是否和前面的n-1个皇后在同一列
        # abs(array[n] - array[i]) == abs(n-i), 判断第n个皇后是否和第i个皇后在同一斜线
        if array[i] == array[num] or abs(array[num] - array[i]) == abs(num-i):
            return False
    return True


def eight_queen():
    max_queue = 8
    maps = [0 for i in range(max_queue)]
    # print_queue(maps)
    check_queue(0, maps)


if __name__ == "__main__":
    eight_queen()