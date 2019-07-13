#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/7/12  13:41

# 内置函数
'''
1，整理今天所学内容，整理知识点，整理博客。
2，画好流程图。
3，做一下作业（下面题都是用内置函数或者和匿名函数结合做出）：
4，用map来处理字符串列表,把列表中所有人都变成sb,比方alex_sb
    name=['oldboy','alex','wusir']

5，用map来处理下述l，然后用list得到一个新的列表，列表中每个人的名字都是sb结尾
    l=[{'name':'alex'},{'name':'y'}]

6，用filter来处理,得到股票价格大于20的股票名字
    shares={
        'IBM':36.6,
        'Lenovo':23.2,
        'oldboy':21.2,
        'ocean':10.2,
        }

7,有下面字典，得到购买每只股票的总价格，并放在一个迭代器中。
    结果：list一下[9110.0, 27161.0,......]
    portfolio = [
      {'name': 'IBM', 'shares': 100, 'price': 91.1},
        {'name': 'AAPL', 'shares': 50, 'price': 543.22},
        {'name': 'FB', 'shares': 200, 'price': 21.09},
        {'name': 'HPQ', 'shares': 35, 'price': 31.75},
        {'name': 'YHOO', 'shares': 45, 'price': 16.35},
    {'name': 'ACME', 'shares': 75, 'price': 115.65}]

8,还是上面的字典，用filter过滤出单价大于100的股票。

9,有下列三种数据类型，
    l1 = [1,2,3,4,5,6]
    l2 = ['oldboy','alex','wusir','太白','日天']
    tu = ('**','***','****','*******')
写代码，最终得到的是（每个元祖第一个元素>2,第三个*至少是4个）
    [(3, 'wusir', '****'), (4, '太白', '*******')]这样的数据。

10,有如下数据类型：
    lst1 = [ {'sales_volumn': 0},
            {'sales_volumn': 108},
            {'sales_volumn': 337},
            {'sales_volumn': 475},
            {'sales_volumn': 396},
            {'sales_volumn': 172},
            {'sales_volumn': 9},
            {'sales_volumn': 58},
            {'sales_volumn': 272},
            {'sales_volumn': 456},
            {'sales_volumn': 440},
            {'sales_volumn': 239}]
将lst1按照列表中的每个字典的values大小进行排序，形成一个新的列表。

11. 求结果
    v = [lambda :x for x in range(10)]      # v = [lambda函数地址, ...]
    print(v)                                # lambda,未执行的匿名函数
    print(v[0])                             # 地址
    print(v[0]())                           # 9   ?????

12. 求结果
    v = (lambda :x for x in range(10))      #
    print(v)
    print(v[0])
    print(v[0]())
    print(next(v))
    print(next(v)())
'''

# eval      解析字符串, 有返回值, 可用于求返回值,解析字典,列表等
# exec      没有返回值, 直接执行代码
# compile   将字符串类型的代码编译. 代码对象能够通过exec语句句来执行或者eval()进行求值


def ques4():
    name = ['oldboy', 'alex', 'wusir']
    li4 = map(lambda x: x+"_sb", name)
    print(list(li4))
    print("--------------end question4------------")


def ques5():
    li5 = [{'name':'alex'}, {'name':'y'}]

    def func(li):
        li["name"] = li["name"] + "sb"
        return li
    li5_1 = map(func, li5)
    # li5_1 = map(lambda x: x["name"] + "sb", li5)
    print(list(li5_1))
    print("--------------end question5------------")


def ques6():                    # 重点关注一下, 先得到列表,再得到字典
    shares = {
        'IBM':36.6,
        'Lenovo':23.2,
        'oldboy':21.2,
        'ocean':10.2,
        }
    li6 = filter(lambda x: shares[x] > 20, shares)
    dic6 = {i:shares[i] for i in li6}
    print(dic6)
    print("--------------end question6------------")


def ques7():
    portfolio = [
        {'name': 'IBM', 'shares': 100, 'price': 91.1},
        {'name': 'AAPL', 'shares': 50, 'price': 543.22},
        {'name': 'FB', 'shares': 200, 'price': 21.09},
        {'name': 'HPQ', 'shares': 35, 'price': 31.75},
        {'name': 'YHOO', 'shares': 45, 'price': 16.35},
        {'name': 'ACME', 'shares': 75, 'price': 115.65}]

    li7 = map(lambda x: x["shares"]*x["price"], portfolio)
    print(list(li7))
    print("--------------end question7------------")


def ques8():
    portfolio = [
        {'name': 'IBM', 'shares': 100, 'price': 91.1},
        {'name': 'AAPL', 'shares': 50, 'price': 543.22},
        {'name': 'FB', 'shares': 200, 'price': 21.09},
        {'name': 'HPQ', 'shares': 35, 'price': 31.75},
        {'name': 'YHOO', 'shares': 45, 'price': 16.35},
        {'name': 'ACME', 'shares': 75, 'price': 115.65}]

    li8 = filter(lambda x: x["price"] > 100, portfolio)
    print(list(li8))
    print("--------------end question8------------")


def ques9():
    l1 = [1, 2, 3, 4, 5, 6]
    l2 = ['oldboy', 'alex', 'wusir', '太白', '日天']
    tu = ('**', '***', '****', '*******')
    # 错误
    # l1_1 = filter(lambda x: x > 2, l1)
    # tu_2 = filter(lambda x: len(x) >= 4, tu)
    # li9 = map(lambda x, y, z: (x, y, z), l1_1, l2, tu_2)
    li9 = filter(lambda x: x[0] > 2 and len(x[2]) > 3, zip(l1, l2, tu))
    print(list(li9))
    print("--------------end question9------------")


def ques10():
    lst1 = [{'sales_volumn': 0},
            {'sales_volumn': 108},
            {'sales_volumn': 337},
            {'sales_volumn': 475},
            {'sales_volumn': 396},
            {'sales_volumn': 172},
            {'sales_volumn': 9},
            {'sales_volumn': 58},
            {'sales_volumn': 272},
            {'sales_volumn': 456},
            {'sales_volumn': 440},
            {'sales_volumn': 239}]
    li10 = sorted(lst1, key=lambda x: x["sales_volumn"])
    print(li10)
    print("--------------end question10------------")


if __name__ == "__main__":
    ques4()
    ques5()
    ques6()
    ques7()
    ques8()
    ques9()
    ques10()
