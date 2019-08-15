#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/14  11:51

import random
import time


# random模块,随机数
# 时间相关的time模块
# os,os模块是与操作系统交互的一个接口
#     os.popen(),执行查看类操作    和 os.system(),执行命令操作
# sys,sys模块是与python解释器交互的一个接口    sys.argv
# 序列化模块
    # json
    # pickle
# collections模块  - 数据类型的扩展/面向对象进阶

# 1.验证码
# 2.发红包
# 3.计算时间差
#   例如, 用户输入2018-10-08 12:00:00 2018-10-08 14:30:00 输出2小时


def auth_code(num=6, alph=True):
    code = ""
    for i in range(num):
        code1 = str(random.randint(0, 9))
        if alph:
            code2 = chr(random.randint(65, 90))
            code3 = chr(random.randint(97, 122))
            code += random.choice([code1, code2, code3])
        else:
            code += code1
    return code


def send_enve(memory=200, nums=10):
    memory = memory*100
    send_m = random.sample(range(1, memory), nums-1)
    send_m.insert(0, 0)
    send_m.append(memory)
    send_m.sort()
    print(send_m)

    for i in range(nums):       # 为什么加起来等于200
        print((send_m[i+1] - send_m[i])/100, end=" ")
    print("")


def diff_time(f1_time, f2_time):
    srtuct_time1 = time.strptime(f1_time, "%Y-%m-%d %H:%M:%S")
    srtuct_time2 = time.strptime(f2_time, "%Y-%m-%d %H:%M:%S")
    tsamp1 = time.mktime(srtuct_time1)
    tsamp2 = time.mktime(srtuct_time2)
    dif_tsamp = tsamp2 - tsamp1
    struct_time = time.gmtime(dif_tsamp)
    print("过去了%d年%d月%d天%d小时%d分钟%d秒" % (struct_time.tm_year-1970, struct_time.tm_mon-1,
                                       struct_time.tm_mday-1, struct_time.tm_hour,
                                       struct_time.tm_min, struct_time.tm_sec))


if __name__ == "__main__":
    c1 = auth_code(4, False)
    c2 = auth_code(6, False)
    c3 = auth_code(6, True)
    print("{}  {}  {}".format(c1, c2, c3))
    print("---------------end question1-------------")

    send_enve()
    print("---------------end question2-------------")

    diff_time("2018-10-08 12:00:00", "2018-10-08 14:30:00")
    print("---------------end question3-------------")

