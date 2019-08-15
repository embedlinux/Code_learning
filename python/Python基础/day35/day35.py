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
# 基于IO多路复用 + socket实现并发请求

# 解决并发：单线程+IO不等待
# 协程
#     https://www.cnblogs.com/wupeiqi/articles/5040827.html


if __name__ == "__main__":
    pass
