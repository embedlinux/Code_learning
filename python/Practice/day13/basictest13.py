#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/11  22:53

# 1. 生成器和⽣生成器函数
# 2. 列表推导式 ,字典推导式

# 推导式有, 列表推导式, 字典推导式, 集合推导式, 没有元组推导式
# 生成器表达式: (结果 for 变量量 in 可迭代对象 if 条件筛选)
# 生成器表达式可以直接获取到生成器对象. 生成器对象可以直接进行for循环. 生成器具有惰性机制.

# [ 结果 for 变量量 in 可迭代对象]
# [ 结果 for 变量量 in 可迭代对象 if 条件 ]
# 生成器表达式: (结果 for 变量量 in 可迭代对象 if 条件筛选)

# {k:v for循环 条件筛选}

import random

if __name__ == "__main__":
    se = {random.randint(0, 20) for i in range(0, 10)}
    print(se)

    def add(a, b):
        return a + b

    def test():
        for r_i in range(4):
            yield r_i

    g = test()                      # 获取生成器
    for n in [2, 10]:
        g = (add(n, i) for i in g)
    # g = (add(10, i) for i in (add(10, i) for i in g))
    #  --> g = (add(10, i) for i in (10, 11, 12, 13))

    for n in [2, 10, 5]:
        g = (add(n, i) for i in g)
    # g = (add(5, i) for i in add(5, i) for i in add(5, i) for i in g)
    # g = (add(5, i) for i in add(5, i) for i in (5,6,7,8))
    # g = (add(5, i) for i in (10,11,12,13))
    # g = (15,16,17,18)

    print(list(g))