#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/10  22:25

# 网易新闻爬虫
# 1.爬取首页新闻链接
# 2.爬取新闻链接
# 3.寻找有没有frame,若有抓取frame下载对应网页内容,若没有,直接抓取当前页面
from urllib import request
from urllib import error
import re
import os

filepath = os.path.abspath(__file__)
filedir = os.path.dirname(filepath)
loadpath = os.path.join(os.path.dirname(filedir), "file\\网易新闻")


def get_url(url):
    try:
        data = request.urlopen(url).read().decode("GBK")
        # print(len(data))
        pat = '<ul class="top_news_ul">.*?<li><a href="(.*?)">.*?</a>|<a target="_blank" href="(.*?)">.*?</a></li>'
        res = re.compile(pat, re.S).findall(data)
        res = str(res)
        # print(res)

        pat2 = "'(http[s]?:.*?)'"
        res2 = re.compile(pat2).findall(res)
        # print(res2)
    except error.URLError as e:
        print(e)

    for i in range(len(res2)):
        try:
            request.urlretrieve(res2[i], "{loadpath}\\{index}.html".format(loadpath=loadpath, index=i))
        except error.URLError as e:
            print("load error", e)
            continue


if __name__ == "__main__":
    url = "https://news.163.com/"
    get_url(url)
    # print(loadpath)
