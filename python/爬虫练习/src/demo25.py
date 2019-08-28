#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/28  21:52

# 中国天气网,温度爬虫
import requests
from bs4 import BeautifulSoup
import random
from pyecharts.charts import Bar

uapools = [
    "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) \
        Chrome/59.0.3071.115 Safari/537.36",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) \
        Chrome/51.0.2704.79 Safari/537.36 Edge/14.14393"
]

all_data = []


def prase_html(url):
    header = {"User-Agent": random.choice(uapools)}
    data = requests.get(url, headers=header).content.decode("utf-8", "ignore")
    soup = BeautifulSoup(data, "html5lib")
    #
    conMindtab = soup.find("div", class_="conMidtab")
    tables = conMindtab.find_all("table")

    for table in tables:
        # print(table)
        trs = table.find_all("tr")[2:]
        for index, tr in enumerate(trs):
            # print(tr)
            tds = tr.find_all("td")
            if index == 0:
                city_td = tds[1]
            else:
                city_td = tds[0]
            city = list(city_td.stripped_strings)[0]
            temp_td = tds[-2]
            temp = list(temp_td.stripped_strings)[0]
            # print({"city": city, "min_temp": int(temp)})
            all_data.append({"city": city, "min_temp": int(temp)})
        # print("-----------------")


def get_html(url):
    header = {"User-Agent": random.choice(uapools)}
    data = requests.get(url, headers=header).content.decode("utf-8", "ignore")
    soup = BeautifulSoup(data, "lxml")

    uls = soup.find("ul", class_="lq_contentboxTab2")
    lis = uls.find_all("li")
    for index, li in enumerate(lis):
        url = li.select("a")[0]["href"]
        # print(li.select("a")[0]["href"])
        url = "http://www.weather.com.cn" + url
        print(url)
        prase_html(url)
        # if index == 7:
        #     prase_html(url)


if __name__ == "__main__":
    url = "http://www.weather.com.cn/textFC/hb.shtml"
    # url = "http://www.weather.com.cn/textFC/db.shtml"
    get_html(url)

    # 根据最低气温排序
    all_data.sort(key=lambda data:data["min_temp"])
    # for data in all_data:
        # print(data)
    chart = Bar()
    # cities = []
    # temps = []
    # for i in range(20):
    #     cities.append(all_data[i]["city"])
    #     temps.append((all_data[i]["min_temp"]))

    cities = list(map(lambda x: x["city"], all_data))

    temps = list(map(lambda x: x["min_temp"], all_data))
    print(cities[:20])
    print(temps[:20])
    # chart.set_global_opts(title_opts=)
    chart.add_xaxis(cities[:20])
    chart.add_yaxis("temps", temps[:20])
    # chart.add("", cities[:20], temps[:20])
    chart.render("chart.html")