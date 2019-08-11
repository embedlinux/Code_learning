#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/11  17:52


from urllib import request
import random
import re


useragent = [
    "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) \
    Gecko/20100101 Firefox/52.0",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) \
    AppleWebKit/537.36 (KHTML, like Gecko) \
    hrome/59.0.3071.115 Safari/537.36",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) \
    AppleWebKit/537.36 (KHTML, like Gecko) \
    Chrome/51.0.2704.79 Safari/537.36 Edge/14.14393"
]

ipools = []


def get_ipools(proxy_url):
    ua = ("User-Agent", random.choice(useragent))
    opener = request.build_opener()
    opener.addheaders = [ua]
    data = opener.open(proxy_url).read().decode("utf-8", "ignore")
    # print(len(data))

    # pat = 'alt="Cn" /></td>.*?<td>(.*?)</td>.*?<td>(.*?)</td>.*?<td>(HTTP[S]?)<td/>'
    pat = 'alt="Cn" /></td>.*?<td>(.*?)</td>.*?<td>(.*?)</td>.*?<td>.*?<td class="country">.*?</td>.*?<td>(\w*)</td>'
    res = re.compile(pat, re.S).findall(data)
    # print(res)
    for ip in res:
        dic = {}
        if len(ip) != 3:
            continue
        else:
            if "天" in ip[2]:
                continue
            else:
                dic[ip[2]] = ip[0] + ":" + ip[1]
                ipools.append(dic)
    # print(ipools)
    return ipools


def ret_pools():
    proxy_url = "https://www.xicidaili.com/"
    return get_ipools(proxy_url)  # 获取IP池


if __name__ == "__main__":
    ret_pools()