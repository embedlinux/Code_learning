#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/14  22:29

# 序列化模块
#   json: dumps,序列化   loads:反序列化
#   pickle
import json
import pickle

'''
1.回顾文件递归遍历. 默写一遍.
    入口在： 当文件是个文件夹的时候
    出口在： 文件是一个文件
2.写一个函数，接收一个参数，如果是文件，就执行这个文件，如果是文件夹，就执行这个文件夹下的所有的py文件。
3.写一个copy函数，接受两个参数，第一个参数是源文件的位置，第二个参数是目标位置，将源文件copy到目标位置。
4.获取某个文件所在目录的上一级目录。
5.使用os模块创建如下目录结构
    # glance
    # ├── __init__.py
    # ├── api
    # │   ├── __init__.py
    # │   ├── policy.py
    # │   └── versions.py
    # ├── cmd
    # │   ├── __init__.py
    # │   └── manage.py
    # └── db
    #      ├── __init__.py
    #      └── models.py
6.写一个用户注册登陆的程序，每一个用户的注册都要把用户名和密码用字典的格式写入文件userinfo。在登陆的时候，再从文件中读取信息进行验证。
7.求解文件夹的大小：递归，函数（两种方法）
'''


def p_json():
    f = open("config_crc.json", "r", encoding="utf-8")
    dic = f.read()
    dic_c = json.loads(dic)
    for i in dic_c:
        print("{}:{}".format(i, dic_c[i]))
    f.close()

    f1 = open("config_crc_p.json", "wb")
    pickle.dump(dic_c, f1)
    f1.close()
    print("-----------end json-----------------")


def p_pickle():
    f = open("config_crc_p.json", "rb")
    dic = f.read()
    dic_c = pickle.loads(dic)
    for i in dic_c:
        print("{}:{}".format(i, dic_c[i]))
    f.close()
    print("-----------end pickle-----------------")


if __name__ == "__main__":
    p_json()
    p_pickle()
