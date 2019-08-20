#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/19  21:09

import requests


# 1. 最简单的发送get请求就是通过requests.get来调用：
def example1():
    response = requests.get("http://www.baidu.com/")
    print(type(response.content))
    print(response.content.decode("utf-8", "ignore"))


# 2. 添加headers和查询参数：
#   如果想添加 headers，可以传入headers参数来增加请求头中的headers信息。如果要将参数放在url中传递，可以利用 params 参数。
def example2():
    kw = {'wd': '中国'}
    headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) \
                Chrome/54.0.2840.99 Safari/537.36"}

    # params 接收一个字典或者字符串的查询参数，字典类型自动转换为url编码，不需要urlencode()
    response = requests.get("http://www.baidu.com/s", params=kw, headers=headers)

    # 查看响应内容，response.text 返回的是Unicode格式的数据
    print(response.text)

    # 查看响应内容，response.content返回的字节流数据
    print(response.content)

    # 查看完整url地址
    print(response.url)

    # 查看响应头部字符编码
    print(response.encoding)

    # 查看响应码
    print(response.status_code)


# 3. 发送POST请求：
def example3():
    # 最基本的POST请求可以使用post方法：
    # response = requests.post("http://www.baidu.com/")

    # 传入data数据：这时候就不要再使用urlencode进行编码了，直接传入一个字典进去就可以了。比如请求拉勾网的数据的代码：
    # url = "https://www.lagou.com/jobs/positionAjax.json?city=%E6%B7%B1%E5%9C%B3&needAddtionalResult=false&isSchoolJob=0"
    url = "https://www.lagou.com/jobs/list_python?labelWords=&fromSearch=true&suginput="
    headers = {
     'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) '
                   'Chrome/62.0.3202.94 Safari/537.36',
     'Referer': 'https://www.lagou.com/jobs/list_python?labelWords=&fromSearch=true&suginput='
    }

    data = {
     'first': 'true',
     'pn': 1,
     'kd': 'python'
    }

    resp = requests.post(url, headers=headers, data=data)
    # 如果是json数据，直接可以调用json方法
    print(resp.json())


# 4. 使用代理：只要在请求的方法中（比如get或者post）传递proxies参数就可以了。示例代码如下：
def example4():
    url = "http://httpbin.org/get"

    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) '
                      'Chrome/62.0.3202.94 Safari/537.36',
    }
    proxy = {
        'http': '183.129.207.86:11206'
    }
    resp = requests.get(url, headers=headers, proxies=proxy)
    # with open('xx.html', 'w', encoding='utf-8') as fp:
    #     fp.write(resp.text)
    print(resp.content)


# 5. cookie：如果在一个响应中包含了cookie，那么可以利用cookies属性拿到这个返回的cookie值：
def example5():
    url = "http://www.renren.com/PLogin.do"
    data = {"email":"970138074@qq.com",'password':"pythonspider"}
    resp = requests.get('http://www.baidu.com/')
    print(resp.cookies)
    print(resp.cookies.get_dict())


# 6. session：
# 之前使用urllib库，是可以使用opener发送多个请求，多个请求之间是可以共享cookie的。那么如果使用requests，也要达到共享cookie的目的，
# 那么可以使用requests库给我们提供的session对象。还是以登录人人网为例，使用requests来实现。示例代码如下：
def example6():
    url = "http://www.renren.com/PLogin.do"
    data = {"email": "2819412@qq.com", 'password': "123321123"}
    headers = {
        'User-Agent': "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) " \
                      "Chrome/62.0.3202.94 Safari/537.36"
    }

    # 登录
    session = requests.session()
    session.post(url, data=data, headers=headers)

    # 访问大鹏个人中心
    resp = session.get('http://www.renren.com/880151247/profile')
    # print(resp.text)

    with open('xx.html', 'w', encoding='utf-8') as fp:
        fp.write(resp.text)

# 7. 处理不信任的SSL证书：对于那些已经被信任的SSL整数的网站，比如https://www.baidu.com/，那么使用requests直接就可以正常的返回响应。
def example7():
    resp = requests.get('http://www.12306.cn/mormhweb/', verify=False)
    print(resp.content.decode('utf-8'))


if __name__ == "__main__":
    # example1()
    # example2()
    # example3()
    # example4()
    # example5()
    # example6()
    example7()