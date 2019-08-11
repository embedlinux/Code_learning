#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/10  14:13

# POST 请求方式
from urllib import request
from urllib import parse


def get_url(url):
    # 1.构建表单,post请求数据
    dic = {"name": "alex",
           "pass": "happy123"}
    # 2.对请求表单进行编码
    postdata = parse.urlencode(dic).encode("utf-8")
    # 3.构建Request请求,POST
    req = request.Request(url, postdata, method="POST")
    # 4.urlopen,获取网页内容
    res = request.urlopen(req)
    print(res.info())
    print(res.read().decode("utf-8"))


if __name__ == "__main__":
    url = "https://www.iqianyue.com/mypost"
    get_url(url)