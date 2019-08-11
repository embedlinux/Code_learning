#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/9  23:12

from urllib import request
import re
import threading
#   request.urlretrieve()       # 直接下载网页到本地
#   request.urlcleanup()        # 清除缓存
#   info                        # 头文件信息
#   getcode                     # 状态码
#   geturl                      # 获取当前访问的网页的url
#   超时设置,timeout

# 自动模拟HTTP请求


def get_url(url):
    data = request.urlopen(url).read().decode("utf-8")
    pat = '{"title":"(.*?)","url":"http'
    res = re.compile(pat).findall(data)
    print(res)


if __name__ == "__main__":
    keyword = "Python"
    keyword = request.quote(keyword)                # 对url进行转码
    for i in range(0, 5):                           # 爬取前五页标题
        page = i * 10
        url = "http://www.baidu.com/s?wd={key}&pn={pn}".format(key=keyword, pn=page)
        t = threading.Thread(target=get_url, args=(url,))
        t.start()
        # print(url)
        # get_url(url)

