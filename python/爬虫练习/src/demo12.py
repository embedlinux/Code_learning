#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/11  10:58


# 糗事百科段子爬虫

from urllib import request
# from urllib import error
import re
import os
import random
# import threading

filepath = os.path.abspath(__file__)
filedir = os.path.dirname(filepath)
loadpath = os.path.join(os.path.dirname(filedir), "file\\糗事百科段子\\").replace("\\", '/')

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


def get_url(index, url):
    opener = request.build_opener()
    headers = ("User-Agent", random.choice(useragent))
    opener.addheaders = [headers]
    request.install_opener(opener)          # 将opener安装为全局

    data = opener.open(url).read().decode("utf-8", "ignore")
    # print(len(data))

    pat = '<div class="content">.*?<span>(.*?)</span>.*?</div>'
    res = re.compile(pat, re.S).findall(data)
    filename = loadpath + "{index}.txt".format(index=index)
    print("----------下载第{}页段子".format(index))
    with open(filename, mode="w+", encoding="utf-8") as f:
        for i in res:
            inew = re.sub("\n|<br/>", "", i)
            f.write(inew + "\n")


if __name__ == "__main__":
    for i in range(1, 6):                   # 爬取前五页的段子
        url = "https://www.qiushibaike.com/text/page/{}/".format(i)
        get_url(i, url)
        # print(url)