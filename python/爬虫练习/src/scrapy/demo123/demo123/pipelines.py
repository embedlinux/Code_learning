# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html


class Demo123Pipeline(object):
    def process_item(self, item, spider):
        return item


class DdPipeline(object):
    def process_item(self, item, spider):
        for i in range(0, len(item["title"])):
            title = item["title"][i]
            link = item["link"][i]
            comment = item["comment"][i]
            print("title:{},line:{},comment:{}".format(title, link, comment))
        return item

