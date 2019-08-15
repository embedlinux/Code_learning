#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/8/7  21:14

# 进程
#     import multiprocessing.Process
# 进程间通信
#     队列:import multiprocessing.Queue
#     Manage类:import multiprocessing.Manager()
#         The types registered are those intended for the synchronization
#         of threads, plus `dict`, `list` and `Namespace`.

#     Manage类:import multiprocessing.Manager()
#         The types registered are those intended for the synchronization
#         of threads, plus `dict`, `list` and `Namespace`.
#     IPC((Inter-Process Communication)):队列和管道
#           multiprocessing.Queue
#       尽量避免使用共享数据，尽可能使用消息传递和队列，
#       避免处理复杂的同步和锁问题，而且在进程数目增多时，往往可以获得更好的可获展性。
#           JoinableQueue([maxsize])
#               创建可连接的共享进程队列。这就像是一个Queue对象，但队列允许项目的使用者通知生产者项目已经被成功处理。
#               通知进程是使用共享的信号和条件变量来实现的.
# 进程锁
#     import multiprocessing.Lock
#     import multiprocessing.RLock
#     import multiprocessing.Event
#     import multiprocessing.Condition
#     import multiprocessing.BoundedSemaphore
# 进程池
#     from concurrent.futures import ThreadPoolExecutor, ProcessPoolExecutor
#     import multiprocessing.Pool
# 模块:requests/bs4


if __name__ == "__main__":
    pass
