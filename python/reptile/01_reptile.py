#!/usr/bin/env python
# -*- coding:utf-8 -*-


# 提取豆瓣出版社的信息

import urllib.request
import re
import os
import time

# filePath = os.path.abspath(__file__).replace("\\", "/")
repfilePath = os.path.abspath("../reptile_file").replace("\\", "/")


def store_file(rst):
    localtime = time.strftime('%Y-%m-%d-%H-%M-%S', time.localtime(time.time()))
    filename = repfilePath + "/" + localtime + ".txt"
    with open(filename, 'w', encoding='utf-8') as f:
        for i in rst:
            f.write(i + "\n")


def get_html(website):
    data = urllib.request.urlopen(website).read().decode("UTF-8")
    pat = r"""<div class="name">(.*?)</div><div class="works-num">"""
    rst = re.compile(pat).findall(data)
    # print(rst)
    store_file(rst)


if __name__ == "__main__":
    website = "https://read.douban.com/provider/all"
    get_html(website)






