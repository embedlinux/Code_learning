# -*- coding: utf-8 -*-
import scrapy
from demo123.items import BaiduItem
import re

# 百度新闻爬虫


class DemoSpider(scrapy.Spider):
    name = 'demo'
    allowed_domains = ['baidu.com']
    start_urls = ['http://news.baidu.com/widget?id=civilnews&ajax=json']

    # url_id = ['civilnews', 'InternationalNews', 'EnterNews', 'SportNews', 'FinanceNews',
    #           'TechNews', 'MilitaryNews', 'InternetNews', 'DiscoveryNews', 'LadyNews',
    #           'HealthNews', 'PicWall', 'LocalNews']
    url_id = ['civilnews', 'InternationalNews']

    def parse(self, response):
        for i in range(0, len(self.url_id)):
            this_url = "http://news.baidu.com/widget?id={}&ajax=json".format(self.url_id[i])
            print("当前爬取栏目:{}".format(self.url_id[i]))
            yield scrapy.http.Request(url=this_url, callback=self.next_parse)

    def next_parse(self, response):
        data = response.body.decode("utf-8", "ignore")
        pat_1 = '"m_url":"(.*?)"'
        pat_2 = '"url":"(.*?)"'
        url1 = re.compile(pat_1, re.S).findall(data)
        url2 = re.compile(pat_2, re.S).findall(data)
        if len(url1) != 0:
            urls = url1
        else:
            urls = url2
        for url in urls:
            url = re.sub("\\\/", "/", url)
            if not url.startswith("http://baijiahao"):
                continue
            print(url)
            yield scrapy.http.Request(url=url, callback=self.download_html)

    def download_html(self, response):
        item = BaiduItem()
        item["link"] = response.url
        item["title"] = response.xpath("/html/head/title/text()").extract()
        item["content"] = response.body

        yield item

