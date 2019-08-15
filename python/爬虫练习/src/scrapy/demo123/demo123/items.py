# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class Demo123Item(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    pass


class DdItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    title = scrapy.Field()
    link = scrapy.Field()
    comment = scrapy.Field()
    img_url = scrapy.Field()


class BaiduItem(scrapy.Item):
    title = scrapy.Field()
    link = scrapy.Field()
    content = scrapy.Field()


class JingDongItem(scrapy.Item):
    pdnum = scrapy.Field()           # 频道号
    pdsubnum1 = scrapy.Field()       # 频道号1
    pdsubnum2 = scrapy.Field()       # 频道号2
    name = scrapy.Field()            # 图书名
    price = scrapy.Field()           # 价格
    comment = scrapy.Field()         # 评价数
    auther = scrapy.Field()          # 作者

