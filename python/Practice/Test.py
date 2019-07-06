#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/6  8:42


import tushare


def main():
    data = tushare.get_realtime_quotes('000002')
    # print(data)
    # print(type(data))
    for i in data:
        # print(i, data[i])
        print(i, data[i])


if __name__ == '__main__':
    main()