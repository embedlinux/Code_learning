#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/9/13  23:28

# 使用栈计算一个表达式


class Node(object):
    def __init__(self, value):
        self.value = value
        self.next = None


class MyStack(object):
    def __init__(self):
        self.size = 0
        self.lis = []

# 入栈
    def push(self, value):
        self.lis.append(value)
        self.size += 1
        return value

# 出栈
    def pop(self):
        if self.size == 0:
            print("栈空, 没有数据.")
            return
        value = self.lis.pop()
        self.size -= 1
        return value

# 栈的大小
    def get_size(self):
        return self.size

# 是否空栈
    def is_empty(self):
        if self.size == 0:
            return True
        else:
            return False

# 查看栈顶元素
    def get_pop(self):
        if self.is_empty():
            return None
        else:
            return self.lis[-1]

# 返回运算符的优先级
    @classmethod
    def priority(self, arg):
        if arg == "*" or arg == "/":
            return 1
        elif arg == "+" or arg == "-":
            return 0
        else:
            return -1

# 判断是否为操作符
    @classmethod
    def is_oper(self, args):
        return args == "+" or args == "-" or args == "*" or args == "/"

# 返回计算结果
    def cal(self, arg1, arg2, oper):
        ret = 0
        if oper == "+":
            ret = arg2 + arg1
        elif oper == "-":
            ret = arg2 - arg1
        elif oper == "*":
            ret = arg2 * arg1
        elif oper == "/":
            ret = arg2/arg1
        return ret


if __name__ == "__main__":
    # mystack = MyStack()
    # for i in range(6):
    #     value = mystack.push(i)
    #     print(value, end=' ')
    # print('\n')
    # size = mystack.get_size()
    # print(size)
    # for i in range(7):
    #     value = mystack.pop()
    #     print(value, end=' ')
    # size = mystack.get_size()
    # print(size)
    num_stack = MyStack()
    oper_stack = MyStack()
    str = '70+2*6-20'
    num1 = 0
    num2 = 0
    oper = 0
    res = 0
    ch = 0
    index = 0
    keepnum = '' # 拼接多位数
    while True:
        ch = str[index]
        if MyStack.is_oper(ch):               # 是否为符号
            if not oper_stack.is_empty():     # 符号栈是否为空
                # 符号栈的优先级与当前符号优先级比较
                if MyStack.priority(ch) <= oper_stack.priority(oper_stack.get_pop()):
                    num1 = num_stack.pop()
                    num2 = num_stack.pop()
                    oper = oper_stack.pop()
                    res = num_stack.cal(num1, num2, oper)
                    num_stack.push(res)
                    oper_stack.push(ch)
                else:
                    oper_stack.push(ch)  # 当前符号优先级大于符号栈优先级, 直接入栈
            else:
                # 如果栈为空
                oper_stack.push(ch)
        else:
            # 在处理数时,不能直接入栈
            # 拼接多位数
            keepnum += ch
            if index == len(str) - 1:
                num_stack.push(int(keepnum))
            else:
                # 判断索引后一位是否为数字,不是才入栈
                if MyStack.is_oper(str[index+1]):
                    num_stack.push(int(keepnum))
                    keepnum = ''
        index += 1
        if index >= len(str):
            break

    # 符号栈为空
    while True:
        if oper_stack.is_empty():
            break
        else:
            num1 = num_stack.pop()
            num2 = num_stack.pop()
            oper = oper_stack.pop()
            res = num_stack.cal(num1, num2, oper)
            num_stack.push(res)

    value = num_stack.pop()
    print("表达式结果:{}".format(value))




