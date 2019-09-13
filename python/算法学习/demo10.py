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

# 末尾添加节点
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

# 显示节点
    def show_node(self):
        len = self.size
        temp = self.head
        for i in range(len):
            print(temp.value, end=' ')
            temp = temp.next
        print("\n")

# 约瑟夫问题
    def jusephu(self, step):
        size = self.size
        temp = self.head
        while self.size > 1:
            for i in range(1, step-1):
                temp = temp.next
            print(temp.next.value, end=' ')
            temp.next = temp.next.next
            temp = temp.next
            self.size -= 1
        print(temp.value)


if __name__ == "__main__":
    mylink = CycleLinkList()
    for i in range(1, 25):
        mylink.append_node(i)
    mylink.show_node()
    mylink.jusephu(3)

