#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/9/17  20:33


# 到达map[6][5]即表示找到路,map[i][j] = 0 表示未走过,1表示墙,2表示通路, 3表示已走过,但是不通
# 走迷宫策略:下-->右-->上-->左
def search_the_road(i, j, maps):
    """
    :param i:  表示起始位置横坐标
    :param j: 表示起始位置纵坐标
    :param maps: 表示地图
    :return: True or False
    """
    if maps[6][5] == 2:
        return True
    else:
        if maps[i][j] == 0:
            # 按策略走
            maps[i][j] = 2
            if search_the_road(i+1, j, maps):
                return True
            elif search_the_road(i, j+1, maps):
                return True
            elif search_the_road(i-1, j, maps):
                return True
            elif search_the_road(i, j-1, maps):
                return True
            else:
                maps[i][j] = 3
        else:
            return False


# 迷宫问题
def maze_issue():
    maps = [[0 for j in range(7)] for i in range(8)]
    rows = len(maps)
    cols = len(maps[0])
    for i in range(cols):
        maps[0][i] = 1
        maps[7][i] = 1
    for i in range(rows):
        maps[i][0] = 1
        maps[i][6] = 1
    maps[3][1] = 1
    maps[3][2] = 1
    maps[2][2] = 1
    maps[4][3] = 1
    for i in range(rows):
        for j in range(cols):
            print(maps[i][j], end=' ')
        print('\n')
    print('----------------------------')
    status = search_the_road(1, 1, maps)
    print(status)
    print("路径:")
    for i in range(rows):
        for j in range(cols):
            print(maps[i][j], end=' ')
        print('\n')


if __name__ == "__main__":
    maze_issue()