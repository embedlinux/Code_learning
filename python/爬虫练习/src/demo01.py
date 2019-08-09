#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/8  22:04

# urllib的简单使用
# from urllib import request
#     urlopen           打开网页
#     urlretrieve       下载网页
# from urllib import parse
#     urlencode          编码,可以对请求的url进行编码
#     parse_qs           解码,可以对编码后的url进行解码
#     urlparse/urlsplit  想要对这个url中的各个组成部分进行分割，那么这时候就可以使用urlparse或者是urlsplit来进行分割
# from urllib import request
#     Request            如果想要在请求的时候增加一些请求头，那么就必须使用request.Request类来实现。比如要增加一个User-Agent，



from urllib import request
from urllib import parse

enurl = "keyword=%E5%B0%8F%E7%8B%97%E5%90%B8%E5%B0%98%E5%99%A8&enc=utf-8&suggest=1.def.0.V09--12s0,20s0,38s0&wq=xiaogou&pvid=5b3e1afdc2b84880b1b4324876c33153"

url2 = "https://search.jd.com/Search?keyword=%E5%B0%8F%E7%8B%97%E5%90%B8%E5%B0%98%E5%99%A8&enc=utf-8&pvid=f37cff7dd18448c6864acede542b0290"


if __name__ == "__main__":
    url = "http://www.baidu.com"
    res = request.urlopen(url)
    # request.urlretrieve(url, "index.html")
    print(res.getcode())
    print(parse.parse_qs(url2))
    # print(res.__dir__())
    # print(res.read().decode("utf-8"))

    resu = parse.urlparse(url2)
    print("scheme:", resu.scheme)
    print("netloc:", resu.netloc)
    print("path:", resu.path)
    print("params:", resu.params)
    print("query:", resu.query)
    print("fragment:", resu.fragment)
    print("username:", resu.username)
    print("password:", resu.password)
    print("hostname:", resu.hostname)
    print("port:", resu.port)
    print("encode:", resu.encode)


# 'scheme', 'netloc', 'path', 'params', 'query', 'fragment','username', 'password', 'hostname', 'port', 'encode'
