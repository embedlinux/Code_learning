#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/7  12:24

"""
1，写代码，有如下列表，按照要求实现每一个功能
li = ["alex", "WuSir", "ritian", "barry", "wenzhou"]
    1)计算列表的长度并输出
    2)列表中追加元素"seven",并输出添加后的列表
    3)请在列表的第1个位置插入元素"Tony",并输出添加后的列表
    4)请修改列表第2个位置的元素为"Kelly",并输出修改后的列表
    5)请将列表l2=[1,"a",3,4,"heart"]的每一个元素添加到列表li中，一行代码实现，不允许循环添加。
    6)请将字符串s ="qwert"的每一个元素添加到列表li中，一行代码实现，不允许循环添加。
    7)请添加列表中的元素"eric",并输出添加后的列表
    8)请删除列表中的第2个元素，并输出删除的元素和删除元素后的列表
    9)请删除列表中的第2至4个元素，并输出删除元素后的列表
    10)请将列表所有得元素反转，并输出反转后的列表
    11)请计算出"alex"元素在列表li中出现的次数，并输出该次数。

2，写代码，有如下列表，利用切片实现每一个功能
    li = [1, 3, 2, "a", 4, "b", 5,"c"]
    1)通过对li列表的切片形成新的列表l1,l1 = [1,3,2]
    2)通过对li列表的切片形成新的列表l2,l2 = ["a",4,"b"]
    3)通过对li列表的切片形成新的列表l3,l3 = [1,2,4,5]
    4)通过对li列表的切片形成新的列表l4,l4 = [3,"a","b"]
    5)通过对li列表的切片形成新的列表l5,l5 = ["c"]
    6)通过对li列表的切片形成新的列表l6,l6 = ["b","a",3]

3,写代码，有如下列表，按照要求实现每一个功能。
    lis = [2, 3, "k", ["qwe", 20, ["k1", ["tt", 3, "1"]], 89], "ab", "adv"]
    1)将列表lis中的"tt"变成大写（用两种方式）。
    2)将列表中的数字3变成字符串"100"（用两种方式）。
    3)将列表中的字符串"1"变成数字101（用两种方式）。

4,请用代码实现：
    li = ["alex", "eric", "rain"]
    利用下划线将列表的每一个元素拼接成字符串"alex_eric_rain"

5，利用for循环和range打印出下面列表的索引。
    li = ["alex", "WuSir", "ritian", "barry", "wenzhou"]

6，利用for循环和range找出100以内所有的偶数并将这些偶数插入到一个新列表中。

7，利用for循环和range 找出50以内能被3整除的数，并将这些数插入到一个新列表中。

8，利用for循环和range从100~1，倒序打印。

9，利用for循环和range从100~10，倒序将所有的偶数添加到一个新列表中，然后对列表的元素进行筛选，将能被4整除的数留下来。

10，利用for循环和range，将1-30的数字一次添加到一个列表中，并循环这个列表，将能被3整除的数改成*。

11，查找列表li中的元素，移除每个元素的空格，并找出以"A"或者"a"开头，并以"c"结尾的所有元素，并添加到一个新列表中,最后循环打印这个新列表。
    li = ["TaiBai ", "alexC", "AbC ", "egon", " riTiAn", "WuSir", "  aqc"]

12，开发敏感词语过滤程序，提示用户输入评论内容，如果用户输入的内容中包含特殊的字符：
敏感词列表 li = ["苍老师", "东京热", "武藤兰", "波多野结衣"]
则将用户输入的内容中的敏感词汇替换成等长度的*（苍老师就替换***），并添加到一个列表中；如果用户输入的内容没有敏感词汇，则直接添加到上述的列表中。

13，有如下列表
    li = [1, 3, 4, "alex", [3, 7, 8, "TaiBai"], 5, "RiTiAn"]
循环打印列表中的每个元素，遇到列表则再循环打印出它里面的元素。
我想要的结果是：
1
3
4
"alex"
3
7,
8
"taibai"
5
ritian

14.把班级学生数学考试成绩录入到一个列表里,并求平均值.
    要求:录入的时候带着人名录入,例如:张三_44

15.
"""


def func():
    # li = ["alex", "WuSir", "ritian", "barry", "wenzhou"]
    # print("  1):{}".format(len(li)))
    # li.append("seven")
    # print("  2):{}".format(li))
    # li.insert(0, "Tony")
    # print("  3):{}".format(li))
    # li[1] = "Kelly"
    # print("  4):{}".format(li))
    # li2 = [1, "a", 3, 4, "heart"]
    # li.extend(li2)
    # print("  5):{}".format(li))
    # li.extend("qwert")
    # print("  6):{}".format(li))
    # li.append("eric")
    # print("  7):{}".format(li))
    # re2 = li[1]
    # li.remove(re2)
    # print("  8):{}{}".format(re2, li))
    # for i in range(1, 4):
    #     li.remove(li[1])
    # print("  9):{}".format(li))
    # li.reverse()
    # print("  10):{}".format(li))
    # print("  11):{}".format(li.count("seven")))
    # print("-------------------end question1------------")

    # li = ["alex", "eric", "rain"]
    # str = ""
    # for i in li:
    #     str += i + "_"
    # print(str.strip("_"))
    # print("-------------------end question4------------")

    li = [1, 3, 4, "alex", [3, 7, 8, "TaiBai"], 5, "RiTiAn"]
    for i in li:
        if type(i) == list:
            for j in i:
                print(j)
        else:
            print(i)
    print("-------------------end question13------------")


if __name__ == "__main__":
    func()
