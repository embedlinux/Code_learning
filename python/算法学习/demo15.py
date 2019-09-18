#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/9/18  10:01

# 设有n位选手参赛，初赛共进行n-1天，每位选手要与其他每一位选手进行一场比赛，然后按积分排名选拔进入决赛的选手。根据学
# 校作息时间，要求每位选手每天必须比赛一场，不能轮空


def match_player(matchs, k, num):
    """
    :param matchs:
    :param k:     处理编号k开始的n个选手的日程
    :param num:
    :return:
    """
    if num == 2:
        matchs[k][1] = k        # 参赛选手编号
        matchs[k][2] = k+1      # 对阵选手编号
        matchs[k+1][1] = k+1    # 参赛选手编号
        matchs[k+1][2] = k      # 对阵选手编号
    else:
        match_player(matchs, k, num//2)         # 递归调用
        match_player(matchs, k+num//2, num//2)  # 递归调用
        # 填充右上角
        for i in range(k, k+num//2):
            for j in range(num//2 + 1, num+1):
                matchs[i][j] = matchs[i+num//2][j-num//2]

        # 填充右下角
        for i in range(k+num//2, k+num):
            for j in range(num//2 + 1, num+1):
                matchs[i][j] = matchs[i-num//2][j-num//2]


def dispaly(matchs, num):
    for i in range(1, num+1):
        if i == 1:
            print("%+2s" % "编号", end=' ')
        else:
            print("第%d天" % (i-1), end=' ')
    print('\n')
    for i in range(1, num+1):
        for j in range(1, num+1):
            print("{:^4}".format(matchs[i][j]), end=' ')
        print('\n')


if __name__ == "__main__":
    max_player = 65
    num = 8   # 比赛人数
    matchs = [[0 for i in range(max_player)] for i in range(max_player)]
    match_player(matchs, 1, num)
    dispaly(matchs, num)
