# -*- coding: utf-8 -*-
import scrapy
import os
import urllib.request

# 模拟验证码登陆豆瓣爬虫
# 验证码处理的方式
#     1.半自动输入
#     2.接口处理
#     3.自动识别


class DemoDbSpider(scrapy.Spider):
    name = 'demo_db'
    allowed_domains = ['douban.com']
    # start_urls = ['http://douban.com/']
    headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) \
                                Gecko/20100101 Firefox/52.0",
                # "Referer": "https://accounts.douban.com/passport/login_popup?login_source=anony",
                "X-Requested-With": "XMLHttpRequest"
               }

    def start_requests(self):
        # pass
        # url = "https://accounts.douban.com/j/mobile/login/basic"
        url = "https://accounts.douban.com/passport/login"
        return [scrapy.http.Request(url=url, meta={"cookiejar": 1}, callback=self.parse, headers=self.headers)]

    def parse(self, response):
        data = {
                "ck": "",
                "name": "123456",
                "password": "xxxxxx",
                "remember": "false",
                "ticket": ""
                }
        # 判断是否有验证码
        captcha = response.xpath('//img[@id="captcha_image"]/@src').extract()
        if len(captcha) > 0:
            print("有验证码")
            localpath = os.path.dirname(os.path.abspath(__file__))
            urllib.request.urlretrieve(url=captcha[0], filename=captcha+"//" + "captcha.png")
            captcha_value = input("请输入验证码:")

        print("登录中...")
        url = "https://accounts.douban.com/j/mobile/login/basic"
        # return [scrapy.http.FormRequest.from_response(response,
        #                                               meta={"cookiejar": response.meta["cookiejar"]},
        #                                               headers=self.headers,
        #                                               formdata=data,
        #                                               callback=self.next)
        #     ]
        return [scrapy.http.FormRequest(url=url,
                                        meta={"cookiejar": 1},
                                        headers=self.headers,
                                        formdata=data,
                                        callback=self.next)
            ]

    def next(self, response):
        url = "https://www.douban.com/people/164762000/"
        print(response)
        # print(response.xpath("/html/head/title/text()").extract())
        yield scrapy.http.Request(url=url, callback=self.next2, headers=self.headers, meta={"cookiejar": True})

    def next2(self, response):
        print(response.xpath("/html/head/title/text()").extract())
