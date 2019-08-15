#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/16  22:06
import re
import os
import sys
project_path = os.path.abspath(os.path.join(os.path.abspath(__file__), "../../"))
sys.path.append(project_path)
from config import settings

info_dic = {'name': 1, 'id': 0, 'age': 2, 'phone': 3, 'job': 4}
employee_file = settings.staff_info


def get_staff_info():
    with open(employee_file, "r", encoding="utf-8") as f:
        for line in f:
            line_lst = line.split(",")
            yield line_lst


def prase_view(view_list, ret_con):
    if "*" in view_list:
        view_list = info_dic.keys()
    for staff in ret_con:
        for i in view_list:
            i = i.strip()
            print(staff[info_dic[i]], end=" ")
        print("")


def prase_condition(arg):
    if ">" in arg:
        col, value = arg.split(">")
        col = col.strip()
        value = value.strip()
        g_info = get_staff_info()
        for info in g_info:
            if int(info[info_dic[col]]) > int(value):
                yield info
    elif "<" in arg:
        col, value = arg.split("<")
        col = col.strip()
        value = value.strip()
        g_info = get_staff_info()
        for info in g_info:
            if int(info[info_dic[col]]) < int(value):
                yield info
    elif "=" in arg:
        col, value = arg.split("=")
        col = col.strip()
        value = value.strip()
        g_info = get_staff_info()
        for info in g_info:
            if info[info_dic[col]] == value:
                yield info
    elif "like" in arg:
        col, value = arg.split("like")
        col = col.strip()
        value = value.strip()
        g_info = get_staff_info()
        for info in g_info:
            if value in info[info_dic[col]]:
                yield info


def paras_select(args):
    view, condition = args.split("where")
    # print(view)
    view = view.replace("select", "").strip()
    # print(view)
    ret_con = prase_condition(condition)    # 满足条件的数据
    view_list = view.split(",")
    prase_view(view_list, ret_con)          # 显示数据


def quit_sys():
    print("\033[1;31;30m退出系统...\033[0m")


def search_staff():
    search_list = ["select name, age where age>22", "select * where job=IT", "select * where phone like 133"]
    print("\033[1;31;30m查询员工信息...\033[0m")
    while True:
        search_info = input("请输出需要查找的内容:").strip()
        try:
            parase_select(search_info)
        except Exception as e:
            print("输入信息有误,请重新输入,当前支持的查询方式:")
            for i in search_list:
                print("  {}".format(i))


if __name__ == "__main__":
    args = "select * where phone like 133"
    paras_select(args)
