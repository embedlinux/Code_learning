#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/21  21:08

# isinstance/issubclass/type
# 给你一个参数，判断对象是不是由某一个指定类？ type                  --> type(obj) == Foo
# 给你一个参数，判断对象是不是由某一个指定类或其父类？ isinstance    --> instance(obj,Foo)

# 方法和函数
#     对象.xxx   xxx就是方法
#     类.xxx     xxx就是函数

# 反射

# 总结：
# v = getattr(obj, "func")  # 根据字符串为参数（第二个参数），去对象（第一个参数）中寻找与之同名的成员。
#
# 好记：
# getattr  # 根据字符串的形式，去对象中找成员。
# hasattr  # 根据字符串的形式，去判断对象中是否有成员。
# setattr  # 根据字符串的形式，动态的设置一个成员（内存）
# delattr  # 根据字符串的形式，动态的删除一个成员（内存）


if __name__ == "__main__":
    pass
