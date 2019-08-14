# -*- coding: utf-8 -*-
import scrapy

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
                "Referer": "https://accounts.douban.com/passport/login",
                "X-Requested-With": "XMLHttpRequest"
               }

    def start_requests(self):
        # url = "https://accounts.douban.com/j/mobile/login/basic"
        url = "https://accounts.douban.com/passport/login"
        return [scrapy.http.Request(url=url, meta={"cookiejar": 1}, callback=self.parse, headers=self.headers)]

    def parse(self, response):
        # 判断是否有验证码

        data = {
                "ck": "",
                "name": "18852863339",
                "password": "wq123456",
                "remember": "false",
                "ticket": ""
                }
        print("登录中...")
        url = "https://accounts.douban.com/j/mobile/login/basic"
        # return [scrapy.http.FormRequest.from_response(response,
        #                                               meta={"cookiejar": response.meta["cookiejar"]},
        #                                               headers=self.headers,
        #                                               formdata=data,
        #                                               callback=self.next)
        #     ]
        return [scrapy.http.FormRequest(url=url,
                                        meta={"cookiejar": response.meta["cookiejar"]},
                                        headers=self.headers,
                                        formdata=data,
                                        callback=self.next)
            ]

    def next(self, response):
        # url = "http://edu.iqianyue.com/index_user_index.html"
        print(response)
        print(response.xpath("/html/head/title/text()").extract())
        # yield scrapy.http.Request(url=url, callback=self.next2, meta={"cookiejar": True})

    def next2(self, response):
        print(response.xpath("/html/head/title/text()").extract())
