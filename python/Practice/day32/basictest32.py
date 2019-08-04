#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/1  22:28
from multiprocessing import Process, Queue
import multiprocessing
import time
import random
import os


# 操作系统的发展史:https://www.cnblogs.com/Eva-J/articles/8253521.html


# 1. 操作系统 / 应用程序
# 2. 操作中的"并发"
#     并发:伪, 并发是指资源有限的情况下，两者交替轮流使用资源，比如一段路(单核CPU资源)同时只能过一个人，A走一段后，
#       让给B，B用完继续给A ，交替使用，目的是提高效率。
#     并行:真,并行是指两者同时执行，比如赛跑，两个人都在不停的往前跑；
# 3. 其他语言线程、进程
# 4. Python中线程和进程（GIL锁）
#     进程:https://www.cnblogs.com/Eva-J/articles/8253549.html
#     线程:https://www.cnblogs.com/Eva-J/articles/8306047.html
#     协程:https://www.cnblogs.com/Eva-J/articles/8324673.html
# 5. Python线程编写 + 锁
# 6. 小爬虫


class Myprocess(Process):
    def __init__(self, person):
        # self.name = person   # name属性是Process中的属性，标示进程的名字
        super().__init__() # 执行父类的初始化方法会覆盖name属性
        self.name = person # 在这里设置就可以修改进程名字了
        # self.person = person #如果不想覆盖进程名，就修改属性名称就可以了

    def run(self):
        print('%s正在和网红脸聊天' % self.name)
        # print('%s正在和网红脸聊天' %self.person)
        time.sleep(random.randrange(1, 5))
        print('%s正在和网红脸聊天' % self.name)
        # print('%s正在和网红脸聊天' %self.person)


def foo():
    print(123)
    time.sleep(1)
    print("end123")


def bar():
    print(456)
    time.sleep(3)
    print("end456")


def f(q):
    q.put([time.asctime(), 'from Eva', 'hello'])  # 调用主函数中p进程传递过来的进程参数 put函数为向队列中添加一条数据。


# 向queue中输入数据的函数
def inputQ(queue):
    info = str(os.getpid()) + '(put):' + str(time.asctime())
    queue.put(info)


# 向queue中输出数据的函数
def outputQ(queue):
    info = queue.get()
    print('%s%s\033[32m%s\033[0m'%(str(os.getpid()), '(get):', info))


# 测试
def test_multQ():
    multiprocessing.freeze_support()
    record1 = []   # store input processes
    record2 = []   # store output processes
    queue = multiprocessing.Queue(3)

    # 输入进程
    for i in range(10):
        process = multiprocessing.Process(target=inputQ, args=(queue,))
        process.start()
        record1.append(process)

    # 输出进程
    for i in range(10):
        process = multiprocessing.Process(target=outputQ, args=(queue,))
        process.start()
        record2.append(process)

    for p in record1:
        p.join()

    for p in record2:
        p.join()

    print('-------------end main procress---------------')


if __name__ == "__main__":
    # p1 = Myprocess('哪吒')
    # p1.start()
    # print(p1.pid)          # 可以查看子进程的进程id

    # p1 = Process(target=foo)
    # p2 = Process(target=bar)
    # p1.daemon = True
    # p1.start()
    # p2.start()
    # time.sleep(0.1)
    # print("main-------")

    q = Queue()  # 创建一个Queue对象
    p = Process(target=f, args=(q, ))   # 创建一个进程
    p.start()
    print(q.get())
    p.join()
    test_multQ()
