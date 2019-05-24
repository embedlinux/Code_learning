#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/5/19  23:39

#通过搜狗搜索，爬取微信公众号文章
import re
import random
import urllib.request as urlreq
import urllib.error as urlerr


uapools = [
    "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.79 Safari/537.36 Edge/14.14393"
]
ipools = []


def set_ua(ipool=None):
    thisua = random.choice(uapools)
    if ipool is not None:
        ip = random.choice(ipools)                    # 选择ip
        proxy = urlreq.ProxyHandler({"http": ip})     # 构建IP代理
        url_opender = urlreq.build_opener(proxy, urlreq.ProxyHandler)
        print("当前代理ip为：" + ip)
    else:
        url_opender = urlreq.build_opener()

    header = ("User-Agent", thisua)                   # 添加用户代理
    url_opender.addheaders = [header]

    urlreq.install_opener(url_opender)


def get_ipools(ipurl):
    set_ua()
    data = urlreq.urlopen(ipurl).read().decode("utf-8", "ignore")
    pat = "/></td>.*?<td>(.*?)</td>.*?<td>(.*?)</td>"
    ret = re.compile(pat, re.S).findall(data)
    for i in ret:
        ips = i[0] + ":" + i[1]
        ipools.append(ips)
    # return ipools


if __name__ == "__main__":
    ipurl = "https://www.xicidaili.com/nn/"
    get_ipools(ipurl)
    # print(ipools)