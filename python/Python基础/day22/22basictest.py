#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/17  20:57


# 面向对象

'''
1. 简述编写类和执行类中方法的流程。
2. 简述面向对象三大特性？
3. 将以下函数改成类的方式并调用：
    def func(a1):
        print(a1)
4. 方法和函数的区别？
5. 什么是构造方法？
6. ⾯面向对象中的self指的是什么？
7. 以下代码体现面向对象的什么特点？
    class Person:
        def __init__(self,name,age,gender):
            self.name = name
            self.age = age
            self.gender = gender
    obj = Person('孙福来',18,'女')
8. 以下代码体现面向对象的什么特点？
    class Message:
        def email(self, em, text):pass
        def msg(self, tel, text):pass
        def wechat(self, num, text):pass
9. 看代码写结果
    class Foo:
        def func(self):
            print("foo.func")
    obj = Foo()
    result = obj.Foo()
    print(result)
10. 定义一个类，其中有计算周长和面积的⽅方法（圆的半径通过参数传递到构造方法）。
11. 面向对象中为什么要有继承？
12. Python多继承时，查找成员的顺序遵循什么规则？
13. 看代码写结果
        class Base1:
            def f1(self):
                print('base1.f1')
            def f2(self):
                print('base1.f2')
            def f3(self):
                print('base1.f3')
        class Base2:
            def f1(self):
                print('base2.f1')
        class Foo(Base1, Base2):
            def f0(self):
                print('foo.f0')

        obj = Foo()
        obj.f0()
14. 看代码写结果
        class Base:
            def f1(self):
                print('base.f1')
            def f3(self):
                self.f1()
                print('base.f3')
        class Foo(Base):
            def f1(self):
                print('foo.f1')
            def f2(self):
                print('foo.f2')
        obj2 = Base()
        obj2.f2()
15. 补充代码实现：
    user_list = []
    while True:
        user = input(“请输入用户名:”)
        pwd = input(“请输入密码:”)
        email = input(“请输入邮箱:”)
    1. while循环提示用户输⼊：用户名、密码、邮箱（正则满足邮箱格式）
    2. 为每个用户创建一个对象，并添加到列表中。
    3. 当列表中的添加了3个对象后，跳出循环并以此循环打印所有用户的姓名和邮箱。如：
        我叫alex,邮箱是xxx@live.com
        ...
16. 补充代码：实现用户注册和登录
class User:
    def __init__(self,name,pwd):
        self.name = name
        self.pwd = pwd

class Account:
    def __init__(self):
        # 用户列表 数据格式:[User对象,...]
        self.user_list = []

    def login(self):
        # 用户登录,用户输入用户名并去self.user_list中检查用户是否合法
        pass

    def register(self):
        # 用户注册,,动态创建User对象,斌企鹅额添加到self.user_list中
        pass

    def run(self):
        # 主程序,先进性2词用户注册,在进行用户登录(3词重试机会)
        pass

if __name__=='__main__':
    obj = Account()
    obj.run()
'''

import os


if __name__ == "__main__":
    pass
