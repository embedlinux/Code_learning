#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/11  11:35

# 用户代理池和IP代理池
# 用户代理池的构建方式
#     1.构建用户代理列表
#     2.随机选取一个用户代理,构建为元组, headers
#     3.构建opener,添加headers
#     4.将opener安装为全局
#     5.通过opener,请求url(使用open方法)
# IP代理池的构建方式
#     1.获取IP, 字典形式
#     2.通过ProxyHandler转换IP格式
#     3.构建opener.添加Proxy,request.build_opener(Proxy, request.HTTPHander)
#     4.将opener安装为全局
#     5.通过opener,请求url(使用open方法)

from urllib import parse
from urllib import request
from urllib import error
import random
import re
import os
import threading

filepath = os.path.abspath(__file__)
filedir = os.path.dirname(filepath)



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

ipools = []


def get_ipools(proxy_url):
    ua = ("User-Agent", random.choice(useragent))
    opener = request.build_opener()
    opener.addheaders = [ua]
    data = opener.open(proxy_url).read().decode("utf-8", "ignore")
    # print(len(data))

    # pat = 'alt="Cn" /></td>.*?<td>(.*?)</td>.*?<td>(.*?)</td>.*?<td>(HTTP[S]?)<td/>'
    pat = 'alt="Cn" /></td>.*?<td>(.*?)</td>.*?<td>(.*?)</td>.*?<td>.*?<td class="country">.*?</td>.*?<td>(\w*)</td>'
    res = re.compile(pat, re.S).findall(data)
    # print(res)
    for ip in res:
        dic = {}
        if len(ip) != 3:
            continue
        else:
            if "天" in ip[2]:
                continue
            else:
                dic[ip[2]] = ip[0] + ":" + ip[1]
                ipools.append(dic)
    # print(ipools)


def get_html(url):
    header = ("User-Agent", random.choice(useragent))               # 创建headers
    # print("当前使用Agent:", header)
    proxy = request.ProxyHandler(random.choice(ipools))             # 转换IP
    # print("当前使用ip:", proxy.proxies)
    opener = request.build_opener(proxy, request.ProxyHandler)      # 创建opener, 使用IP代理
    opener.addheaders = [header]                                    # 添加用户代理
    request.install_opener(opener)                                  # 安装为全局
    data = request.urlopen(url)
    # print(data.info())
    # print(data.getcode())
    pat = '&tlpid=(.*?)&refpid=" view-linkpid=".*?" data-spm="'
    link_pid = re.compile(pat).findall(data.read().decode("utf-8", "ignore"))
    # print("商品id:", link_pid)
    return link_pid[0]


def d_image(index, path):
    try:
        path = path.replace("\\", "")
        imagepath = loadpath + "{}.jpg".format(index)
        # print("图片地址:", path)
        # print(imagepath)
        request.urlretrieve(path, imagepath)
        print("当前爬取第{}张图片..".format(index))
    except error.URLError as e:
        print("爬取第{}张图片出错..".format(index))
        print(e.reason)
        return


def dowload_image(image_url):
    image_url = "https:" + image_url
    data = request.urlopen(image_url).read().decode("utf-8", "ignore")
    # print(len(data))
    pat = '"imgUrl":"(.*?)",'
    res = re.compile(pat).findall(data)
    # print(res)
    for index, path in enumerate(res):
        t = threading.Thread(target=d_image, args=(index, path))
        t.start()


if __name__ == "__main__":
    request.urlcleanup()
    proxy_url = "https://www.xicidaili.com/"
    get_ipools(proxy_url)                       # 获取IP池

    keyword = "古装美女"
    loadpath = os.path.join(os.path.dirname(filedir), "file\\淘宝图片\\{}\\".format(keyword)).replace("\\", '/')
    keyword = parse.quote(keyword)
    url = "https://uland.taobao.com/sem/tbsearch?keyword={}".format(keyword)
    # print(url)
    link_pid = get_html(url)
    print("商品pid为:", link_pid)
    image_url = '//odin.re.taobao.com/search_tbuad?_noSEC=true&keyword={keyword}&offset=&count=40&pid={pid}'.format(
        keyword=keyword,
        pid=link_pid
    )
    # print(image_url)
    dowload_image(image_url)

