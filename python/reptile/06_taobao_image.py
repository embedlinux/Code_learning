#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/5/19  18:52
#通过关键词爬取淘宝的图片,UA验证，需要登录验证？？？



import urllib.request as urlreq
import urllib.error as urlerror
import re
import random
import time
import os


uapools =[
    "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.79 Safari/537.36 Edge/14.14393"
]
repfilePath = os.path.abspath("../reptile_file/taobao_image/").replace("\\","/")


def download_imgae(weburl):
    # print(weburl)
    data = urlreq.urlopen(weburl).read().decode("utf-8", "ignore")
    print(data)
    pat = '"pic_url":"//(.*?)"'
    ret = re.compile(pat).findall(data)
    print(ret)
    for i in range(len(ret)):
        thisimage = "https://" + ret[i]
        localtime = time.strftime('%H-%M-%S', time.localtime(time.time()))
        imagepath = repfilePath + "/" + localtime + "_" + i + ".jpg"
        urlreq.urlretrieve(thisimage, imagepath)


def ua(uapools):
    thisua = random.choice(uapools)
    headers = ("User-Agent", thisua)
    url_opener = urlreq.build_opener()
    url_opener.addheaders = [headers]
    urlreq.install_opener(url_opener)


def get_html(weburl):
    # print(weburl)
    for i in range(0, 1): #爬取5页照片
        try:
            ua(uapools)
            weburl = weburl + "&s=" + str(i*44)
            download_imgae(weburl)
            # print(weburl)
        except urlerror.URLError as e:
            prin("爬取第%d页出错"%i)



if __name__ == "__main__":
    keyword = r"连衣裙"
    keyword = urlreq.quote(keyword)
    url = "https://s.taobao.com/search?q=" + keyword
    get_html(url)




