#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/9/18  13:43
# 用贪婪算法求找零钱方案

parvalue = [10000, 5000, 2000, 1000, 500, 200, 100, 50, 20, 10]  # 定义人民币面额列表
num = [0 for i in range(len(parvalue))]


# 四舍五入
def exchange(memory):
    memory = int(memory)
    print(memory)
    global num
    index = 0
    while memory > 0 and index < len(num):
        if 5 <= memory < 10:
            num[len(num)-1] += 1
            break
        elif memory >= parvalue[index]:
            memory -= parvalue[index]
            num[index] += 1
        else:
            index += 1


if __name__ == "__main__":
    memory = 35.34
    exchange(memory * 100)
    # print(num)
    print("%s元钱的组成:" % memory)
    for index in range(len(num)):
        if num[index] != 0:
            print("%6.2f: %2d张" % (parvalue[index]/100, num[index]))




