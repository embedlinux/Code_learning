#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/9/16  15:09
# 逆波兰表达式计算
# 中缀表达式转后缀表达式
import re


def get_listr(arg):
    return arg.split()


def is_opera(arg):
    return arg == "+" or arg == "-" or arg == "*" or arg == "/"


def is_bracket(arg):
    return arg == "(" or arg == ")"


def cal(opera, lis):
    num1 = lis.pop()
    num2 = lis.pop()
    if opera == "+":
        res = num2 + num1
    elif opera == "-":
        res = num2 - num1
    elif opera == "*":
        res = num2 * num1
    elif opera == "/":
        res = num2 / num1
    lis.append(float(res))
    return lis


# 分割字符串
def split_str(args):
    index = 0
    keepstr = ''
    ret = []
    # print(args)
    while index < len(args):
        # 是符号
        if is_opera(args[index]):
            ret.append(args[index])
        # 是数字或小数点
        elif args[index].isdigit() or args[index] == ".":
            keepstr += args[index]
            if index == len(str) - 1:
                ret.append(keepstr)
                break
            elif args[index+1].isdigit() or args[index+1] == ".":
                pass
            else:
                ret.append(keepstr)
                keepstr = ''
        # 空白符
        elif args[index].isspace():
            pass
        else:
            ret.append(args[index])
        index += 1
    return ret


# 判断符号优先级
def cmp_priority(arg):
    res = 0
    if arg == "+" or arg == "-":
        res = 1
    elif arg == "*" or arg == "/":
        res = 2
    return res


# 中缀表达式转后缀表达式
def trans_to_post(lis):
    # print(lis)
    stack_opera = []
    stack_temp = []
    for item in lis:
        # 是数字时
        # if item.isdigit():
        if re.match("\\d+[.]?\\d?", item):
            stack_temp.append(float(item))
        # 是操作符时
        elif is_opera(item):
            while True:
                if len(stack_opera) == 0 or stack_opera[-1] == "(":
                    stack_opera.append(item)
                    break
                elif cmp_priority(item) > cmp_priority(stack_opera[-1]):
                    stack_opera.append(item)
                    break
                else:
                    temp = stack_opera.pop()
                    stack_temp.append(temp)
        # 是括号时
        elif is_bracket(item):
            if item == "(":
                stack_opera.append(item)
            elif item == ")":
                while True:
                    temp = stack_opera.pop()
                    if temp == "(":
                        break
                    else:
                        stack_temp.append(temp)
    # print(stack_temp)
    while len(stack_opera) > 0:
        temp = stack_opera.pop()
        stack_temp.append(temp)
    # print(stack_temp)
    return stack_temp


# 计算后缀表达式结果
def cal_post(arg):
    print('计算后缀表达式', arg)
    cal_res = []
    for item in arg:
        if is_opera(item):
            cal_res = cal(item, cal_res)
        else:
            cal_res.append(float(item))
    print("%.2f" % cal_res[0])


if __name__ == "__main__":
    # (30+4)*5-6 ==> 3 4 + 5 * 6 -
    # 4*5-8+60+8/2 ==> 4 5 * 8 - 60 + 8 2 / +
    str = "4 5 * 8 - 60 + 8 2 / +"
    res = get_listr(str)
    # print(res)
    cal_post(res)
    print("--------------------")
    # str = "( 30 + 4 ) * 5 - 6 "
    str = "12.8 + (2-3.55)*4 + 10/5.0"
    # res = get_listr(str)
    res = split_str(str)
    # print(res)
    res_post = trans_to_post(res)
    # print(res_post)
    cal_post(res_post)






