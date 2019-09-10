#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/9/8  10:57
# 基础队列的实现


class SelfQueue(object):
    def __init__(self, size):
        self.size = size
        self.front = -1                # 指向队列头的前一个位置
        self.rear = -1                 # 指向队列尾部
        self.queue = [0 for i in range(0, size)]

    def add_queue(self, value):
        if self.is_full():
            print("队列满,不能添加数据")
            return
        else:
            self.rear += 1
            self.queue[self.rear] = value
            return value

    def get_queue(self):
        if self.is_empty():
            print("队列空,不能删除数据")
            return
        else:
            value = self.queue[self.front + 1]
            for i in range(0, self.rear):
                self.queue[i] = self.queue[i+1]
            self.rear -= 1
            return value

    def maxsize(self):
        return self.size

    def is_full(self):
        if self.rear == self.size - 1:
            return True
        else:
            return False

    def is_empty(self):
        return self.rear == self.front

    def show_queue(self):
        if self.is_empty():
            print("队列空,没有数据")
        else:
            for i in range(0, self.rear + 1):
                print("queue[%d]=%d\n" % (i, self.queue[i]))

    def head_queue(self):
        if self.is_empty():
            print("队列空")
            return
        else:
            return self.queue[self.front + 1]


if __name__ == "__main__":
    myqueue = SelfQueue(5)
    size = myqueue.maxsize()
    print(size)
    status = myqueue.is_empty()
    print(status)
    for i in range(6):
        myqueue.add_queue(i)
    status = myqueue.is_full()
    print(status)
    head = myqueue.head_queue()
    print(head)
    myqueue.show_queue()
    value = myqueue.get_queue()
    print(value)
    value = myqueue.get_queue()
    print(value)
    myqueue.show_queue()
    myqueue.add_queue(1)
    myqueue.add_queue(2)
    myqueue.show_queue()
    head = myqueue.head_queue()
    print(head)

    for i in range(6):
        myqueue.get_queue()

