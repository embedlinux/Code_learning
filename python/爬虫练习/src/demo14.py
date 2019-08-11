#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/11  17:29

# 微信文章爬取

import proxy_pools
from urllib import request
from urllib import parse
from urllib import error
import re
import random
import os

filepath = os.path.abspath(__file__)
filedir = os.path.dirname(filepath)
loadpath = os.path.join(os.path.dirname(filedir), "file\\微信文章\\").replace("\\", '/')


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


def get_url(url, ip_pools):
    proxy = request.ProxyHandler(random.choice(ip_pools))
    header = ("User-Agent", random.choice(useragent))

    opener = request.build_opener(proxy, request.ProxyHandler)
    opener.addheaders = [header]
    request.install_opener(opener)

    data = request.urlopen(url).read().decode("utf-8")
    # print(len(data))
    pat = 'data-share="(.*?)">.*?<em>'
    res = re.compile(pat).findall(data)
    # print(res)
    # print(len(res))
    for index, link in enumerate(res):
        link = link.replace("amp;", "")
        try:
            print("当前爬取第{}篇文章".format(index+1))
            # print(link)
            request.urlretrieve(link, loadpath + "{}.html".format(index+1))
        except error.URLError as e:
            print("爬取第{}篇文章文章出错".format(index+1))
            print(e.reason)
            continue


if __name__ == "__main__":
    ip_pools = proxy_pools.ret_pools()          # 获取IP池
    keyword = "Python"
    keyword = parse.quote(keyword)
    # print(ip_pools)

    # url = "https://weixin.sogou.com/weixin?type=2&s_from=input&query=Python&ie=utf8"
    url = "https://weixin.sogou.com/weixin?query={}&s_from=input&type=2&page=1&ie=utf8".format(keyword)

    get_url(url, ip_pools)
