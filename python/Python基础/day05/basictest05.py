#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/7  15:18
"""
1，有如下变量（tu是个元祖），请实现要求的功能

tu = ("alex", [11, 22, {"k1": 'v1', "k2": ["age", "name"], "k3": (11,22,33)}, 44])
    a. 讲述元祖的特性
    b. 请问tu变量中的第一个元素 "alex" 是否可被修改？     不可以
    c. 请问tu变量中的"k2"对应的值是什么类型？是否可以被修改？如果可以，请在其中添加一个元素 "Seven"
    d. 请问tu变量中的"k3"对应的值是什么类型？是否可以被修改？如果可以，请在其中添加一个元素 "Seven"   不可以

2， 字典dic,dic = {'k1': "v1", "k2": "v2", "k3": [11,22,33]}
    a.请循环输出所有的key
    b.请循环输出所有的value
    c.请循环输出所有的key和value
    d.请在字典中添加一个键值对，"k4": "v4"，输出添加后的字典
    e.请在修改字典中 "k1" 对应的值为 "alex"，输出修改后的字典
    f.请在k3对应的值中追加一个元素 44，输出修改后的字典
    g.请在k3对应的值的第 1 个位置插入个元素 18，输出修改后的字典

3，av_catalog = {
    "欧美":{
        "www.youporn.com": ["很多免费的,世界最大的","质量一般"],
        "www.pornhub.com": ["很多免费的,也很大","质量比yourporn高点"],
        "letmedothistoyou.com": ["多是自拍,高质量图片很多","资源不多,更新慢"],
        "x-art.com":["质量很高,真的很高","全部收费,屌丝请绕过"]
    },
    "日韩":{
        "tokyo-hot":["质量怎样不清楚,个人已经不喜欢日韩范了","verygood"]
    },
    "大陆":{
        "1024":["全部免费,真好,好人一生平安","服务器在国外,慢"]
    }
}
    a,给此[”很多免费的，世界最大的","质量-般"]列表第二个位置插入一个元素: '量很大’。
    b,将此["质量很高,真的很高","全部收费.属丝请绕过"]列表的"全部收费,屈丝请绕过”删除。
    c,在此["质量很高，真的很高","全部收费,属丝请绕过"]列表中添加"金老板最喜欢这个"。
    d,将此["质量怎样不清楚,个人已经不喜欢日韩范了","verygood"]列表的"verygood"全部变成大写
    e,给 '大陆' 对应的字典添加一个键值对 '1048' :['一天就封了']
    f,删除此"letmedothistoyou.com": ["多是自拍,高质量图片很多","资源不多,更新慢"]键值对。
    g,给此["全部免费,真好,好人一生平安","服务器在国外,慢"]列表的第一个元素，加上一句话：'可以爬下来'

4、有字符串"k:1|k1:2|k2:3|k3:4" 处理成字典 {'k':1,'k1':2....}

5、元素分类
有如下值li= [11,22,33,44,55,66,77,88,99,90]，将所有大于 66 的值保存至字典的第一个key中，将小于 66 的值保存至第二个key的值中。
即： {'k1': 大于66的所有值列表, 'k2': 小于66的所有值列表}

6、输出商品列表，用户输入序号，显示用户选中的商品

商品列表：
     goods = [{"name": "电脑", "price": 1999},
         {"name": "鼠标", "price": 10},
         {"name": "游艇", "price": 20},
         {"name": "美女", "price": 998}, ]
要求:
1：页面显示 序号 + 商品名称 + 商品价格，如：
              1 电脑 1999
              2 鼠标 10
             …
2：用户输入选择的商品序号，然后打印商品名称及商品价格
3：如果用户输入的商品序号有误，则提示输入有误，并重新输入。
4：用户输入Q或者q，退出程序。
"""


def func():
    # tu = ("alex", [11, 22, {"k1": 'v1', "k2": ["age", "name"], "k3": (11, 22, 33)}, 44])
    # tu[1][2]["k2"].append("Seven")
    # print("  c:{}".format(tu))
    # print("-----------------end question1------------------")

    # dic = {'k1': "v1", "k2": "v2", "k3": [11, 22, 33]}
    # print("a,b:")
    # for key, value in dic.items():
    #     print("  key={},value={}".format(key, value))
    # dic["k4"] = "v4"
    # print("d:{}".format(dic))
    # dic["k1"] = "alex"
    # print("e:{}".format(dic))
    # dic["k3"].append(44)
    # print("f:{}".format(dic))
    # dic["k3"].insert(0, 18)
    # print("g:{}".format(dic))
    # print("-----------------end question2------------------")

    # av_catalog = {
    #     "欧美": {
    #         "www.youporn.com": ["很多免费的,世界最大的", "质量一般"],
    #         "www.pornhub.com": ["很多免费的,也很大", "质量比yourporn高点"],
    #         "letmedothistoyou.com": ["多是自拍,高质量图片很多", "资源不多,更新慢"],
    #         "x-art.com": ["质量很高,真的很高", "全部收费,屌丝请绕过"]
    #     },
    #     "日韩": {
    #         "tokyo-hot": ["质量怎样不清楚,个人已经不喜欢日韩范了", "verygood"]
    #     },
    #     "大陆": {
    #         "1024": ["全部免费,真好,好人一生平安", "服务器在国外,慢"]
    #     }
    # }
    # av_catalog["欧美"]["www.youporn.com"].insert(1, "量很大")
    # del av_catalog["欧美"]["x-art.com"][1]
    # av_catalog["欧美"]["x-art.com"].append("金老板最喜欢这个")
    # av_catalog["日韩"]["tokyo-hot"][1] = av_catalog["日韩"]["tokyo-hot"][1].upper()
    # av_catalog["大陆"]["1048"] = ['一天就封了']
    # av_catalog["欧美"].pop("letmedothistoyou.com")
    # av_catalog["大陆"]["1024"][0] = av_catalog["大陆"]["1024"][0] + '可以爬下来'
    # print(av_catalog)
    # print("-----------------end question3------------------")

    str4 = "k:1|k1:2|k2:3|k3:4"
    list4 = str4.split("|")
    dic4 = {}
    for i in list4:
        key, value = i.split(":")
        dic4[key] = value
    print(dic4)
    print("-----------------end question4------------------")

    dic5 = {"k1": [], "k2": []}
    li = [11, 22, 33, 44, 55, 66, 77, 88, 99, 90]
    for i in li:
        if i >= 66:
            dic5["k1"].append(i)
        else:
            dic5["k2"].append(i)
    print(dic5)
    print("-----------------end question5------------------")

    goods = [{"name": "电脑", "price": 1999},
             {"name": "鼠标", "price": 10},
             {"name": "游艇", "price": 20},
             {"name": "美女", "price": 998},
             ]
    for i in range(len(goods)):
        print("{0}  {1}:{2}".format(i + 1, goods[i]["name"], goods[i]["price"]))
    while True:
        selec = input("输入选择的商品:").strip()
        if selec.lower() == "q":
            break
        if int(selec) not in range(0, 4):
            print("输入的商品序号有误,请重新输入...")
        else:
            print("选择的商品是: {}:{}".format(goods[int(selec)]["name"], goods[int(selec)]["price"]))
    print("-----------------end question6------------------")


if __name__ == "__main__":
    func()
