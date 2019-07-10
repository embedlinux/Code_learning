#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/10  22:32


# 作业需求
# 1、启动程序后，输入用户名密码后，如果是第一次登录，让用户输入工资，然后打印商品列表
# 2、允许用户根据商品编号购买商品
# 3、用户选择商品后，检测余额是否够，够就直接扣款，不够就提醒
# 4、可随时退出，退出时，打印已购买商品和余额
# 5、在用户使用过程中，关键输出，如余额，商品已加入购物车等消息，需高亮显示
# 6、用户下一次登录后，输入用户名密码，直接回到上次的状态，即上次消费的余额什么的还是那些，再次登录可继续购买
# 7、允许查询之前的消费记录

'''
用户信息组成格式
{
    "Name":username,
    "Passwd":password,
    "Balance":number,
    "Pur_goods":{"goods":[price|num]},
    "Cart_goods":{"goods":[price|num]}
}

文件中组成:username|password|number|{"goods":[price,num]}|{"goods":[price,num]}

商品信息
'''


# 用户登录
def login():
    user_info = []
    f = open("name/log_name.txt", "r+", encoding="utf-8")
    while True:
        user_name = input("请输入用户名:").strip()
        user_pass = input("请输入密码:").strip()
        for i in f.readlines():
            u_name = i.strip().split("|")[0]
            if u_name == user_name:
                if user_pass == i.strip().split("|")[1]:
                    user_info = i.strip().split("|")         # 用户信息列表
                    f.close()
                    return user_info
                else:
                    print("用户名或密码错误,请重新输入...")
                    f.seek(0)
                    break
        else:
            balance = input("请输入工资:").strip()
            user_info = "\n" + user_name + "|" + user_pass + "|" + balance
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
    f.close()
    return product


# 解析用户信息
def parse_user_info(*args):
    user_dic = {}
    if len(*args) == 3:                                     # 新建用户
        user_dic["Pur_goods"] = []
        user_dic["Cart_goods"] = []
    else:
        user_dic["Pur_goods"] = args[3]
        user_dic["Cart_goods"] = args[4]
    user_dic["Name"] = args[0]
    user_dic["Passwd"] = args[1]
    user_dic["Balance"] = args[2]

    return user_dic                                         # 返回用户信息


# 功能菜单
def func_list(**kwargs):
    func = ["P)已购买商品", "M)购物车商品", "T)添加商品到购物车", "Y)显示余额", "B)直接购买商品", "Q)退出购物商城"]
    for i in func:
        print("{}".format(i))
    while True:
        sec = input("请输入功能:").strip()
        if sec.lower() == "q":
            break


if __name__ == "__main__":
    name_info = []
    user_dic = {}
    p_list = {}
    name_info = login()                         # 用户登录
    p_list = list_product()                     # 输出商品信息
    user_dic = parse_user_info(*name_info)      # 解析用户信息
    func_list(**user_dic)                       # 功能选择
