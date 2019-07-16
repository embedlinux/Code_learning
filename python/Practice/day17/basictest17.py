#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/13  18:09

# re模块
import re


'''
# 查找
# findall : 匹配所有 每一项都是列表中的一个元素
# search : 只匹配从左到右的第一个,得到的不是直接的结果,而是一个变量,通过这个变量的group方法来获取结果
#   如果没有匹配到,会返回None,使用group会报错
# match 从头开始匹配,相当于search中的正则表达式加上一个^

# 字符串处理的扩展 : 替换 切割
# split     返回列表,按照正则规则切割,默认匹配到的内容会被切掉
# sub/subn  替换,按照正则规则去寻找要被替换掉的内容,subn返回元组,第二个值是替换的次数

# re模块的进阶 : 时间/空间
# compile 节省你使用正则表达式解决问题的时间
#   编译 正则表达式 编译成 字节码
#   在多次使用的过程中 不会多次编译
# finditer 返回一个迭代器,所有的结果都在这个迭代器中,需要通过循环+group的形式取值 能够节省内存

'''


if __name__ == "__main__":
    print(eval("1-2*((60-30+(-40/5)*(9-2*5/3+7/3*99/4*2998+10*568/14))-(-4*3)/(16-3*2))"))
    # 2776672.6952380957

    print(eval("1-2*-1388335.8476190479"))


    # print(e)