# -*- coding: utf-8 -*-
import scrapy


class DemoIqySpider(scrapy.Spider):
    name = 'demo_iqy'
    allowed_domains = ['iqianyue.com']
    start_urls = ['http://iqianyue.com/']
    headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) \
                                Gecko/20100101 Firefox/52.0"}

    def start_requests(self):
        url = "http://edu.iqianyue.com/index_user_login"
        return [scrapy.http.Request(url=url, meta={"cookiejar": 1}, callback=self.parse)]

    def parse(self, response):
        data = {"number": "yinyuye123",
                "passwd": "wq123456"
                }
        print("登录中...")
        return [scrapy.http.FormRequest.from_response(response,
                                                      meta={"cookiejar": response.meta["cookiejar"]},
                                                      headers=self.headers,
                                                      formdata=data,
                                                      callback=self.next)
            ]

    def next(self, response):
        url = "http://edu.iqianyue.com/index_user_index.html"
        print(response.xpath("/html/head/title/text()").extract())
        yield scrapy.http.Request(url=url, callback=self.next2, meta={"cookiejar": True})

    def next2(self, response):
        print(response.xpath("/html/head/title/text()").extract())
