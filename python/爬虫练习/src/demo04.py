#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/9  21:24

# ProxyHandler处理器,代理的使用

# 1.使用ProxyHandler,传入代理构建一个handler
# 2.使用handler构建一个opener
# 3.使用opener发送请求
from urllib import request

uapools = [
    "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.79 Safari/537.36 Edge/14.14393"
]


def get_ipproxy(url):
    handler = request.ProxyHandler({"http": "122.193.245.18:9999"})
    opener = request.build_opener(handler)
    resp = opener.open(url)
    print(resp.read())


if __name__ == "__main__":
    ipurl = "https://www.xicidaili.com/nn/"
    url = "http://httpbin.org/ip"
    get_ipproxy(url)


