#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/8/15  12:48

import socket

client = socket.socket
client.setblocking(False)     # 不阻塞

# connect    # 阻塞
# recv


# IO多路复用
#     检测多个socket是否已经发生变化（是否连接成功，是否可读/可写）
#     socket非阻塞

#   基于事件循环实现的异步非阻塞框架：Twisted
# 基于IO多路复用 + socket实现并发请求

# 解决并发：单线程+IO不等待
# 协程
#     https://www.cnblogs.com/wupeiqi/articles/5040827.html

# IO多路复用:
#   select: 最多1024个socket, 循环检测
#   poll::不限监听socket个数,循环检测
#   event:不限监听socket个数,回调方式
# IO模型:https://www.cnblogs.com/Eva-J/articles/8324837.html

# 提高并发方式
#   多线程
#   多进程
#   异步非阻塞模块(Twisted) scrapy 框架(单线程完成)

# 异步非阻塞
#   非阻塞--不等待
#   异步--通知， 执行完成后，自动执行回调函数，或自动执行某些操作

# 同步阻塞
#   阻塞--等
#   同步--顺序逐步执行

# 协程：Greenlet(协程), gevent(依赖greenlet, 遇到IO就切换)
#   微线程,对一个线程进程分片,使得线程在代码块之间进行来回切换执行,而不是原来逐行执行.
#   https://www.cnblogs.com/Eva-J/articles/8324673.html
# 协程 + 遇到IO就切换, 提高性能
#  gevent.monkey.patch_all()   # 遇到IO自动切换


if __name__ == "__main__":
    pass

