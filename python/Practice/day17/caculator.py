#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/13  23:36

import re

# 1.去掉多余空格，匹配()内只有公式的公式，计算替换计算结果
# 2.做原子乘除运算
# 3.筛选出原子公式，计算替换结果
# 4.格式化多余+-符号，匹配：+1 -2这样的数(做累加)
# 5.创建一个调用1 2 3的函数


# 去除所有的空白字符
def remove_blank_space(arg):
    st = re.sub("\s", '', arg)
    return st


# 原子操作,将负号合并
def format_sym(args):
    args = args.replace("+-", "-")
    args = args.replace("-+", "-")
    args = args.replace("--", "+")
    args = args.replace("++", "+")
    return args


# 解析括号并计算
def parse_barcket(args):
    while True:
        print(args)
        exp = re.search("\([^()]+\)", args)     #解析括号
        if exp:
            cal_exp = exp.group()
            cal_ret = cal(cal_exp)
            args = args.replace(cal_exp, cal_ret)
        else:
            return cal(args)


# 计算原子乘除
def cal(args):
    args = parse_mul_div(args)
    args = format_sym(args)
    return parse_add_sub(args)


# 原子乘除计算
def atom_mul_div(args):
    # print(args)
    if "*" in args:
        a, b = args.split("*")
        return str(float(a) * float(b))
    elif "/" in args:
        a, b = args.split("/")
        return str(float(a) / float(b))


def parse_add_sub(args):
    exp = re.findall("[+-]?\d+(?:\.\d+)?", args)
    exp_sum = 0
    for i in exp:
        exp_sum += float(i)
    return str(exp_sum)


# 解析所有的*和/运算
def parse_mul_div(args):
    while True:
        exp = re.search("\d+(\.\d+)?[*/]-?\d+(\.\d+)?", args)
        if exp:
            atmo_exp = exp.group()
            atmo_ret = atom_mul_div(atmo_exp)
            args = args.replace(atmo_exp, atmo_ret)
        else:
            return args


if __name__ == "__main__":
    s = '1 - 2 * ( (60-30 +(-40/5) * (9-2*5/3 + 7 /3*99/4*2998 +10 * 568/14 )) - (-4*3)/ (16-3*2) )'
    print(eval(s))
    s = remove_blank_space(s)
    ret = parse_barcket(s)
    print(ret)


