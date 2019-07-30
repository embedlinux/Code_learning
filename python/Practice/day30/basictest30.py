#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/7/29  18:48

# 网络编程
# 多线程
# socketserver
# FTP作业

'''
py2/py3区别
- 编码&字符串
    字符串：
        py2:    unicode         v = u"root"    本质上用unicode存储（万国码）
                (str/bytes)     v = "root"     本质用字节存储
        py3:    str    			v = "root"     本质上用unicode存储（万国码）
                bytes           v = b"root"    本质上用字节存储
    编码：
        py2:    - ascii
                文件头可以修改：#-*- encoding:utf-8 -*-
        py3:    - utf-8
                文件头可以修改：#-*- encoding:utf-8 -*-
        注意：文件是如何存储？
- 继承
    py2: 经典类/新式类
    py3: 新式类
- 范围
    py2：range/xrange
    py3:       range
- 输入
    py2: v1 = raw_input('请输入用户名:')
    py3: v2 = input('请输入用户名:')
- 打印
    py2: print 'xx'
    py3: print(123)

多线程
    socketserver
'''


if __name__ == "__main__":
    pass
