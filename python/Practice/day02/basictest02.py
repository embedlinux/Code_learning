#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/6  9:31



import re


'''

1、写代码，有如下变量，请按照要求实现每个功能
    name  =  "  aleX"
    a.  移除 name 变量对应的值两边的空格，并输入移除后的内容
    b.  判断 name 变量对应的值是否以  "al"  开头，并输出结果
    c.  判断 name 变量对应的值是否以  "X"  结尾，并输出结果
    d.  将 name 变量对应的值中的  “l”  替换为  “p”，并输出结果
    e.  将 name 变量对应的值根据  “l”  分割，并输出结果。
    f.  请问，上一题  e  分割之后得到值是什么类型（可选）？
    g.  将 name 变量对应的值变大写，并输出结果
    h.  将 name 变量对应的值变小写，并输出结果
    i.  请输出 name 变量对应的值的第 2 个字符？
    j.  请输出 name 变量对应的值的前 3 个字符？
    k.  请输出 name 变量对应的值的后 2 个字符？
    l.  请输出 name 变量对应的值中  “e”  所在索引位置？
    m.  获取子序列，仅不包含最后一个字符。如：  oldboy  则获取  oldbo;  root  则获取  roo
2、请用代码实现：
    a.  利用下划线将列表的每一个元素拼接成字符串，li  ＝  "alexericrain"
    b.  利用下划线将列表的每一个元素拼接成字符串，li  ＝  ['alex',  'eric',  'rain']    （可选）
3、实现一个整数加法计算器：
    如：
        content  =  input('请输入内容：')    #  如：  5+9  或  5+  9  或  5  +  9  
4、计算用户输入的内容中有几个十进制小数？几个字母？
    如：
        content  =  input('请输入内容：')    #  如：asduiaf878123jkjsfd-­‐213928  
5、制作趣味模板程序
    需求：等待用户输入名字、地点、爱好，根据用户的名字和爱好进行任意现实
    如：敬爱可亲的 xxx，最喜欢在 xxx 地方干 xxx
6、制作随机验证码，不区分大小写。
    流程：
        -­‐  用户执行程序
        -­‐  给用户显示需要输入的验证码
        -­‐  用户输入的值
            用户输入的值和显示的值相同时现实正确信息；否则继续生成随机验证码继续等待用户输入
        生成随机验证码代码示例：
            
7、开发敏感词语过滤程序，提示用户输入内容，如果用户输入的内容中包含特殊的字符：
    如  "苍老师"  "东京热"，则将内容替换为  ***
8、制作表格  
    循环提示用户输入：用户名、密码、邮箱  （要求用户输入的长度不超过 20 个字符，如果超过则只有前 20 个字符有效）
    如果用户输入  q 或 Q  表示不再继续输入，将用户输入的内容以表格形式打印
'''


def check_code():
    import random
    checkcode = ''
    for i in range(4):
        current = random.randrange(0, 4)
        if current != i:
            temp = chr(random.randint(65, 90))
        else:
            temp = random.randint(0, 9)
        checkcode += str(temp)
    return checkcode


def func():
    # name = "  aleX"
    # name = name.strip()
    # print("  a: %s" % name)
    # if name.startswith("aL"):
    #     print("  b:", True)
    # else:
    #     print("  b:", False)
    # if name.endswith("X"):
    #     print("  c:", True)
    # else:
    #     print("  c:", False)
    # print("  d: %s" % name.replace("l", "p"))
    # print("  e:", end=" ")
    # print(name.split("l"))
    # print("  f:", end=" ")
    # print(type(name.split("l")))
    # print("  g:%s:" % name.upper())
    # print("  h:%s:" % name.lower())
    # print("  i:%s" % name[1])
    # print("  j:%s" % name[:3])
    # print("  k:%s" % name[-2:])
    # print("  l:%d" % name.index("e"))
    # print("  m:%s" % name[:-1])
    # print("------end question1-----------------")

    # li1 = "alexericrain"
    # li2 = ['alex', 'eric', 'rain']
    # print("  a:%s" % ("_".join(li1)))
    # print("  b:%s" % ("_".join(li2)))
    # print("------end question2-----------------")

    # content = input('请输入内容：')
    # content = re.split("\+", content)
    # print("%d" % (int(content[0].strip()) + int(content[1].strip())))
    # print("------end question3-----------------")

    # numn = 0
    # strn = 0
    # content = input('请输入内容：')
    # for i in content:
    #     if i.isalpha():
    #         strn += 1
    #     elif i.isdigit():
    #         numn += 1
    # print("str num is %d,dig num is %d" % (strn, numn))
    # print("------end question4-----------------")

    # inp_n = input("请输入名字:")
    # inp_a = input("请输入地点:")
    # inp_h = input("请输入爱好:")
    # print("敬爱可亲的%s，最喜欢在%s地方干%s." %(inp_n, inp_a, inp_h))
    # print("------end question5-----------------")

    # while True:
    #     rancode = check_code()
    #     print(rancode)
    #     inp_code = input("请输入验证码:")
    #     if inp_code.lower() == rancode.lower():
    #         break
    # print("------end question6-----------------")

    # inp_str = input("请输入信息:")
    # inp_str = re.sub("苍井空|武藤兰|东京热", "***", inp_str)
    # print("输出信息为:%s" % inp_str)
    # print("------end question7-----------------")

    # while True:
    #     inp_n = input("请输入用户名:")[0:19]
    #     inp_p = input("请输入密码:")[0:19]
    #     inp_e = input("请输入邮箱:")[0:19]
    #     if inp_n.lower() == 'q' or inp_p.lower() == 'q' or inp_e.lower() == 'q':
    #         break
    #     print("%-10s %-10s %-10s" % ("name", "password", "email"))
    #     print("%-10s %-10s %-10s" % (inp_n, inp_p, inp_e))
    # print("------end question8-----------------")


if __name__ == "__main__":
    func()
