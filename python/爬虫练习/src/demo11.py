#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/10  23:30

# CSDN博客首页所有的文章爬取

from urllib import request
from urllib import error
import re
import os
import random
import threading

filepath = os.path.abspath(__file__)
filedir = os.path.dirname(filepath)
loadpath = os.path.join(os.path.dirname(filedir), "file\\csdn博客\\").replace("\\", '/')

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


def download_html(index, url):
    try:
        request.urlretrieve(url, loadpath + "{}.html".format(index))
        print("当前下载第{}篇博文".format(index))
    except error.URLError as e:
        print("下载第{}篇博文出错...".format(i), error)


def get_url(url):
    opener = request.build_opener()
    headers = ("User-Agent", random.choice(useragent))
    opener.addheaders = [headers]

    try:
        data = opener.open(url).read().decode("utf-8")
        print(len(data))
    except error.URLError as e:
        print("error", e)

    pat = '<h2>.*?<a href="(.*?)" target="_blank".*?data-report-'
    res = re.compile(pat, re.S).findall(data)
    print("共%d篇博文" % len(res))

    for i in range(len(res)):
        t = threading.Thread(target=download_html, args=(i, res[i]))
        t.start()
        # t.join()

    print("下载完毕...")


if __name__ == "__main__":
    # print(loadpath)
    url = "https://blog.csdn.net"
    get_url(url)