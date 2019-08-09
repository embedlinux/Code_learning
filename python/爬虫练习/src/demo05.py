#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/9  22:36

# 豆瓣出版社信息爬取
from urllib import request
import re
import os
filepath = os.path.abspath(__file__)
dirpath = os.path.abspath(os.path.dirname(filepath))
loadpath = os.path.join(os.path.dirname(dirpath), "file")
filename = os.path.join(os.path.abspath(loadpath), "出版社信息.txt")


def get_url(url):
    data = request.urlopen(url).read().decode("utf-8")
    pat = '<div class="name">(.*?)</div>'
    res = re.compile(pat).findall(data)
    with open(filename, "w+", encoding="utf-8") as f:
        for i in res:
            f.write(i+"\n")
    # print(res)


if __name__ == "__main__":
    url = "https://read.douban.com/provider/all"
    get_url(url)
    # print(filename)

