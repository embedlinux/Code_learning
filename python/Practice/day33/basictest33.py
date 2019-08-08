#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/5  21:43

# 锁:https://www.cnblogs.com/Eva-J/p/5110160.html
#     import threading
#     线程锁:由于线程之间是进行随机调度，并且每个线程可能只执行n条执行之后，当多个线程同时修改同一条数据时
#     可能会出现脏数据，所以，出现了线程锁 - 同一时刻允许一个线程执行操作。
<<<<<<< HEAD
#       Lock (1次放1个)
#       RLock (1次放1个)
=======
#       Lock (1次放1个)    ：多次调用会产生死锁
#       RLock (1次放1个)   ：递归锁，可以进行多次调用
>>>>>>> 8b3860e49be7c60c1fb4bd405ad263281ade5b13
#     BoundedSemaphore（1次放N个）信号量:互斥锁 同时只允许一个线程更改数据，而Semaphore是同时允许一定数量
#       的线程更改数据，比如厕所有3个坑，那最多只允许3个人上厕所，后面的人只能等里面有人出来了才能再进去。
#     Condition（1次方法x个）:
#         使得线程等待，只有满足某条件时，才释放n个线程
#     Event（1次放所有）:python线程的事件用于主线程控制其他线程的执行，事件主要提供了三个方法 set、wait、clear。
#       事件处理的机制：全局定义了一个“Flag”，如果“Flag”值为 False，那么当程序执行 event.wait 方法时就会阻塞，
#       如果“Flag”值为True，那么event.wait方法时便不再阻塞

# threading.local
#     Python提供了threading.local 类，将这个类实例化得到一个全局对象，但是不同的线程使用
# 这个对象存储的数据其它线程不可见(本质上就是不同的线程使用这个对象时为其创建一个独立的字典)。

# 线程池
#   https://www.cnblogs.com/xibuhaohao/p/10345362.html
<<<<<<< HEAD
#   from concurrent.futures import ThreadPoolExecutor
=======
#   concurrent.futures  模块提供了高度封装的异步调用接口
#         ThreadPoolExecutor：线程池，提供异步调用
#         ProcessPoolExecutor: 进程池，提供异步调用
#
#         submit(fn, *args, **kwargs)                         异步提交任务
#         map(func, *iterables, timeout=None, chunksize=1)    取代for循环submit的操作
#         shutdown(wait=True)                                 相当于进程池的pool.close()+pool.join()操作
#               wait=True， 等待池内所有任务执行完毕回收完资源后才继续
#               wait=False，立即返回，并不会等待池内的任务执行完毕
#               但不管wait参数为何值，整个程序都会等到所有任务执行完毕ubmit和map必须在shutdown之前
#         result(timeout=None)                                取得结果
#         add_done_callback(fn)                               回调函数
#         done()                                              判断某一个线程是否完成
#         cancle()                                            取消某个任务
>>>>>>> 8b3860e49be7c60c1fb4bd405ad263281ade5b13
# 生产者消费者模型
#     队列实现 q = queue.Queue()
#     生产者   q.put()
#     消费者   q.get()

<<<<<<< HEAD

if __name__ == "__main__":
    pass
=======
from threading import Thread
from multiprocessing import Process
import os


def work():
    print('hello,', os.getpid())


def diff_multi_process_thread():
    # part1:在主进程下开启多个线程,每个线程都跟主进程的pid一样
    t1 = Thread(target=work)
    t2 = Thread(target=work)
    t1.start()
    t2.start()
    print('主线程/主进程pid', os.getpid())

    # part2:开多个进程,每个进程都有不同的pid
    p1 = Process(target=work)
    p2 = Process(target=work)
    p1.start()
    p2.start()
    print('主线程/主进程pid', os.getpid())


if __name__ == "__main__":
    diff_multi_process_thread()
>>>>>>> 8b3860e49be7c60c1fb4bd405ad263281ade5b13
