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


if __name__ == "__main__":
    generate_dic()

