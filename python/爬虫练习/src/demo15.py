#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/11  20:45

# Fiddler抓包分析: https://blog.csdn.net/qq_36260310/article/details/77941469
# 腾讯视频评论抓包,Ajax异步请求数据
import proxy_pools
from urllib import request
from urllib import error
import re
import random
import os

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
    data = opener.open(url).read().decode("utf-8", "ignore")
    # print(url)
    # print(len(data))
    pat = 'title":"(.*?)","abstract".*?,"content":"(.*?)","type":"2",'
    res = re.compile(pat, re.S).findall(data)
    for item in res:
        # \033[1;31;30m当前余额%s\033[0m
        print("\033[1;31m评论标题\033[0m:"+eval('u"'+item[0]+'"'))
        print("\033[1;31m评论内容\033[0m:"+eval('u"'+item[1]+'"').replace('<span style="text-indent: 2em;">', ''))
        # print("评论标题:"+item[0])
        # print("评论内容:"+item[1])
    # print(res)

    cid_pat = 'last":"(.*?)","hasnext"'
    cid = re.compile(cid_pat).findall(data)
    return cid[0]


if __name__ == "__main__":
    ip_pools = proxy_pools.ret_pools()          # 获取IP池
    vid = "xpu952oo5tr9yzl"
    cid = "6560169753945103913"
    for i in range(3):
        url = "https://video.coral.qq.com/filmreviewr/c/upcomment/{vid}?&reqnum=5&source=132&commentid={cid}".format(
            vid=vid,
            cid=cid
        )
        # print(url)
        print("第{}页评论".format(i))
        cid = get_url(url, ip_pools)
