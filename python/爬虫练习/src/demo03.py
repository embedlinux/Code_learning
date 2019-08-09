#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/9  20:56

# 泛见志段子爬取
from urllib import request
import re


def get_url():
    url = "http://www.fanjian.net/duanzi"
    headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) \
                                AppleWebKit/537.36 (KHTML, like Gecko) \
                                Chrome/76.0.3809.100 Safari/537.36",
               }
    req = request.Request(url, headers=headers)
    data = request.urlopen(req).read().decode("utf-8")
    pat = '<div class="cont-list-main">.*?<p>(.*?)</p>.*?</div>'
    rst = re.compile(pat, re.S).findall(data)
    for i in rst:
        print(i)
    # print(rst)


if __name__ == "__main__":
    get_url()
