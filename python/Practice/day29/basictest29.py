#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/26  19:34


# 黏包的解决方式
# 客户端
# 1.打包
# ret=struct.pack("i",len(file_info_json))
# 2.发送 file_info_json的打包长度
# sock.send(ret)
# 3.发送 file_info_json字节串
# sock.send(file_info_json)
# 4.发送 文件数据

# 服务端
# 1.接收json的打包长度
# file_info_length_pack = conn.recv(4)
# file_info_length = struct.unpack("i", file_info_length_pack)[0]
#
# 2.接收json字符串
# file_info_json = conn.recv(file_info_length).decode("utf8")
# file_info = json.loads(file_info_json)
# 3.接收数据
if __name__ == "__main__":
    pass
