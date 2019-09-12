#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/9/12  14:38


class Node(object):
    def __init__(self, value):
        self.value = value
        self.next = None


class CycleLinkList(object):
    def __init__(self):
        self.size = 0
        self.head = None

    def append_node(self, value):
        node = Node(value)
        temp = self.head
        size = self.size
        if temp is None:            # 没有结点
            self.head = node
            node.next = node
            self.size += 1
            return node.value
        for i in range(size-1):
            temp = temp.next
        temp.next = node
        node.next = self.head
        self.size += 1
        return node.value

    def show_node(self):
        len = self.size
        temp = self.head
        for i in range(len):
            print(temp.value, end=' ')
            temp = temp.next

    
if __name__ == "__main__":
    mylink = CycleLinkList()
    for i in range(7):
        mylink.append_node(i)
    mylink.show_node()

