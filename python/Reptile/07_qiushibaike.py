#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/5/19  19:50

#使用ip代理池和用户代理池爬取糗事百科

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


def get_ua(uapools):
    thisua = random.choice(uapools)
    header = ("User-Agent", thisua)
    url_opener = urlreq.build_opener()
    url_opener.addheaders = [header]
    urlreq.install_opener(url_opener)


def get_ipools(ipurl):
    get_ua(uapools)
    data = urlreq.urlopen(ipurl).read().decode("utf-8","ignore")
    pat = "/></td>.*?<td>(.*?)</td>.*?<td>(.*?)</td>"
    ret = re.compile(pat, re.S).findall(data)
    # print(ret)
    for i in ret:
        ips = i[0] + ":" + i[1]
        ipools.append(ips)
    # print(ipools)
    return ipools


def get_article(data):
    pat = '<div class="content">.*?<span>(.*?)</span>.*?</div>'
    rst = re.compile(pat, re.S).findall(data)
    print(rst)
    # down_file(rst, i)


def get_html(urlweb):
    for i in range(1, 6):
        while 1:
            try:
                page = urlweb + str(i)
                thisua = random.choice(uapools)
                header = ("User-Agent", thisua)             #构建用户代理
                ip = random.choice(ipools)
                print("当前使用的ip为" + ip)
                proxy = urlreq.ProxyHandler({"http": ip})   #构建IP代理
                url_opener = urlreq.build_opener(proxy, urlreq.HTTPHandler)   #添加IP代理头
                url_opener.addheaders = [header]                              #添加用户代理头
                # get_ua(uapools)
                urlreq.install_opener(url_opener)                             #设为全局变量
                data = urlreq.urlopen(page).read().decode("utf-8","ignore")
            except Exception as e:
                print(e)
                ipools.remove(ip)
                continue
            get_article(data)
            break


if __name__ == "__main__":
    ipurl = "https://www.xicidaili.com/nn/"
    ipools = get_ipools(ipurl)        #获取ip池
    urlweb = "https://www.qiushibaike.com/text/page/"
    get_html(urlweb)




