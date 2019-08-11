#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/10  17:41
# 用户代理(添加报头的两种方式)
# 方式一:
#  1.构建opener
#  2.opener.addheader中添加headers(元组形式)
#  3.使用opener进行open请求,获取网页内容
# 方式二:
#  1.构建header字典
#  2.构建Request请求,req = Request(url, headers=headers)
#  3.urlopen获取网页内容, urlopen(req)

from urllib import request
import random


useragent = [
    "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) \
    Gecko/20100101 Firefox/52.0",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) \
    AppleWebKit/537.36 (KHTML, like Gecko) \
    hrome/59.0.3071.115 Safari/537.36",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) \
    AppleWebKit/537.36 (KHTML, like Gecko) \
    Chrome/51.0.2704.79 Safari/537.36 Edge/14.14393"
]


def get_url1(url):
    headers = ("User-Agent", random.choice(useragent))      # 构建headers,元组形式
    print(headers)
    opener = request.build_opener()                         # 构建opener
    opener.addheaders = [headers]                           # opener添加头
    data = opener.open(url).read().decode("utf-8")
    print(len(data))


if __name__ == "__main__":
    url = "http://blog.csdn.net"
    get_url1(url)