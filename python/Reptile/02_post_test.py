#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/5/17  21:53
# post 方法练习

import urllib.request as urlreq
import urllib.parse as urlparse


def get_html(reqweb):
    inputname = "123456"
    inputpass = "hello"
    postdata = urlparse.urlencode(
        {
            "name": inputname,
            "pass": inputpass
    }
    ).encode("utf-8")
    parsedata = urlreq.Request(reqweb, postdata)
    data = urlreq.urlopen(parsedata).read().decode("utf-8")
    print(data)


if __name__ == "__main__":
    reqweb =  "https://www.iqianyue.com/mypost"
    get_html(reqweb)