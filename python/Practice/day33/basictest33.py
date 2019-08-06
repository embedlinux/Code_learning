#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/5  21:43

# 锁:https://www.cnblogs.com/Eva-J/p/5110160.html
#     线程锁:由于线程之间是进行随机调度，并且每个线程可能只执行n条执行之后，当多个线程同时修改同一条数据时
#     可能会出现脏数据，所以，出现了线程锁 - 同一时刻允许一个线程执行操作。
#       Lock (1次放1个)
#       RLock (1次放1个)
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
# 生产者消费者模型
#     队列实现 q = queue.Queue()
#     生产者   q.put()
#     消费者   q.get()


if __name__ == "__main__":
    pass
