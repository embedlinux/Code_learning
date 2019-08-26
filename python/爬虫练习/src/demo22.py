#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/21  20:58
import requests
from lxml import etree

headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko)\
                Chrome/59.0.3071.115 Safari/537.36"

}
movies = []


# 爬取豆瓣电影
def get_html(url):
    response = requests.get(url=url, headers=headers)
    data = response.content.decode("utf-8", "ignore")
    # print(len(data))
    html = etree.HTML(data)
    ul_now = html.xpath('//ul[@class="lists"]')[0]
    # print(etree.tostring(ul_now, encoding="utf-8").decode("utf-8"))
    lis = ul_now.xpath('./li')
    for li in lis:
        title = li.xpath("@data-title")[0]
        score = li.xpath("@data-score")[0]
        region = li.xpath("@data-region")[0]
        imglink = li.xpath(".//img/@src")[0]
        # print(imglink)
        # print(etree.tostring(li, encoding="utf-8").decode("utf-8"))
        movie = {"title": title,
                 "score": score,
                 "region": region,
                 "imglink": imglink,
                 }
        movies.append(movie)
    print(movies)


if __name__ == "__main__":
    url = "https://movie.douban.com/cinema/nowplaying/suzhou/"
    data = get_html(url)
