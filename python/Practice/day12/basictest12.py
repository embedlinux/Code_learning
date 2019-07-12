#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/10  21:35

# 函数名, 闭包, 迭代器

'''
1，整理今天的博客，写课上代码，整理流程图。
2，用列表推导式做下列小题
(1)    过滤掉长度小于3的字符串列表，并将剩下的转换成大写字母
(2)    求(x,y)其中x是0-5之间的偶数，y是0-5之间的奇数组成的元祖列表
(3)    求M中3,6,9组成的列表M = [[1,2,3],[4,5,6],[7,8,9]]
(4)    求出50以内能被3整除的数的平方，并放入到一个列表中。
(5)    构建一个列表：['python1期', 'python2期', 'python3期', 'python4期', 'python6期', 'python7期', 'python8期',
'python9期', 'python10期']
(6)    构建一个列表：[(0, 1), (1, 2), (2, 3), (3, 4), (4, 5), (5, 6)]
(7)    构建一个列表：[0, 2, 4, 6, 8, 10, 12, 14, 16, 18]
(8)    有一个列表l1 = ['alex', 'WuSir', '老男孩', '太白']将其构造成这种列表['alex0', 'WuSir1', '老男孩2', '太白3']
(9)有以下数据类型：
x = {
    'name':'alex',
    'Values':[{'timestamp':1517991992.94,
         'values':100,},
        {'timestamp': 1517992000.94,
        'values': 200,},
        {'timestamp': 1517992014.94,
         'values': 300,},
        {'timestamp': 1517992744.94,
         'values': 350},
        {'timestamp': 1517992800.94,
         'values': 280}
        ],}
将上面的数据通过列表推导式转换成下面的类型：[[1517991992.94, 100], [1517992000.94, 200], [1517992014.94, 300],
 [1517992744.94, 350], [1517992800.94, 280]]
3，求结果：
    v = [i % 2 for i in range(10)]
    print(v)            # [0 1 0 1 0 1 ...]

4，求结果:
    v = (i % 2 for i in range(10))
    print(v)            # generator

5，求结果：

    for i in range(5):
        print(i)
    print(i)            # 0 1 2 3 4 4
'''


def ques2():
    li = ['bn', 'vho', 'bvha', 'f', 'hfiwh', 'eqhrv', 'bvbz', 'vzv']
    li1 = [i.upper() for i in li if len(i) >= 3]
    print("(1):{}".format(li1))

    li2 = [(x, y) for x in range(5) if x%2 == 0 for y in range(5) if y%2 != 0]
    print("(2):{}".format(li2))

    M = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    li3 = [[x, y, z] for x in M[0] if x==3 for y in M[1] if y==6 for z in M[2] if z==9]
    print("(3):{}".format(li3))

    li4 = [x*x for x in range(50) if x%3 == 0]
    print("(4):{}".format(li4))

    li5 = ["python" + str(i) + "期" for i in range(1, 11)]
    print("(5):{}".format(li5))

    li6 = [(x, y) for x in range(6) for y in range(7) if y==x+1]
    print("(6):{}".format(li6))

    li7 = [x for x in range(20) if x%2 == 0]
    print("(7):{}".format(li7))

    li = ['alex', 'WuSir', '老男孩', '太白']
    li8 = [x + str(i) for i, x in enumerate(li)]
    print("(8):{}".format(li8))

    x = {
        'name': 'alex',
        'Values': [{'timestamp': 1517991992.94,
                    'values': 100, },
                   {'timestamp': 1517992000.94,
                    'values': 200, },
                   {'timestamp': 1517992014.94,
                    'values': 300, },
                   {'timestamp': 1517992744.94,
                    'values': 350},
                   {'timestamp': 1517992800.94,
                    'values': 280}
                   ], }
    li9 = [[i['timestamp'], i['values']] for i in x['Values']]
    print("(9):{}".format(li9))


if __name__ == "__main__":
    ques2()
    print("-------------end question2----------------")
