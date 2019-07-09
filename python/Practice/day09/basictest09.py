#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/9  8:46

# 函数

import random
'''
1，整理函数相关知识点,写博客。

2，写函数，检查获取传入列表或元组对象的所有奇数位索引对应的元素，并将其作为新列表返回给调用者。

3，写函数，判断用户传入的对象（字符串、列表、元组）长度是否大于5。

4，写函数，检查传入列表的长度，如果大于2，那么仅保留前两个长度的内容，并将新内容返回给调用者。

5，写函数，计算传入函数的字符串中,[数字]、[字母]、[空格] 以及[其他]的个数，并返回结果。

6，写函数，接收两个数字参数，返回比较大的那个数字。

7，写函数，检查传入字典的每一个value的长度,如果大于2，那么仅保留前两个长度的内容，并将新内容返回给调用者。
    dic = {"k1": "v1v1", "k2": [11,22,33,44]}
    PS:字典中的value只能是字符串或列表

8，写函数，此函数只接收一个参数且此参数必须是列表数据类型，此函数完成的功能是返回给调用者一个字典，此字典的键值对为此列表的索引及
对应的元素。例如传入的列表为：[11,22,33] 返回的字典为 {0:11,1:22,2:33}。

9，写函数，函数接收四个参数分别是：姓名，性别，年龄，学历。用户通过输入这四个内容，然后将这四个内容传入到函数中，此函数接收到这四
个内容，将内容追加到一个student_msg文件中。

10，对第9题升级：支持用户持续输入，Q或者q退出，性别默认为男，如果遇到女学生，则把性别输入女。

11，写函数，用户传入修改的文件名，与要修改的内容，执行函数，完成整个文件的批量修改操作（升级题）。
12，写一个函数完成三次登陆功能：
    (1)用户的用户名密码从一个文件register中取出。
    (2)register文件包含多个用户名，密码，用户名密码通过|隔开，每个人的用户名密码占用文件中一行。
    (3)完成三次验证，三次验证不成功则登录失败，登录失败返回False。
    (4)登陆成功返回True。
13，再写一个函数完成注册功能：
    (1)用户输入用户名密码注册。
    (2)注册时要验证（文件regsiter中）用户名是否存在，如果存在则让其重新输入用户名，如果不存在，则注册成功。
    (3)注册成功后，将注册成功的用户名，密码写入regsiter文件，并以 | 隔开。
    (4)注册成功后，返回True,否则返回False。

'''


def func2(li):
    li2 = []
    print(li)
    for i in range(len(li)):
        if i % 2 != 0:
            li2.append(li[i])
    return li2


def func3(arg):
    if len(arg) > 5:
        return True
    else:
        False


def func4(arg):
    li4 = []
    if len(arg) > 2:
        li4 = arg[0:2]
    return li4


def func5(arg):
    dic = {}
    if type(arg) == str:
        for i in arg:
            if i.isdigit():
                if dic.get("digit"):
                    dic["digit"] += 1
                else:
                    dic["digit"] = 1
            elif i.isalpha():
                if dic.get("alpha"):
                    dic["alpha"] += 1
                else:
                    dic["alpha"] = 1
            elif i == " ":
                if dic.get("space"):
                    dic["space"] += 1
                else:
                    dic["space"] = 1
            else:
                if dic.get("other"):
                    dic["other"] += 1
                else:
                    dic["other"] = 1
    print(dic)


def func6(a, b):
    if a > b:
        return a
    else:
        return b


def func7(dic):
    dic7 = {}
    for i in dic:
        if len(dic[i]) > 2:
            dic7[i] = dic[i][:2]
        else:
            dic7[i] = dic[i]
    return dic7


def func8(li):
    dic8 = {}
    for i in range(len(li)):
        dic8[i] = li[i]
    return dic8


def func9(name, sex, age, education):
    str1 = "name:{} sex:{} age:{} education:{} ".format(name, sex, age, education)
    with open("ques9/a.txt", "w+", encoding="utf-8") as f:
        f.write(str1)
    print(str1)


def func12():
    times = 3
    ti = 0
    f = open("ques12/register.txt", "r", encoding="utf-8")
    while True:
        inp_name = input("请输入用户名:").strip()
        inp_pass = input("请输入密码:").strip()
        # print(inp_name, inp_pass)
        for fi in f.readlines():
            li = fi.strip().split("|")
            # print(li[0], li[1])
            if li[0] == inp_name and li[1] == inp_pass:
                print("登陆成功")
                f.close()
                return True
        else:
            f.seek(0)
            ti += 1
            if ti >= times:
                print("错误次数过多,用户已被锁定...")
                f.close()
                return False
            else:
                print("用户名或密码错误,重新登录剩余登陆次数 {}".format(times - ti))


def func13():
    f = open("ques12/register.txt", "r+", encoding="utf-8")
    while True:
        inp_name = input("请输入用户名:").strip()
        for fi in f.readlines():
            li = fi.strip().split("|")
            print(li)
            if li[0] == inp_name:
                print("用户名已存在,请重新输入")
                f.seek(0)
                break
        else:
            inp_pass = input("请输入密码:").strip()
            str13 = inp_name + "|" + inp_pass + "\n"
            f.seek(0, 2)
            f.write(str13)
            f.close()
            return True





"""
    (1)用户输入用户名密码注册。
    (2)注册时要验证（文件regsiter中）用户名是否存在，如果存在则让其重新输入用户名，如果不存在，则注册成功。
    (3)注册成功后，将注册成功的用户名，密码写入regsiter文件，并以 | 隔开。
    (4)注册成功后，返回True,否则返回False。
"""


if __name__ == "__main__":
    li = []
    for i in range(10):
        li.append(random.randint(0, 30))
    li2 = func2(li)
    print(li2)
    print("---------------end question2------------")

    re3 = func3(li)
    print(re3)
    print("---------------end question3------------")

    re4 = func4(li)
    print(re4)
    print("---------------end question4------------")

    str5 = "412;;18qa]se d  "
    func5(str5)
    print("---------------end question5------------")

    a = 123123
    b = 424
    bi6 = func6(a, b)
    print(bi6)
    print("---------------end question6------------")

    dic = {"k1": "v1v1", "k2": [11, 22, 33, 44]}
    dic7 = func7(dic)
    print(dic7)
    print("---------------end question7------------")

    dic8 = func8(li)
    print(dic8)
    print("---------------end question8------------")

    name = "Jone"
    sex = "male"
    age = "28"
    education = "master"
    func9(name, sex, age, education)
    print("---------------end question9------------")

    # sta = func12()
    # print(sta)
    # print("---------------end question12------------")

    sta13 = func13()
    print(sta13)
    print("---------------end question13------------")





