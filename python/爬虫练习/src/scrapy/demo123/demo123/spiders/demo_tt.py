# -*- coding: utf-8 -*-
import scrapy
from demo123.items import DdItem
from scrapy.http import Request

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
        item["img_url"] = response.xpath('//a[@dd_name="单品图片"]/img/@data-original').extract()

        # print(item["title"])
        # print(item["link"])
        # print(item["comment"])
        yield item

        for i in range(2, 5):
            try:
                url = "http://category.dangdang.com/pg{}-cid4008149.html".format(i)
                yield Request(url=url, callback=self.parse)
            except Exception as e:
                print(e)
                continue
