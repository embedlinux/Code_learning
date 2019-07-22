#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/19  20:42

# 主动调用其他类成员
# ########### 方式一
# class Base(object):
#
#     def f1(self):
#         print('5个功能')
#
# class Foo(object):
#
#     def f1(self):
#         print('3个功能')
#         Base.f1(self)
#
# obj = Foo()
# obj.f1()


# ########### 方式二:按照类的继承顺序,找下一个.
"""
class Base(object):
    def f1(self):
        print('5个功能')
class Foo(Base):
    def f1(self):
        super().f1()
        print('3个功能')
obj = Foo()
obj.f1()
"""

# 特殊成员
# 1. 类名() 自动执行 __init__
# obj = Foo(1,2)

# 2. 对象() 自动执行 __call__
# ret = obj(6,4,2,k1=456)

# 3. 对象['xx']  自动执行 __getitem__
# ret = obj['yu']
# print(ret)

# 4. 对象['xx'] = 11  自动执行 __setitem__
# obj['k1'] = 123

# 5. del 对象[xx]     自动执行 __delitem__
# del obj['uuu']

# 6. 对象+对象         自动执行 __add__
# obj1 = Foo(1,2)
# obj2 = Foo(88,99)
# ret = obj2 + obj1
# print(ret)

# 7. with 对象        自动执行 __enter__ / __exit__
# obj = Foo(1,2)
# with obj as f:
#     print(f)
#     print('内部代码')

# 8. 真正的构造方法
# class Foo(object):
#     def __init__(self, a1, a2):     # 初始化方法
#         """
#         为空对象进行数据初始化
#         :param a1:
#         :param a2:
#         """
#         self.a1 = a1
#         self.a2 = a2
#
#     def __new__(cls, *args, **kwargs): # 构造方法
#         """
#         创建一个空对象
#         :param args:
#         :param kwargs:
#         :return:
#         """
#         return object.__new__(cls) # Python内部创建一个当前类的对象(初创时内部是空的.).

if __name__ == "__main__":
    pass

