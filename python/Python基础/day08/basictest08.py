#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/8  20:40

"""
#作业一：写出购物车程序
#需求:
用户名和密码存放于文件中，格式为：egon|egon123
启动程序后，先登录，登录成功则让用户输入工资,然后打印商品列表，失败则重新登录，超过三次则退出程序
允许用户根据商品编号购买商品
用户选择商品后，检测余额是否够，够就直接扣款，不够就提醒
可随时退出，退出时，打印已购买商品和余额

1，有如下文件，a1.txt，里面的内容为：

老男孩是最好的学校，
全心全意为学生服务，
只为学生未来，不为牟利。
我说的都是真的。哈哈

分别完成以下的功能：
a,将原文件全部读出来并打印。
b,在原文件后面追加一行内容：信不信由你，反正我信了。
c,将原文件全部读出来，并在后面添加一行内容：信不信由你，反正我信了。
d,将原文件全部清空，换成下面的内容：
    每天坚持一点，
    每天努力一点，
    每天多思考一点，
    慢慢你会发现，
    你的进步越来越大。
e,将原文件内容全部读取出来，并在‘我说的都是真的。哈哈’这一行的前面加一行，
‘你们就信吧~’然后将更改之后的新内容，写入到一个新文件：a1.txt。

2，有如下文件，t1.txt,里面的内容为：
    葫芦娃，葫芦娃，
    一根藤上七个瓜
    风吹雨打，都不怕，
    啦啦啦啦。
    我可以算命，而且算的特别准:
    上面的内容你肯定是心里默唱出来的，对不对？哈哈

分别完成下面的功能：
    a,以r+的模式打开原文件，判断原文件是否可读，是否可写。
    b,以r的模式打开原文件，利用for循环遍历文件句柄。
    c,以r的模式打开原文件，以readlines()方法读取出来，并循环遍历
        readlines(),并分析b,与c 有什么区别?
        深入理解文件句柄与readlines()结果的区别。
    d,以r模式读取‘葫芦娃，’前四个字符。
    e,以r模式读取第一行内容，并去除此行前后的空格，制表符，换行符。
    f,以r模式打开文件，从‘风吹雨打.....’开始读取，一直读到最后。
    g,以a+模式打开文件，先追加一行：‘老男孩教育’然后在从最开始将原内容全部读取出来。
    h,截取原文件，截取内容：‘葫芦娃，葫芦娃，’


3，文件a.txt内容：每一行内容分别为商品名字，价钱，个数。
    apple 10 3
    tesla 100000 1
    mac 3000 2
    lenovo 30000 3
    chicken 10 3
通过代码，将其构建成这种数据类型：[{'name':'apple','price':10,'amount':3},{'name':'tesla','price':1000000,'amount':1}......]
并计算出总价钱。

4，有如下文件：
    alex是老男孩python发起人，创建人。
    alex其实是人妖。
    谁说alex是sb？
    你们真逗，alex再牛逼，也掩饰不住资深屌丝的气质。
将文件中所有的alex都替换成大写的SB（文件的改的操作）。

5，文件a1.txt内容
    name:apple price:10 amount:3 year:2012
    name:tesla price:100000 amount:1 year:2013
    .......

通过代码，将其构建成这种数据类型：
[{'name':'apple','price':10,'amount':3},
{'name':'tesla','price':1000000,'amount':1}......]
并计算出总价钱。

6，文件a1.txt内容(升级题)

    序号     部门      人数      平均年龄      备注
    1       python    30         26         单身狗
    2       Linux     26         30         没对象
    3       运营部     20         24         女生多
    .......
通过代码，将其构建成这种数据类型：
[{'序号':'1','部门':Python,'人数':30,'平均年龄':26,'备注':'单身狗'},
......]

"""


def func1():
    # f = open("ques1/a1.txt", mode="r+", encoding="utf-8")
    # for i in f:
    #     print(i.strip())
    # f.close()

    # f = open("ques1/a1.txt", mode="a", encoding="utf-8")
    # f.write("\n信不信由你，反正我信了。")
    # f.close()

    # f = open("ques1/a1.txt", mode="r+", encoding="utf-8")
    # for i in f:
    #     print(i.strip())
    # f.write("\n信不信由你，反正我信了。")
    # f.close()

    # f = open("ques1/a1.txt", mode="w", encoding="utf-8")
    # str ='''每天坚持一点，\n每天努力一点，\n每天多思考一点，\n慢慢你会发现，\n你的进步越来越大。'''
    # f.write(str)
    # f.close()

    f = open("ques1/a1.txt", mode="r+", encoding="utf-8")
    stre = f.read()
    stre = stre[:-10] + "你们就信吧~\n" + stre[-10:]
    f.seek(0)
    f.write(stre)
    print(stre)
    f.close()


def func2():
    # f = open("ques2/t1.txt", mode="r", encoding="utf-8")
    # for i in f:
    #     print(i.strip())
    # f.close()

    # f = open("ques2/t1.txt", mode="r", encoding="utf-8")
    # for i in f.readlines():
    #     print(i.strip())
    # f.close()

    # f = open("ques2/t1.txt", mode="r", encoding="utf-8")
    # str3 = f.readline()[:4]
    # print(str3)
    # f.close()

    # f = open("ques2/t1.txt", mode="r", encoding="utf-8")
    # str4 = f.readline().strip()
    # print(str4)
    # f.close()

    # f = open("ques2/t1.txt", mode="r", encoding="utf-8")
    # f.seek(49)
    # for i in f:
    #     print(i.strip())
    # f.close()

    # f = open("ques2/t1.txt", mode="a+", encoding="utf-8")
    # f.write("老男孩教育\n")
    # f.seek(0)
    # for i in f:
    #     print(i.strip())
    # f.close()

    f = open("ques2/t1.txt", mode="r+", encoding="utf-8")
    strh = f.readline().strip()
    print(strh)
    f.close()


def func3():
    li3 = []
    sum_m = 0
    f = open("ques3/a.txt", mode="r+", encoding="utf-8")
    for i in f:
        dic = {}
        li = i.strip().split(" ")
        dic["name"] = li[0]
        dic["price"] = int(li[1])
        dic["amount"] = int(li[2])
        sum_m += dic["price"] * dic["amount"]
        li3.append(dic)
    f.close()
    print(li3)
    print(sum_m)


def func4():
    import os
    with open("ques4/a1.txt", mode="r", encoding="utf-8") as f1, \
            open("ques4/a1_new.txt", mode="w", encoding="UTF-8") as f2:
        content = f1.read()
        new_content = content.replace("alex", "SB")
        f2.write(new_content)
    os.remove("ques4/a1.txt")
    os.rename("ques4/a1_new.txt", "ques4/a1.txt")


def func5():
    li5 = []
    sum_m = 0
    f = open("ques5/a1.txt", mode="r+", encoding="utf-8")
    for i in f:
        dic = {}
        li = i.strip().split(' ')
        for j in li:
            li_s = j.split(":")
            dic[li_s[0]] = li_s[1]
        sum_m += int(dic["price"]) * int(dic["amount"])
        li5.append(dic)
    print(li5)
    print(sum_m)


def func6():
    li6 = []
    f = open("ques6/a1.txt", mode="r+", encoding="utf-8")
    li = f.readline().split()
    for i in f.readlines():
        dic = {}
        li_s = i.split()
        for j in range(len(li)):
            dic[li[j]] = li_s[j]
        li6.append(dic)
    print(li6)
    f.close()


if __name__ == "__main__":
    # func1()
    # func2()
    # func3()
    # func4()
    # func5()
    func6()