#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/5/18  20:31


import urllib.request as urlreq
import urllib.error as urlerr


def get_html(urlweb):
    try:
        data = urlreq.urlopen(urlweb).read()
        # print(data)
    except urlerr.URLError as e:
        if hasattr(e, "code"):
            print(e.code)
        if hasattr(e, "reason"):
            print(e.reason)
    print(data)


# 添加头
def opener_get_html(urlweb):
    headers = ("User-Agent","Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36")
    opener_url = urlreq.build_opener()
    opener_url.addheaders = [headers]
    data = opener_url.open(urlweb).read()
    print(data)


if __name__ == "__main__":
    urlweb = "https://weibo.com/"
    # get_html(urlweb)
    opener_get_html(urlweb)