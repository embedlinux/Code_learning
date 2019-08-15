#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/30  21:36
import socket


def main():
    ip_port = ('127.0.0.1', 8888)
    sock = socket.socket()
    sock.connect(ip_port)
    data = sock.recv(1024).decode("utf-8")
    print(data)


if __name__ == "__main__":
    main()