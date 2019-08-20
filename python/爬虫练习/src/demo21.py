#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/19  21:51
# xpath 和 lxml

# xpath（XML Path Language）是一门在XML和HTML文档中查找信息的语言，可用来在XML和HTML文档中对元素和属性进行遍历。

# lxml 是 一个HTML/XML的解析器，主要的功能是如何解析和提取 HTML/XML 数据。
# lxml和正则一样，也是用 C 实现的，是一款高性能的 Python HTML/XML 解析器，可以利用之前学习的XPath语法，
#   来快速的定位特定元素以及节点信息。
from lxml import etree

# 1.获取所有li标签：
html = etree.parse('hello.html')
print type(html)  # 显示etree.parse() 返回类型

result = html.xpath('//li')
print(result)  # 打印<li>标签的元素集合

# 2.获取所有li元素下的所有class属性的值：
result = html.xpath('//li/@class')
print(result)

# 3.获取li标签下href为www.baidu.com的a标签：
result = html.xpath('//li/a[@href="www.baidu.com"]')
print(result)

# 4.获取li标签下所有span标签：
#result = html.xpath('//li/span')
#注意这么写是不对的：
#因为 / 是用来获取子元素的，而 <span> 并不是 <li> 的子元素，所以，要用双斜杠
result = html.xpath('//li//span')
print(result)

# 5.获取li标签下的a标签里的所有class：
result = html.xpath('//li/a//@class')
print(result)

# 6.获取最后一个li的a的href属性对应的值：
result = html.xpath('//li[last()]/a/@href')
# 谓语 [last()] 可以找到最后一个元素
print(result)

# 7.获取倒数第二个li元素的内容：
result = html.xpath('//li[last()-1]/a')
# text 方法可以获取元素内容
print(result[0].text)

# 8.获取倒数第二个li元素的内容的第二种方式：
result = html.xpath('//li[last()-1]/a/text()')
print(result)


if __name__ == "__main__":
    pass