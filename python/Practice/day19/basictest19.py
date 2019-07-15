#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/14  22:29

# 序列化模块
#   json: dumps,序列化   loads:反序列化
#   pickle
import json
import pickle
import os
import sys

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


def exe_file(f):
    file_list = []
    if os.path.isdir(f):
        file_list = os.listdir(f)
    else:
        file_list.append(os.path.abspath(f))
    for i in file_list:
        pass
        print(os.path.abspath(i))
        os.system("python %s" % os.path.join(os.path.abspath(f), i))


def copy_file(source, des):
    source_abs = os.path.abspath(source)
    des_abs = os.path.abspath(des)
    with open(source_abs, "r", encoding="utf-8") as f1, \
            open(des_abs, "w+", encoding="utf-8") as f2:
        for i in f1.readlines():
            f2.write(i)


def base_dir(f):
    file_dir = os.path.dirname(f)
    dir_dir = os.path.abspath(os.path.dirname(file_dir))
    print(dir_dir)


def make_files():
    os.makedirs("glance/api")
    os.makedirs("glance/cmd")
    os.makedirs("glance/db")
    open("glance/__init__.py", "w").close()
    open("glance/api/__init__.py", "w").close()
    open("glance/api/policy.py", "w").close()
    open("glance/api/versions.py", "w").close()
    open("glance/cmd/__init__.py", "w").close()
    open("glance/cmd/manage.py", "w").close()
    open("glance/db/__init__.py", "w").close()
    open("glance/db/models.py", "w").close()


def login_sys():
    cont_dic = {}
    while True:
        name = input("请输入用户名:").strip()
        passwd = input("请输入密码:").strip()
        f = open("glance/login/userinfo", "r+", encoding="utf-8")
        content = f.read()
        print(content)
        if len(content) == 0:
            cont_dic[name] = passwd
            json.dump(cont_dic, f)
            f.close()
            print("注册成功...")
        else:
            cont_dic = json.loads(content)
            print(cont_dic)
            if name in cont_dic:
                if passwd == cont_dic[name]:
                    print("登陆成功...")
                    f.close()
                else:
                    print("用户名或密码错误,请重新登录...")
                    continue
            else:
                cont_dic[name] = passwd
                f.seek(0)
                json.dump(cont_dic, f)
                f.close()
                print("注册成功...")
        return True


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


# 求目录大小,循环版本
def dir_size(dir):
    sum_size = 0
    dir_list = [os.path.abspath(dir)]
    print(dir_list)
    while dir_list:
        path = dir_list.pop()
        path_list = os.listdir(path)
        for i in path_list:
            abs_i = os.path.join(path, i)
            if os.path.isdir(abs_i):
                dir_list.append(abs_i)
            else:
                sum_size += os.path.getsize(abs_i)
    print(sum_size)


# 求目录大小,递归版本
def dir_size_re(dir):
    sum_size = 0
    dir_list = os.listdir(dir)
    for file in dir_list:
        abs_file = os.path.join(dir, file)
        if os.path.isdir(abs_file):
            sum_size += dir_size_re(abs_file)
        else:
            sum_size += os.path.getsize(abs_file)
    return sum_size


if __name__ == "__main__":
    # p_json()
    # p_pickle()
    # exe_file("../day01/basictest01.py")
    # copy_file("../day01/basictest01.py", "basictest01.py")
    # base_dir("../day01/basictest01.py")
    # make_files()
    # login_sys()
    dir_size("../")
    sum_size = dir_size_re("../")
    print(sum_size)