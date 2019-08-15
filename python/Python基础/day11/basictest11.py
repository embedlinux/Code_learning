#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/9  21:48

# 1. 函数参数--动态传参
# 2. 名称空间, 局部名称空间, 全局名称空间, 作⽤用域, 加载顺序.
# 3. 函数的嵌套
# 4. gloabal, nonlocal关键字

# 查看函数说明...
# print(str.__doc__)

import random

'''
1,继续整理函数相关知识点，写博客。
2,写函数，接收n个数字，求这些参数数字的和。（动态传参）
3,读代码，回答：代码中,打印出来的值a,b,c分别是什么？为什么？
    a=10
    b=20
    def test5(a,b):
        print(a,b)
    c = test5(b,a)    # 20, 10
    print(c)          # None
    
4,读代码，回答：代码中,打印出来的值a,b,c分别是什么？为什么？
    a=10
    b=20
    def test5(a,b):
        a=3
        b=5
         print(a,b)     # 3 5
    c = test5(b,a)      # None
    print(c)
    
5,写函数,传入函数中多个实参(均为可迭代对象如字符串,列表,元祖,集合等),将每个实参的每个元素依次添加到函数的动态参数args里面.
例如 传入函数两个参数[1,2,3] (22,33)最终args为(1,2,3,22,33)

6,写函数,传入函数中多个实参(实参均为字典),将每个实参的键值对依次添加到函数的动态参数kwargs里面.
例如 传入函数两个参数{‘name’:’alex’} {‘age’:1000}最终kwargs为{‘name’:’alex’ ,‘age’:1000}
7, 下面代码成立么?如果不成立为什么报错?怎么解决?
7.1
    a = 2
    def wrapper():
        print(a)   # 2
    wrapper()

7.2
    a = 2
    def wrapper():
            a += 1 # 报错，local variable 'a' referenced before assignment
        print(a)
    wrapper()
7.3
    def wrapper():
        a = 1
        def inner():
            print(a)   # 1
        inner()
    wrapper()
7.4
    def wrapper():
        a = 1
        def inner():
            a += 1
            print(a)  #报错，local variable 'a' referenced before assignment
        inner()
    wrapper()

8，写函数,接收两个数字参数,将较小的数字返回.
9，写函数,接收一个参数(此参数类型必须是可迭代对象),将可迭代对象的每个元素以’_’相连接,形成新的字符串,并返回.
    例如 传入的可迭代对象为[1,'老男孩','武sir']返回的结果为’1_老男孩_武sir’
10，写函数，传入n个数，返回字典{‘max’:最大值,’min’:最小值}
    例如:min_max(2,5,7,8,4) 返回:{‘max’:8,’min’:2}(此题用到max(),min()内置函数)
11，写函数，传入一个参数n，返回n的阶乘
    例如:cal(7)  计算7*6*5*4*3*2*1
12，写函数，返回一个扑克牌列表，里面有52项，每一项是一个元组（升级题）
    例如：[(‘红心’，2),(‘草花’，2), …(‘黑桃’，‘A’)]
13 有如下函数:
def wrapper():
        def inner():
            print(666)
    wrapper()

你可以任意添加代码,用两种或以上的方法,执行inner函数.
'''


def func2(*li):
    sum_li = 0
    print(li)
    for i in li:
        sum_li += i
    print(sum_li)


def func5(*args):
    print(args)


def func6(**kwargs):
    print(kwargs)


def func8(*args):
    min_n = args[0]
    # print(args)
    for i in args:
        if min_n > i:
            min_n = i
    return min_n


def func9(*args):
    str_n = ""
    if len(args) <= 1:
        return False
    for i in args:
        str_n += str(i) + "_"
    return str_n[:-1]


def func10(*args):
    dic = {}
    dic["min"] = min(args)
    dic["max"] = max(args)
    return dic


def func11(arg):
    if arg == 1:
        return 1
    else:
        return func11(arg - 1) * arg


def poker12(*args):
    return args


def func12():
    poker = []
    poker_color = ["红心", "黑桃", "草花", "方块"]
    poker_size = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
    for i in poker_size:
        for j in poker_color:
            poker.append(poker12(j, i))
    return poker


def wrapper():
    def inner():
        print(666)
    # inner()
    return inner()


if __name__ == "__main__":
    li2 = []
    for i in range(10):
        li2.append(random.randint(0, 30))
    func2(*li2)
    print("----------------end question2----------------")

    li5 = [1, 2, 3]
    tu5 = (22, 33)
    func5(*li5, *tu5)
    print("----------------end question5----------------")

    dic61 = {"name":"alex"}
    dic62 = {"age":1000}
    func6(**dic61, **dic62)
    print("----------------end question6----------------")

    min_n = func8(*li2)
    print(min_n)
    print("----------------end question8----------------")

    li9 = [1, '老男孩', '武sir']
    str_9 = func9(*li9)
    print(str_9)
    print("----------------end question9----------------")

    li10 = [2, 5, 7, 8, 4]
    dic_10 = func10(*li10)
    print(dic_10)
    print("----------------end question10----------------")

    n_11 = func11(5)
    print(n_11)
    print("----------------end question11----------------")

    poker_12 = func12()
    print(poker_12)
    print("----------------end question12----------------")

    wrapper()
    # wrapper.inner()
    print("----------------end question13----------------")

