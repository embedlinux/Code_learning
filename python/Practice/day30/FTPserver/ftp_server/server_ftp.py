#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/30  21:26

import socketserver


class MyFTPServer(socketserver.BaseRequestHandler):
    def handle(self):
        print("当前连接客户端:{}".format(self.client_address))
        self.request.sendall(bytes("请输入命令:", "utf-8"))


if __name__ == "__main__":
    server = socketserver.ThreadingTCPServer(("127.0.0.1", 8888), MyFTPServer)
    # print(server.__dir__())
    server.serve_forever()
