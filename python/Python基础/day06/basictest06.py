#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/7  20:41

"""
    is 和 == 区别
        ==  比较俩边的值
        is  比较内存地址
        id()   ---- 获取内存地址
        小数据池:
            数字的小数据池范围是 -5 ~ 256
            字符串:
                字符串中不能包含特殊符号   + - * / @ 等等
                字符串单个字符*20以内内存地址都是一样的,单个字符*21以上内存地址不一致
        注意: pycharm是个坑, 一个py文件中所有相同的字符串 一般都是使用一样的内存地址(内部进行了优化)

    编码和解码
        encode(编码方式)    ---- 拿到明文编码后对应的字节
        decode(编码方式)    ---- 将编码后的字节解码成对应的明文

1,老男孩好声音选秀大赛评委在打分的时候，可以进行输入.假设,老男孩有10个评委.让10个评委进行打分，要求，分数必须大于5分,小于10分。

2，电影投票. 程序先给出一个目前正在上映的电影列表. 由用户给每一个电影投票. 最终，将该用户投票信息公布出来 。
要求：
    1，用户输入序号，进行投票。比如输入序号 1，给黄金兄弟投票1。
    2，每次投票成功，显示给哪部电影投票成功。
    3，退出投票程序后，要显示最终每个电影的投票数。

lst = ['黄金兄弟', '解救吾先生', '美国往事', '西西里的美丽传说'],
结果: {'黄金兄弟': 99, '解救吴先生': 80, '美国往事': 6, '西西里的美丽传说': 23}

3. 念数字  给出一个字典，在字典中标识出每个数字的发音.包括相关符号.然后由用户输入-一个数字，让程序读出相对应的发音。

4. 把列表中所有姓周的人的信息删掉:
lst = ['周老二', '周星星', '麻花藤', '周扒皮']
结果: lst = ['麻花藤']

5. 车牌区域划分, 现给出以下车牌. 根据车牌的信息, 分析出各省的车牌持有量.
cars = ['鲁A32444','鲁B12333','京B8989M','黑C49678','黑C46555','沪 B25041'.....]
locals = {'沪':'上海', '黑':'黑龙江', '鲁':'山东', '鄂':'湖北', '湘':'湖南', '京': '北京'.....}
结果: {'山东': 2, '北京': 1, '黑龙江': 2, '上海': 1}


6. 干掉主播. 现有如下主播收益信息: zhubo = {'卢本伟':522000, '冯提莫':189999, '金老板': 99999, '吴老板': 250000, 'alex': 126}
    1. 计算主播平均收益值
    2. 干掉收益小于平均值的主播
    3. 干掉卢本伟
"""


def func():
    # lst = ['黄金兄弟', '解救吾先生', '美国往事', '西西里的美丽传说']
    # dic2 = {}
    # while True:
    #     inp_num = input("投票电影的序号:").strip()
    #     if inp_num.lower() == 'q':
    #         print("退出投票...")
    #         break
    #     elif (int(inp_num)-1) not in range(0, 4):
    #         print("当前序号错误...")
    #     else:
    #         inp_value = input("投票分数:").strip()
    #         dic2[lst[int(inp_num)-1]] = int(inp_value)
    # print(dic2)
    # print("-----------------end question2--------------")

    # dic3 = {
    #     "-":"fu",
    #     ".":"dian",
    #     "0": "ling",
    #     "1": "yi",
    #     "2": "er",
    #     "3": "san",
    #     "4": "si",
    #     "5": "wu",
    #     "6": "liu",
    #     "7": "qi",
    #     "8": "ba",
    #     "9": "jiu",
    # }
    # while True:
    #     inp_num = input("输入数字:")
    #     if inp_num.lower() == 'q':
    #         print("退出输入...")
    #         break
    #     for i in inp_num:
    #         if i not in dic3:
    #             print("该数字不合法,请重新输入...")
    #             break
    #     else:
    #         for i in inp_num:
    #             print(dic3[i], end=" ")
    #         print("\n")
    # print("-----------------end question3--------------")

    lst4 = ['周老二', '周星星', '麻花藤', '周扒皮','周老二', '周星星', '麻花藤', '周扒皮']
    i = 0
    while i < len(lst4):
        if lst4[i].startswith("周"):
            lst4.pop(i)
            continue
        i += 1
    print(lst4)
    print("-----------------end question4--------------")

    cars5 = ['鲁A32444', '鲁B12333', '京B8989M', '黑C49678', '黑C46555', '沪B25041']
    locals5 = {'沪': '上海', '黑': '黑龙江', '鲁': '山东', '鄂': '湖北', '湘': '湖南', '京': '北京'}
    dic5 = {}
    for i in locals5.values():
        dic5.setdefault(i, 0)
    for i in cars5:
        dic5[locals5[i[0]]] += 1
    print(dic5)
    print("-----------------end question5--------------")

    zhubo = {'卢本伟': 522000, '冯提莫': 189999, '金老板': 99999, '吴老板': 250000, 'alex': 126}
    dic6 = {}
    all_m = 0
    avg_m = 0
    for i in zhubo:
        all_m += zhubo[i]
    avg_m = all_m // len(zhubo)
    print("all_m is {},all nums is {}, avg_m is {}".format(all_m, len(zhubo), avg_m))
    for i in zhubo:
        if zhubo[i] < avg_m:
            dic6[i] = zhubo[i]
    for i in dic6:
        del zhubo[i]
    del zhubo["卢本伟"]
    print(zhubo)
    print("-----------------end question6--------------")


if __name__ == "__main__":
    func()