#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/6  20:48

'''
1，有变量name = "aleX leNb" 完成如下操作：

1)  移除 name 变量对应的值两边的空格,并输出处理结果
2)  移除name变量左边的"al"并输出处理结果
3)  移除name变量右面的"Nb",并输出处理结果
4)  移除name变量开头的a"与最后的"b",并输出处理结果
5)  判断 name 变量是否以 "al" 开头,并输出结果
6)  判断name变量是否以"Nb"结尾,并输出结果
7)  将 name 变量对应的值中的 所有的"l" 替换为 "p",并输出结果
8)  将name变量对应的值中的第一个"l"替换成"p",并输出结果
9)  将 name 变量对应的值根据 所有的"l" 分割,并输出结果。
10) 将name变量对应的值根据第一个"l"分割,并输出结果。
11) 将 name 变量对应的值变大写,并输出结果
12) 将 name 变量对应的值变小写,并输出结果
13) 将name变量对应的值首字母"a"大写,并输出结果
14) 判断name变量对应的值字母"l"出现几次，并输出结果
15) 如果判断name变量对应的值前四位"l"出现几次,并输出结果
16) 从name变量对应的值中找到"N"对应的索引(如果找不到则报错)，并输出结果
17) 从name变量对应的值中找到"N"对应的索引(如果找不到则返回-1)输出结果
18) 从name变量对应的值中找到"X le"对应的索引,并输出结果
19) 请输出 name 变量对应的值的第 2 个字符?
20) 请输出 name 变量对应的值的前 3 个字符?
21) 请输出 name 变量对应的值的后 2 个字符?
22) 请输出 name 变量对应的值中 "e" 所在索引位置?

2，有字符串s = "123a4b5c"
    1)通过对s切片形成新的字符串s1,s1 = "123"
    2)通过对s切片形成新的字符串s2,s2 = "a4b"
    3)通过对s切片形成新的字符串s3,s3 = "1345"
    4)通过对s切片形成字符串s4,s4 = "2ab"
    5)通过对s切片形成字符串s5,s5 = "c"
    6)通过对s切片形成字符串s6,s6 = "ba2"

3，使用while和for循环分别打印字符串s="asdfer"中每个元素。
4，使用for循环对s="asdfer"进行循环，但是每次打印的内容都是"asdfer"。
5，使用for循环对s="abcdefg"进行循环，每次打印的内容是每个字符加上sb，    例如：asb, bsb，csb,...gsb。
6，使用for循环对s="321"进行循环，打印的内容依次是："倒计时3秒"，"倒计时2秒"，"倒计时1秒"，"出发！"。


7，实现一个整数加法计算器(两个数相加)：
如：content = input("请输入内容:") 用户输入：5+9或5+ 9或5 + 9，然后进行分割再进行计算。

8，升级题：实现一个整数加法计算器（多个数相加）：
如：content = input("请输入内容:") 用户输入：5+9+6 +12+  13，然后进行分割再进行计算。

9，计算用户输入的内容中有几个整数（以个位数为单位）。
如：content = input("请输入内容：")   # 如fhdal234slfh98769fjdla

10、写代码，完成下列需求：
    用户可持续输入（用while循环），用户使用的情况：
    输入A，则显示走大路回家，然后在让用户进一步选择：
    是选择公交车，还是步行？
    选择公交车，显示10分钟到家，并退出整个程序。
    选择步行，显示20分钟到家，并退出整个程序。
    输入B，则显示走小路回家，并退出整个程序。
    输入C，则显示绕道回家，然后在让用户进一步选择：
    是选择游戏厅玩会，还是网吧？
    选择游戏厅，则显示 ‘一个半小时到家，爸爸在家，拿棍等你。’并让其重新输入A，B,C选项。
    选择网吧，则显示‘两个小时到家，妈妈已做好了战斗准备。’并让其重新输入A，B,C选项。

11、写代码：计算 1 - 2 + 3 ... + 99 中除了88以外所有数的总和？

12、判断一句话是否是回文数:如上海自来水来自海上

14、制作趣味模板程序需求：等待⽤户输⼊名字、地点、爱好，根据⽤户的名字和爱好进⾏任意现实
    如：敬爱可亲的xxx，最喜欢在xxx地⽅⼲xxx

15、等待⽤户输⼊内容，检测⽤户输⼊内容中是否包含敏感字符？
    如果存在敏感字符提示“存在敏感字符请重新输⼊”，并允许⽤户重新输⼊并打印。敏感字符：“⼩粉嫩”、“⼤铁锤”

16、判断一个人的名字是否在百家姓中.有bug
'''

name_first = """
赵钱孙李，周吴郑王。
冯陈褚卫，蒋沈韩杨。
朱秦尤许，何吕施张。
孔曹严华，金魏陶姜。
戚谢邹喻，柏水窦章。
云苏潘葛，奚范彭郎。
鲁韦昌马，苗凤花方。
俞任袁柳，酆鲍史唐。
费廉岑薛，雷贺倪汤。
滕殷罗毕，郝邬安常。
乐于时傅，皮卞齐康。
伍余元卜，顾孟平黄。
和穆萧尹，姚邵湛汪。
祁毛禹狄，米贝明臧。
计伏成戴，谈宋茅庞。
熊纪舒屈，项祝董梁。
杜阮蓝闵，席季麻强。
贾路娄危，江童颜郭。
梅盛林刁，钟徐邱骆。
高夏蔡田，樊胡凌霍。
虞万支柯，昝管卢莫。
经房裘缪，干解应宗。
丁宣贲邓，郁单杭洪。
包诸左石，崔吉钮龚。
程嵇邢滑，裴陆荣翁。
荀羊於惠，甄曲家封。
芮羿储靳，汲邴糜松。
井段富巫，乌焦巴弓。
牧隗山谷，车侯宓蓬。
全郗班仰，秋仲伊宫。
宁仇栾暴，甘钭厉戎。
祖武符刘，景詹束龙。
叶幸司韶，郜黎蓟薄。
印宿白怀，蒲邰从鄂。
索咸籍赖，卓蔺屠蒙。
池乔阴鬱，胥能苍双。
闻莘党翟，谭贡劳逄。
姬申扶堵，冉宰郦雍。
卻璩桑桂，濮牛寿通。
边扈燕冀，郏浦尚农。
温别庄晏，柴瞿阎充。
慕连茹习，宦艾鱼容。
向古易慎，戈廖庾终。
暨居衡步，都耿满弘。
匡国文寇，广禄阙东。
欧殳沃利，蔚越夔隆。
师巩厍聂，晁勾敖融。
冷訾辛阚，那简饶空。
曾毋沙乜，养鞠须丰。
巢关蒯相，查后荆红。
游竺权逯，盖益桓公。
万俟司马，上官欧阳。
夏侯诸葛，闻人东方。
赫连皇甫，尉迟公羊。
澹台公冶，宗政濮阳。
淳于单于，太叔申屠。
公孙仲孙，轩辕令狐。
钟离宇文，长孙慕容。
鲜于闾丘，司徒司空。
丌官司寇，仉督子车。
颛孙端木，巫马公西。
漆雕乐正，壤驷公良。
拓跋夹谷，宰父谷梁。
晋楚闫法，汝鄢涂钦。
段干百里，东郭南门。
呼延归海，羊舌微生。
岳帅缑亢，况郈有琴。
梁丘左丘，东门西门。
商牟佘佴，伯赏南宫。
墨哈谯笪，年爱阳佟。
第五言福，百家姓终。
"""


def func():
    # while True:
    #     inp_s = input("请输入回家方式:").strip()
    #     if inp_s.upper() == "A":
    #         inp_s = input("选择步行回家还是坐公交车回家:").strip()
    #         if inp_s == "步行":
    #             print("20分钟到家")
    #         elif inp_s == "公交":
    #             print("10分钟到家")
    #         else:
    #             continue
    #         break
    #     elif inp_s.upper() == "B":
    #         print("走小路回家")
    #         break
    #     elif inp_s.upper() == "C":
    #         print("绕道回家")
    #         inp_s = input("选择游戏厅玩会，还是网吧？").strip()
    #         if inp_s == "游戏厅":
    #             print("一个半小时到家，爸爸在家，拿棍等你。")
    #         elif inp_s == "网吧":
    #             print("两个小时到家，妈妈已做好了战斗准备。")
    #         continue
    # print("----------------end question10--------------")

    # sum_num = 0
    # inp_num = input("输入算式:").strip()
    # inp_num = inp_num.split("+")
    # for i in inp_num:
    #     sum_num += int(i)
    # print(sum_num)
    # print("----------------end question8--------------")

    inp_num = input("请输入你的名字:").strip()

    for i in inp_num:
        if i in name_first:
            print("在百家姓中")
            break
    else:
        print("不在百家姓中")
    print("----------------end question16--------------")


if __name__ == "__main__":
    func()