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
