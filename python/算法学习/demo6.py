#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/9/8  21:14
# 列表模拟环形队列


class MyQueue(object):
    def __init__(self, maxsize):
        self.maxsize = maxsize
        self.rear = 0
        self.front = 0
        self.queue = [0 for i in range(maxsize)]

    def queue_size(self):
        return (self.rear + self.maxsize - self.front) % self.maxsize

    def is_empty(self):
        return self.rear == self.front

    def is_full(self):
        return (self.rear + 1) % self.maxsize == self.front

    def add_value(self, value):
        if self.is_full():
            print("队列已满...")
            return
        else:
            self.queue[self.rear] = value
            self.rear = (self.rear + 1) % self.maxsize

    def get_value(self):
        if self.is_empty():
            print("队列空")
            return
        else:
            value = self.queue[self.front]
            self.front = (self.front + 1) % self.maxsize
            return value

    def show_value(self):
        if self.is_empty():
            print("队列空")
            return
        else:
            for i in range(self.front, self.front + self.queue_size()):
                print("queue[%d] = %d" % (i % self.maxsize, self.queue[i % self.maxsize]))

    def head_queue(self):
        if self.is_empty():
            print("队列空")
            return
        else:
            return self.queue[self.front]


if __name__ == "__main__":
    myqueue = MyQueue(5)
#  最多只能使用size-1的空间
    for i in range(5):
        myqueue.add_value(i)

    status = myqueue.is_full()
    print(status)
    status = myqueue.is_empty()
    print(status)
    myqueue.show_value()
    value = myqueue.get_value()
    print(value)
    value = myqueue.get_value()
    print(value)
    value = myqueue.head_queue()
    print(value)
    myqueue.show_value()
    myqueue.add_value(4)
    myqueue.add_value(5)
    myqueue.show_value()

