#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/16  21:49

from core.funclist import *


def home():
    print("欢迎登陆HR人⼒资源管理系统")
    operate_list = ["查看员工信息","添加员工信息", "修改员工信息", "删除员工信息", "退出"]
    for index, item in enumerate(operate_list):
        print(index+1, item)

    while True:
        select_index = input("请选择你要做的操作:").strip()
        # 异常处理
        try:
            select_index = int(select_index)
            if select_index == 1:
                search_staff()
            elif select_index == 2:
                pass
            elif select_index == 3:
                pass
            elif select_index == 4:
                pass
            elif select_index == 5:
                quit_sys()
                break
            else:
                print("无此功能, 请重新输入..")
        except Exception as e:
            print("输入错误,请重新输入..")
            continue


if __name__ == "__main__":
    pass
