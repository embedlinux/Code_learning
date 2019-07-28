#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/25  21:32

# https://www.cnblogs.com/Eva-J/articles/8244551.html

# 1 模拟ssh
# 2 黏包
#   接收端不知道发送端将要传送的字节流的长度，所以解决粘包的方法就是围绕，如何让发送端在发送数据前，
#   把自己将要发送的字节流总大小让接收端知晓，然后接收端来一个死循环接收完所有数据。
#   struct模块可以把一个类型，如数字，转成固定长度的bytes
# 3 文件上传 FTP

# 1 基于socketserver实现一个多用户上传下载功能
# 2 整理socketserver的流程图。
if __name__ == "__main__":
    pass

