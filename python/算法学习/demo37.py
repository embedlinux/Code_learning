#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/12/23  14:12


'''
attributes = ['name', 'dob', 'gender']
values = [  ['jason', '2000-01-01', 'male'],
            ['mike', '1999-01-01', 'male'],
            ['nancy', '2001-02-01', 'female']
        ]
# expected outout:
    [   {'name': 'jason', 'dob': '2000-01-01', 'gender': 'male'},
        {'name': 'mike', 'dob': '1999-01-01', 'gender': 'male'},
        {'name': 'nancy', 'dob': '2001-02-01', 'gender': 'female'}]
'''


def generate_dic():
    attributes = ['name', 'dob', 'gender']
    values = [['jason', '2000-01-01', 'male'],
              ['mike', '1999-01-01', 'male'],
              ['nancy', '2001-02-01', 'female']
              ]
    ret = []
    for i in values:
        dic = {}
        for index, item in enumerate(i):
            dic[attributes[index]] = item
        ret.append(dic)
    print(ret)
    lis = [dict(zip(attributes, value)) for value in values]
    print(lis)


def find_jobs():
    mn = input().strip().split()
    n = int(mn[0])
    m = int(mn[1])
    salary = {}
    for i in range(n):
        tmp = input().strip().split()
        salary[int(tmp[0])] = int(tmp[1])
    salary = sorted(salary.items(), key=lambda x: x[0])
    ais = input().strip().split()
    index = 0
    for i in range(m):
        ai = int(ais[i])
        while True:
            if ai >= salary[index][0]:
                if index < n - 1 and ai >= salary[index + 1][0]:
                    index += 1
                else:
                    print(salary[index][1])
                    break
            elif ai < salary[index][0]:
                if index <= 0:
                    print(salary[index][1])
                    break
                else:
                    index -= 1


def divisible_by_three():
    lr = input().strip().split()
    l = int(lr[0])
    r = int(lr[1])
    count = 0
    for i in range(l, r+1):
        if i % 3 == 1:
            continue
        else:
            count += 1
    print(count)


def reverse(x):
    if abs(x) >= (2**31 - 1):
        return 0
    xx = abs(x)
    xs = str(xx)
    xs = xs[::-1]
    xx = int(xs)
    if abs(xx) >= (2**31 - 1):
        return 0
    if x > 0:
        return xx
    else:
        return -xx


def romanToInt(s):
    dic = {'I': 1, 'V': 5, 'X': 10, 'L': 50, 'C': 100, 'D': 500, 'M': 1000}
    ret_sum = 0
    tmp_sum = 0
    len_str = len(s)
    flag = False
    for i in range(len_str):
        if flag:
            flag = False
            continue
        if (i + 1 < len_str) and dic[s[i + 1]] > dic[s[i]]:
            tmp_sum = dic[s[i + 1]] - dic[s[i]]
            ret_sum += tmp_sum
            flag = True
        else:
            ret_sum += dic[s[i]]
    return ret_sum


if __name__ == "__main__":
    # generate_dic()
    # find_jobs()
    # divisible_by_three()
    # print(reverse(1534236469))
    # print(9646324351 >= 2**31 - 1)
    print(romanToInt('MCMXCIV'))
