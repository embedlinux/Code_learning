#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/9  19:58

# 爬取拉勾网, 反爬取技术很厉害

import os
from urllib import request
from urllib import parse

filepath = os.path.abspath(__file__)
basedir = os.path.dirname(os.path.dirname(filepath))
loadir = os.path.join(basedir, "file")
print(loadir)

url = "https://www.lagou.com/jobs/positionAjax.json?px=default&city=%E9%87%8D%E5%BA%86&needAddtionalResult=false"

headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) \
                            AppleWebKit/537.36 (KHTML, like Gecko) \
                            Chrome/76.0.3809.100 Safari/537.36",
           "Referer": "https://www.lagou.com/jobs/list_python?px=default&city=%E9%87%8D%E5%BA%86",
           "Host": "www.lagou.com",
           "X-Anit-Forge-Code": "0",
           "X-Anit-Forge-Token": "None",
           "X-Requested-With": "XMLHttpRequest"
           }
data = {
    "first": "true",
    "pn": 1,
    "kd": "python"
}


def get_url():
    req = request.Request(url, headers=headers, data=parse.urlencode(data).encode("utf-8"), method="POST")
    resq = request.urlopen(req)
    print(resq.read().decode("utf-8"))


if __name__ == "__main__":
    get_url()
