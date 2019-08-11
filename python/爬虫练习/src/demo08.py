#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/10  17:27
# HTTPError是URLError的子类,HTTPError有异常状态码与异常原因,URLError没有异常状态码
# 异常处理
# URLError出现的原因：
#   连不上服务器，
#   远程URL不存在，
#   无网络，
#   触发HTTPError
from urllib import request
from urllib import error


if __name__ == "__main__":
    # url = "http://blog.csdn.net"
    url = "https://www.taobao.com/"
    try:
        data = request.urlopen(url)
        print(data.getcode())
        print(data.info())
        print(data.read().decode("utf-8"))
    except error.URLError as e:
        if hasattr(e, "code"):
            print("error code:", e.code)
        if hasattr(e, "reason"):
            print("error reason:", e.reason)