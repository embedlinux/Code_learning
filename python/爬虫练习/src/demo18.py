#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/14  22:23
# Urllib中使用XPath表达式

import urllib.request
import urllib.parse
from lxml import etree

if __name__ == "__main__":
    url = "http://www.baidu.com"
    data = urllib.request.urlopen(url=url).read().decode("utf-8", "ignore")
    treeDate = etree.HTML(data)
    print(treeDate.xpath("//title/text()"))