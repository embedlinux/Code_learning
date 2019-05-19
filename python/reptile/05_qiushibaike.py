#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/5/19  11:23

#爬取糗事百科的段子

import urllib.request as urlreq
import re
import urllib.error as urlerr
import os
import time

repfilePath = os.path.abspath("../reptile_file/qiushibaike/").replace("\\","/")


def down_file(rst, i):
    localtime = time.strftime('%Y-%m-%d', time.localtime(time.time()))
    filename = repfilePath + "/" + localtime + "_" + str(i) + ".txt"
    with open(filename, 'w', encoding='utf-8') as f:
        for j in rst:
            # print(j.strip())
            f.write(j.strip() + "\n\r")
    print("下载第%d页的段子"%i)


def get_html(urlweb):
    headers = ("User-Agent", "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36")
    open_hander = urlreq.build_opener()
    open_hander.addheaders = [headers]
    urlreq.install_opener(open_hander)
    for i in range(1, 6):
        try:
            page = urlweb + str(i)
            # print(page)
            data = urlreq.urlopen(page).read().decode("utf-8", "ignode")
            # print(data)
            pat = '<div class="content">.*?<span>(.*?)</span>.*?</div>'
            rst = re.compile(pat, re.S).findall(data)
            down_file(rst, i)
        except urlerr.URLError as e:
            continue


if __name__ == "__main__":
    urlweb = "https://www.qiushibaike.com/text/page/"
    get_html(urlweb)