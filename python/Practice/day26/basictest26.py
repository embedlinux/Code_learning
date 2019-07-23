#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/22  21:14

# 约束
# 1.什么是接口以及作用？
#   接口是一种数据类型，主要用于约束派生类中必须实现指定的方法。
#   Python中不存在，Java和C  # 中是存在的。
# 2.Python中使用过什么来约束呢？
#   - 抽象类 + 抽象方法，编写上麻烦。
#   - 人为主动抛出异常
#
# 3.约束时，抛出的异常是否可以用其他的？
#   不专业：raise Exception(".send() 必须被重写.")
#   专业：raise NotImplementedError(".send() 必须被重写.")
# 4.应用场景：
#     多个类，内部都必须有某些方法时，需要使用基类 + 异常进行约束。

# 自定义异常

# hashlib
#     hashlib.md5()

# 日志模块
#     排查错误, logging
# logger = logging.basicConfig(filename='xxxxxxx.txt',
#                              format='%(asctime)s - %(name)s - %(levelname)s -%(module)s:  %(message)s',
#                              datefmt='%Y-%m-%d %H:%M:%S',
#                              level=30)
# logging.debug('x1') # 10
# logging.info('x2')  # 20
# logging.warning('x3') # 30
# logging.error('x4')    # 40
# logging.critical('x5') # 50
# logging.log(10,'x6')
# def func():
#     try:
#         a = a + 1
#     except Exception as e:
#         # 获取当前错误的堆栈信息
#         msg = traceback.format_exc()
#         logging.error(msg)

# 创建一个操作日志的对象logger（依赖FileHandler）
# file_handler = logging.FileHandler('l1.log', 'a', encoding='utf-8')
# file_handler.setFormatter(logging.Formatter(fmt="%(asctime)s - %(name)s - %(levelname)s -%(module)s:  %(message)s"))
#
# logger = logging.Logger('s1', level=logging.ERROR)
# logger.addHandler(file_handler)


import hashlib

if __name__ == "__main__":
    obj = hashlib.md5()
    obj.update("admin".encode("utf-8"))
    print(obj.hexdigest())
