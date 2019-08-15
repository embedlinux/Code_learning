# -*- coding: utf-8 -*-
import scrapy
from demo123.items import JingDongItem
import urllib.request
import random
import re


class DemoJdSpider(scrapy.Spider):
    name = 'demo_jd'
    allowed_domains = ['jd.com']
    # start_urls = ['http://jd.com/']

    headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) \
            AppleWebKit/537.36 (KHTML, like Gecko) \
            Chrome/76.0.3809.100 Safari/537.36"
    }

    def start_requests(self):
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
        url = "https://book.jd.com/"
        req = urllib.request.Request(url=url)
        req.add_header("User-Agent", random.choice(useragent))
        alldata = urllib.request.urlopen(req).read().decode("utf-8", "ignore")
        print(len(alldata))
        # print(alldata)
        pat = '{"NAME":".*?","URL":"(.*?)","YFLAG":"1"},'
        allurl = re.compile(pat).findall(alldata)
        print("allurl", len(allurl))
        for i in allurl:
            thislink = re.sub("\\\/", "/", i)
            if "{" in thislink or "-" in thislink:
                continue
            print(thislink)
        #     req2 = urllib.request.Request(url=thislink)
        #     req2.add_header("User-Agent", random.choice(useragent))
        #     pdres = urllib.request.urlopen(req).read().decode("utf-8", "ignore")
        #     print(len(pdres))

    def parse(self, response):
        pass
