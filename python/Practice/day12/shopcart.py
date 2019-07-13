#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/10  22:32

import os


# 作业需求
# 1、启动程序后，输入用户名密码后，如果是第一次登录，让用户输入工资，然后打印商品列表
# 2、允许用户根据商品编号购买商品
# 3、用户选择商品后，检测余额是否够，够就直接扣款，不够就提醒
# 4、可随时退出，退出时，打印已购买商品和余额
# 5、在用户使用过程中，关键输出，如余额，商品已加入购物车等消息，需高亮显示
# 6、用户下一次登录后，输入用户名密码，直接回到上次的状态，即上次消费的余额什么的还是那些，再次登录可继续购买
# 7、允许查询之前的消费记录
# Note:输入商品信息后，可以输入需要购买商品的序号


'''
用户信息组成格式
{
    "Name":username,
    "Passwd":password,
    "Balance":number,
    "Pur_goods":{"goods":price,"goods":price},
    "Cart_goods":{"goods":price,"goods":price}
}

文件中组成:username|password|number|{"goods":price,"goods":price,"goods":price...}|{"goods":price,"goods":price...}

商品信息
'''

user_dic = {}                           # 用户信息，全局变量


# 用户登录
def login():
    user_info = []
    f = open("name/login_name.txt", "r+", encoding="UTF-8-sig")
    while True:
        user_name = input("请输入用户名:").strip()
        user_pass = input("请输入密码:").strip()
        for i in f.readlines():
            # print(i.strip().split("|"))
            u_name = i.strip().split("|")[0]
            # print(user_name == i.strip().split("|")[0])
            # print(u_name, user_name)
            # print(type(u_name), type(user_name))
            if u_name == user_name:
                print(user_pass == i.strip().split("|")[1])
                if user_pass == i.strip().split("|")[1]:
                    print("user_pass = {}".format(user_pass))
                    user_info = i.strip().split("|")             # 用户信息列表
                    f.close()
                    return user_info
                else:
                    print("用户名或密码错误,请重新输入...")
                    f.seek(0)
                    break
        else:
            balance = input("请输入工资:").strip()
            user_info = [user_name, user_pass, balance]
            f.close()
            return user_info


# 获取商品列表
def list_product():
    product = {}
    index = 1
    f = open("name/product.txt", "r", encoding="utf-8")
    print("---------当前出售商品-----------")
    print("%-5s %-5s %-5s" % ("Index", "Name", "Price"))
    for i in f.readlines():
        li = i.strip().split("|")
        product[li[0]] = li[1]
        print("%-5d %-3s %-3s" % (index, li[0], li[1]))
        index += 1
    print("------------------------------")
    f.close()
    return product


# 解析购物车和已购买商品,可以使用 eval()函数解析字符串
def parse_goods(args):
    dic = {}
    list_args = args.strip("{").strip("}").split(",")
    # print(list_args)
    for i in list_args:
        if i is not None:
            dic[i.split(":")[0].strip().strip("'")] = i.split(":")[1].strip().strip("'")
    print(dic)
    return dic


# 解析用户信息
def parse_user_info(*args):
    if len(args) == 3:                                     # 新建的用户
        user_dic["Pur_goods"] = {}
        user_dic["Cart_goods"] = {}
    else:
        user_dic["Pur_goods"] = parse_goods(args[3])
        user_dic["Cart_goods"] = parse_goods(args[4])
    user_dic["Name"] = args[0]
    user_dic["Passwd"] = args[1]
    user_dic["Balance"] = args[2]


# 保存当前用户信息到文本中
def save_info():
    with open("name/login_name.txt", "r", encoding="utf-8") as f1, \
            open("name/login_name2.txt", "w+", encoding="utf-8") as f2:
        for i in f1:
            if i.strip().split("|")[0] != user_dic["Name"]:
                f2.write(i)
        user_info = user_dic["Name"] + "|" + user_dic["Passwd"] + "|" + user_dic["Balance"] +"|" + \
                str(user_dic["Pur_goods"])+"|" + str(user_dic["Cart_goods"]) + "\n"
        f2.write(user_info)
    print(user_info)
    os.remove("name/login_name.txt")
    os.rename("name/login_name2.txt", "name/login_name.txt")


# 需要购买的商品
def b_product():
    p_dic = {}
    p_dic = list_product()
    b_name = input("请输入需要购买商品的序号：").strip()     # 获取需要购买的商品
    for i, product in enumerate(p_dic):
        # print("i = {}, prduct = {}".format(i, product))
        # print(user_dic["Balance"], p_dic[product])
        if int(b_name) == (i+1):
            if int(user_dic["Balance"]) > int(p_dic[product]):
                i_balance = 0
                i_balance = int(user_dic["Balance"]) - int(p_dic[product])
                user_dic["Balance"] = str(i_balance)
                user_dic["Pur_goods"][product] = p_dic[product]
            else:
                print("\033[1;31;30m余额不足\033[0m")
    print("\033[1;31;30m当前余额%s\033[0m"% user_dic["Balance"])


# 显示余额
def list_balance():
    print("\033[1;31;30m当前余额为； {}\033[0m".format(user_dic["Balance"]))


# 显示购物车中的商品
def list_shopchar():
    print("\033[1;31;30m当前购物车中的商品； {}\033[0m".format(user_dic["Cart_goods"]))


# 显示已购买的商品
def list_buygoods():
    print("\033[1;31;30m已经购买的商品； {}\033[0m".format(user_dic["Pur_goods"]))


# 添加商品到购物车
def add_goods():
    p_dic = {}
    p_dic = list_product()
    b_name = input("请输入需要加入商品的序号：").strip()     # 获取需要加到购物车的商品
    for i, product in enumerate(p_dic):
        # print(user_dic["Balance"], p_dic[product])
        if int(b_name) == (i+1):
            user_dic["Cart_goods"][product] = p_dic[product]


# 结算购物车中的商品
def bug_in_char():
    cha_memory = 0
    # user_dic["Cart_goods"]
    for i in user_dic["Cart_goods"]:
        # print(user_dic["Cart_goods"][i])
        cha_memory += int(user_dic["Cart_goods"][i])
    if int(user_dic["Balance"]) >= cha_memory:
        i_balance = 0
        i_balance = int(user_dic["Balance"]) - cha_memory
        user_dic["Balance"] = str(i_balance)
        for i in user_dic["Cart_goods"]:                # 添加商品到已购买
            user_dic["Pur_goods"][i] = user_dic["Cart_goods"][i]
        user_dic["Cart_goods"].clear()                  # 清空购物车中的商品
        print("\033[1;31;30m购买成功，当余额{}\033[0m".format(user_dic["Balance"]))
    else:
        print("\033[1;31;30m余额不足...,当前余额{}\033[0m".format(user_dic["Balance"]))


# 显示商城功能
def list_feature():
    print("-----------功能菜单------------")
    func = ["P)已经购买的商品", "M)购物车中的商品", "T)加商品到购物车",\
            "J)结算购物车商品", "Y)用户当前余额", "B)直接购买商品", "Q)退出购物商城"]
    for i in range(len(func)):
        if i % 2 == 1:
            print("{0:<16}".format(func[i], chr(12288)))
        else:
            print("{0:<16}".format(func[i], chr(12288)), end="")
    print('')


# 功能菜单
def func_list():
    while True:
        list_feature()
        sec = input("请输入功能:").strip()
        if sec.lower() == "q":
            save_info()
            return True
        elif sec.lower() == "b":
            b_product()
        elif sec.lower() == "y":
            list_balance()
        elif sec.lower() == "p":
            list_buygoods()
        elif sec.lower() == "m":
            list_shopchar()
        elif sec.lower() == "t":
            add_goods()
        elif sec.lower() == "j":
            bug_in_char()


if __name__ == "__main__":
    name_info = []
    p_list = {}
    name_info = login()                      # 用户登录
    p_list = list_product()                  # 输出商品信息
    parse_user_info(*name_info)              # 解析用户信息
    # print(user_dic)
    func_list()                              # 功能选择
