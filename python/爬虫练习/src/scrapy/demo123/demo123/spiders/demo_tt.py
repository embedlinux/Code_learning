# -*- coding: utf-8 -*-
import scrapy
from demo123.items import DdItem

# 当当网商品爬虫


class DemoTtSpider(scrapy.Spider):
    name = 'demo_tt'
    allowed_domains = ['dangdang.com']
    start_urls = ['http://category.dangdang.com/pg1-cid4008149.html']

    def parse(self, response):
        item = DdItem()
        item["title"] = response.xpath('//a[@name="itemlist-title"]/@title').extract()
        item["link"] = response.xpath('//a[@name="itemlist-title"]/@href').extract()
        item["comment"] = response.xpath('//a[@dd_name="单品评论"]/text()').extract()

        # print(item["title"])
        # print(item["link"])
        # print(item["comment"])
        yield item
