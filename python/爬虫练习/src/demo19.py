#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/18  19:04


# ProxyHandler处理器
#   1. 通过ProxyHandler建立handler,传入代理(字典)
#   2. 使用build_opener创建 opener
#   3. 使用Request请求网页

# handler = request.ProxyHandler({"http":"218.66.161.88:31769"})
# opener = request.build_opener(handler)
# req = request.Request("http://httpbin.org/ip")
# resp = opener.open(req)
# print(resp.read())


# cookie:
#     在网站中，http请求是无状态的。也就是说即使第一次和服务器连接后并且登录成功后，第二次请求服务器依然不能知道当前请求是哪个用户。
# cookie的出现就是为了解决这个问题，第一次登录后服务器返回一些数据（cookie）给浏览器，然后浏览器保存在本地，当该用户发送第二次请求的
# 时候，就会自动的把上次请求存储的cookie数据自动的携带给服务器，服务器通过浏览器携带的数据就能判断当前用户是哪个了。cookie存储的数据
# 量有限，不同的浏览器有不同的存储大小，但一般不超过4KB。因此使用cookie只能存储一些小量的数据。

#   格式:Set-Cookie: NAME=VALUE；Expires/Max-age=DATE；Path=PATH；Domain=DOMAIN_NAME；SECURE
# 参数意义：
#     NAME：cookie的名字。
#     VALUE：cookie的值。
#     Expires：cookie的过期时间。
#     Path：cookie作用的路径。
#     Domain：cookie作用的域名。
#     SECURE：是否只在https协议下起作用。

# cookie登录的两种解决方案
# 第一种是使用浏览器访问，然后将cookie信息复制下来，放到headers中。
# 第二种:在Python处理Cookie，一般是通过http.cookiejar模块和urllib模块的HTTPCookieProcessor处理器类一起使用。
#         http.cookiejar模块主要作用是提供用于存储cookie的对象。
#         HTTPCookieProcessor处理器主要作用是处理这些cookie对象，并构建handler对象。

# http.cookiejar模块：
#   该模块主要的类有CookieJar、FileCookieJar、MozillaCookieJar、LWPCookieJar。这四个类的作用分别如下：
#           CookieJar：管理HTTP cookie值、存储HTTP请求生成的cookie、向传出的HTTP请求添加cookie的对象。
#               整个cookie都存储在内存中，对CookieJar实例进行垃圾回收后cookie也将丢失。
#           FileCookieJar (filename,delayload=None,policy=None)：从CookieJar派生而来，用来创建FileCookieJar实例，
#               检索cookie信息并将cookie存储到文件中。filename是存储cookie的文件名。delayload为True时支持延迟访问访问文件，
#               即只有在需要时才读取文件或在文件中存储数据。
#           MozillaCookieJar (filename,delayload=None,policy=None)：从FileCookieJar派生而来，创建与Mozilla浏览器
#               cookies.txt兼容的FileCookieJar实例。
#           LWPCookieJar (filename,delayload=None,policy=None)：从FileCookieJar派生而来，创建与libwww-perl标准的
#               Set-Cookie3 文件格式兼容的FileCookieJar实例。
# from urllib import request
# from http.cookiejar import CookieJar
#       1. 登录
#         1.1 创建一个cookiejar对象                            cookiejar = CookieJar()
#         1.2 使用cookiejar创建一个HTTPCookieProcess对象       handler = request.HTTPCookieProcessor(cookiejar)
#         1.3 使用上一步创建的handler创建一个opener             opener = request.build_opener(handler)
#         1.4 使用opener发送登陆请求
#           req = request.Request(login_url, headers=headers, data=data)
#           opener.open(req)
#       2. 访问个人主页
#           req = request.Request(url, headers=headers)
#           resp = opener.open(req)

# 保存cookie到本地：可以使用cookiejar的save方法，并且需要指定一个文件名
# from urllib import request
# from http.cookiejar import MozillaCookieJar
#   1. 通过MozillaCookieJar创建一个cookiejar对象     cookiejar = MozillaCookieJar("cookie.txt")
#   2. 使用cookiejar创建一个HTTPCookieProcess对象    handler = request.HTTPCookieProcessor(cookiejar)
#   3. 使用上一步创建的handler创建一个opener          opener = request.build_opener(handler)
#   4. 使用opener发送登陆请求                        req = request.Request('http://httpbin.org/cookies',headers=headers)
#                                                   resp = opener.open(req)
#   5. 保存cookie                                   cookiejar.save(ignore_discard=True, ignore_expires=True)

# 从本地加载cookie：需要使用cookiejar的load方法，并且也需要指定方法
#       1. 通过MozillaCookieJar创建一个cookiejar对象      cookiejar = MozillaCookieJar("cookie.txt")
#       2. 通过cookiejar加载cookie                       cookiejar.load(ignore_expires=True,ignore_discard=True)
#       3. 使用cookiejar创建一个HTTPCookieProcess对象     handler = request.HTTPCookieProcessor(cookiejar)
#       4. 使用build_opener创建 opener                   opener = request.build_opener(handler)
#       5. Request请求            req = request.Request('http://httpbin.org/cookies',headers=headers) 发送Request请求


if __name__ == "__main__":
    pass
