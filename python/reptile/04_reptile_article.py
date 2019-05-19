#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/5/18  21:31

#爬取CSDN博客首页所有的文章


import urllib.request as urlreq
import urllib.error as urlerr
import os
import re

repfilePath = os.path.abspath("../reptile_file/article_csdn/").replace("\\","/")


def download_article(article_list):
    article_list = list(set(article_list))
    for index in range(0, len(article_list)):
        link = article_list[index]
        try:
            print(link)
            down_file = repfilePath + "/" + str(index) + ".html"
            urlreq.urlretrieve(link, down_file)
        except urlreq.URLError as e:
            continue


def parase_html(data):
    pat = '<h2>\n\s*<a href="(.*?)" target="_blank"'
    article_list = re.compile(pat).findall(data)
    # print(article_list)
    download_article(article_list)

def get_html(urlweb):
    try:
        headers = ("User-Agent","Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36")
        urlopener = urlreq.build_opener()
        urlopener.addheaders = [headers]
        # 安装为全局变量
        urlreq.install_opener(urlopener)
        data = urlopener.open(urlweb).read().decode("utf-8", "ignore")
    except urlerr.URLError as e:
        print(e)

    parase_html(data)


if __name__ == "__main__":
    urlweb = "http://blog.csdn.net"
    get_html(urlweb)
    # print(repfilePath)