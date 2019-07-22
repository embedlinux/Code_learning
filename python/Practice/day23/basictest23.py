#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/18  21:55


# - 实例变量(字段)            使用对象访问,即: obj1.name
# -     公有实例变量(字段)
#             self.name
# -     私有实例变量(字段)
#             self.__name
# - 类变量(静态字段)           使用类方法,即: Foo.country  (实在不方便时,才使用对象)
#                             当所有对象中有共同的字段时且要改都改要删都删时,可以将实例变量(字段)提取到类变量(静态字段)
# -     公有类变量(静态字段)
#             name
# -     私有类变量(静态字段)
#             __name
class Foo:
    # 类变量(静态字段)
    country = "中国"

    def __init__(self, name):
        # 实例变量(字段)
        self.name = name

    def func(self):
        pass

# 实例方法
#     class Foo(object):
#         def __init__(self, name):
#             self.name = name
#         def func(self):
#             print(self.name)
#     obj = Foo('..')
#     obj.func()

# 静态方法, 静态方法,如果方法无需使用对象中封装的值,那么就可以使用静态方法
#   1. 编写时:
#        - 方法上方写 @staticmethod
#        - 方法参数可有可无
#   2. 调用时:
#       - 类.方法名()
#       - 对象.方法名()
#   3. 什么时写静态方法?
#       - 无需调用对象中已封装的值.
# class Foo(object):
#     def __init__(self, name):
#         self.name = name
#     @staticmethod
#     def display(a1, a2):
#         return a1 + a2
# Foo.display(1,3)

# 类方法
#   1. 定义时:
#        - 方法上方写: @classmethod
#        - 方法的参数: 至少有一个cls参数
#   2. 执行时:
#        - 类名.方法名()  # 默认会将当前类传到参数中.
#   3. 什么时用?
#        - 如果在方法中会使用到当前类,那么就可以使用类方法.
# class Foo(object):
#     @classmethod
#     def show(cls, x1, x2):
#         print(cls, x1, x2)
# Foo.show(1, 8)

# 方法的成员修饰符
# class Foo(object):
#     def __display(self,arg):
#         print('私有实例方法', arg)
#     @staticmethod
#     def __display(arg):
#         print('私有静态 法', arg)
#     @classmethod
#     def __display(cls, arg):
#         print('私有类方法', arg)

# 属性(通过方法改造出来)
#     1. 编写时
#            - 方法上方写 @property
#            - 方法参数:只有一个self
#     2. 调用时:无需加括号  对象.方法
#     3. 应用场景: 对于简单的方法,当无需传参且有返回值时,可以使用 @property
# class Foo(object):
#     def __init__(self):
#         pass
#     @property
#     def start(self):
#         return 1
#     @property
#     def end(self):
#         return 10
# obj = Foo()
# print(obj.start)
# print(obj.end)

# 嵌套, 组合


# 学校
class School:
    def __init__(self, address):
        self.address = address
        self.subject = None


# 课程
class Subject:
    def __init__(self, name, time, price):
        self.name = name
        self.time = time
        self.price = price
        self.school = None


# 班级
class Classes:
    def __init__(self, s_time, e_time, s_nums, brief):
        self.s_time = s_time
        self.e_time = e_time
        self.s_nums = s_nums
        self.brief = brief
        self.subject = None


if __name__ == "__main__":
    school1 = School("北京")
    school2 = School("上海")
    school3 = School("深圳")

    s_python = Subject("python", "100", 12000)
    s_linux = Subject("Linux", "80", 11000)
    s_go = Subject("Go", "60", 10000)






