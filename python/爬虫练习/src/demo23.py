#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/21  21:30

# 电影天堂爬虫
import requests
import random
import proxy_pools
from lxml import etree
import multiprocessing
import re

uapools = [
    "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) \
        Chrome/59.0.3071.115 Safari/537.36",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) \
        Chrome/51.0.2704.79 Safari/537.36 Edge/14.14393"
]
ipools = proxy_pools.ret_pools()
# print(ipools)


def prase_html(url, titles):
    header = {"User-Agent": random.choice(uapools)}
    ip = random.choice(ipools)
    res = requests.get(url, headers=header, proxies=ip).content.decode("gbk", "ignore")
    html = etree.HTML(res)
    img_link = html.xpath('//div[@class="co_content8"]//img/@src')[0]
    pat = "《(.*?)》"
    title = re.compile(pat).findall(titles)[0]
    print(title)
    print(img_link)


def get_html(url):
    header = {"User-Agent": random.choice(uapools)}
    ip = random.choice(ipools)
    # print(header)
    # print(ip)
    res = requests.get(url, headers=header, proxies=ip).content.decode("gbk", "ignore")
    html = etree.HTML(res)
    # print(res)
    # print(len(res))
    b_data = html.xpath('//div[@class="co_content8"]//table//b')
    # print(b_data)
    for i in b_data:
        href_li = i.xpath('./a[@class="ulink"]/@href')[1]
        title = i.xpath('./a[@class="ulink"]/@title')[0]
        href = "https://www.dy2018.com" + href_li
        # prase_html(href, title)
        # print(href)
        # print(title)
        p = multiprocessing.Process(target=prase_html, args=(href, title))
        p.start()


if __name__ == "__main__":
    # url = "https://www.dytt8.net"
    for i in range(1, 2):
        if i == 1:
            url = "https://www.dy2018.com/14/index.html"
        else:
            url = "https://www.dy2018.com/14/index_{}.html".format(i)
        # print(url)
        get_html(url)

