#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/12/18  14:13
MAX_SIZE = 256      # 全局变量


def print_bc(lis):
    count = 0
    for i in lis:
        count += 1
        print(i, end=' ')
        if count == 10:
            print('\n')
            count = 0


# 生成模式串hash表
def generate_bc(lis_b):
    """
    :param lis_b:   模式串
    :return:lis_bc  散列表
    """
    lis_bc = [-1 for i in range(MAX_SIZE)]      # 来记录每个字符在模式串中出现的位置。
    for i in range(len(lis_b)):
        temp = ord(lis_b[i])                    # lis_b[i]的ascii值
        lis_bc[temp] = i
    return lis_bc


def bm(lis_a, lis_b):
    """
    :param lis_a:   主串
    :param lis_b:   模式串
    :return:
    """
    lis_bc = generate_bc(lis_b)         # 构建坏字符哈希表，记录模式串中每个字符最后出现的位置
    lis_suffix, lis_prefix = generate_gs(lis_b)
    n = len(lis_a)                      # 主串长度
    m = len(lis_b)                      # 模式串长度
    i = 0                               # i表示主串与模式串对齐的第一个字符
    while i <= n - m:
        for j in range(m-1, -1, -1):        # 模式串从后往前匹配
            if lis_a[i+j] != lis_b[j]:      # 坏字符对应模式串中的下标是j
                break
        if j <= 0:                          # 匹配成功，返回主串与模式串第一个匹配的字符的位置
            return i
        x = j - lis_bc[ord(lis_a[i+j])]     # 等同于将模式串往后滑动j-bc[(int)a[i+j]]位
        y = 0
        if j < m - 1:                       # 如果有好后缀的话
            y = move_gs(j, m, lis_suffix, lis_prefix)
        i = i + max(x, y)
    return -1


def move_gs(j, m, lis_suffix, lis_prefix):
    """
    :param j:           j表示坏字符对应的模式串中的字符下标
    :param m:           m表示模式串长度
    :param lis_suffix:
    :param lis_prefix:
    :return:
    """
    k = m - 1 - j       # 好后缀长度
    if lis_suffix[k] != -1:
        return j - lis_suffix[k] + 1
    for r in range(j+2, m):
        if lis_prefix[m-r] is True:
            return r
    return m


def generate_gs(lis_b):
    """
    :param lis_b:           模式串
    :return:
        suffix数组的下标k，表示后缀子串的长度，数组值存储的是，在模式串中跟好后缀{u}相匹配的子串{u*}的起始下标值
        prefix来记录模式串的后缀子串是否能匹配模式串的前缀子串。
    """
    m = len(lis_b)
    lis_suffix = [-1 for i in range(m)]
    lis_prefix = [False for i in range(m)]
    for i in range(0, m-1):                         # lis_b[0, i]
        j = i
        k = 0                                       # 公共后缀子串长度
        while j >= 0 and lis_b[j] == lis_b[m-1-k]:  # 与lis_b[0, m-1]求公共后缀子串
            j -= 1
            k += 1
            lis_suffix[k] = j + 1                   # j+1表示公共后缀子串在b[0, i]中的起始下标
        if j == -1:                                 # 如果公共后缀子串也是模式串的前缀子串
            lis_prefix[k] = True

    return lis_suffix, lis_prefix


if __name__ == "__main__":
    lis_a = 'abcacabcbcbacabcabcab'    # 主串
    lis_b = 'cab'                      # 模式串
    ret = bm(lis_a, lis_b)
    print(ret)

