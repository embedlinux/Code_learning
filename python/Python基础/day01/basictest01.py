#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/6  9:02


# 1、使用while循环输入1..10
# 2、求1 - 100 的所有数的和
# 3、输出1 - 100的所有奇数
# 4、输出1 - 100内的所有偶数
# 5、求1 - 2 + 3 - 4 + 5...99的所有数的和


def func1(num):
    i = 0
    while i <= num:
        print(i, end=" ")
        i += 1
    print("\n---end func1---")


def func2(num):
    sum_n = 0
    for i in range(1, num+1):
        sum_n += i
    print(sum_n)
    print("---end func2---")


def func3(num):
    sum_n = 0
    for i in range(1, num+1):
        if i % 2 != 0:
            sum_n += i
    print(sum_n)
    print("---end func3---")


def func4(num):
    sum_n = 0
    for i in range(1, num+1):
        if i % 2 == 0:
            sum_n += i
    print(sum_n)
    print("---end func4---")


def func5(num):
    sum_n = 0
    for i in range(1, num):
        if i % 2 == 0:
            sum_n -= i
        else:
            sum_n += i
    print(sum_n)
    print("---end func5---")


if __name__ == "__main__":
    func1(10)
    func2(100)
    func3(100)
    func4(100)
    func5(100)


