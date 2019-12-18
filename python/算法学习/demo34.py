#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/12/17  10:22


# 暴力匹配
def bf(main_str, pat):
    if not (isinstance(main_str, str) and isinstance(pat, str)):
        return
    for index, value in enumerate(main_str):
        temp = index
        for j in pat:
            if j == main_str[temp] and temp <= len(main_str):
                temp += 1
            else:
                break
        else:
            return index
    else:
        return None


if __name__ == "__main__":
    main_str = 'aklbvsvbasreweesdsssss'
    pat_str = 'lbv'
    ret = bf(main_str, pat_str)
    print(ret)

