#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/9/9  21:40
# 单链表的实现


class Node(object):
    def __init__(self, value, num=0):
        self.next = None
        self.value = value
        self.num = num


class SingleLink(object):
    def __init__(self, name="MyLinkList"):
        self.name = name
        self.number = 0
        self.head = None

# 判断链表是否为空
    def is_empty(self):
        if self.head:
            return False
        else:
            return True

# 返回链表长度
    def length(self):
        return self.number

# 加到链表头部
    def add_node(self, value):
        node = Node(value)
        node.next = self.head
        self.head = node
        self.number += 1
        return node

# 遍历链表
    def show_link(self):
        if self.is_empty():
            print("当前列表为空")
        cur = self.head
        while cur:
            print(cur.value, end=" ")
            cur = cur.next
        print("\n")

# 从尾部添加节点
    def append_value(self, value):
        node = Node(value)
        cur = self.head
        while cur.next:
            cur = cur.next
        cur.next = node
        self.number += 1
        return node

# 从头部删除节点
    def delete_node(self):
        cur = self.head
        if self.is_empty():
            print("链表为空,无结点可删除")
            return
        else:
            self.head = cur.next
            self.number -= 1
            return cur

# 从尾部删除节点
    def pop_node(self):
        if self.is_empty():
            print("当前链表为空...")
            return
        cur = self.head
        if self.number == 1:
            self.head = None
            self.number = 0
            return cur
        while cur.next and cur.next.next:
            cur = cur.next
        node = cur.next
        cur.next = None
        self.number -= 1
        return node

# 链表的名字
    def __str__(self):
        return self.name


if __name__ == "__main__":
    mylink = SingleLink("MySingleLinkList")
    print(mylink)
    status = mylink.is_empty()
    print(status)
    for i in range(4):
        status = mylink.add_node("节点" + str(i))
        # print(status.value)
    mylink.show_link()
    length = mylink.length()
    print(length)
    for i in range(7, 4, -1):
        status = mylink.append_value(i)
        print(status.value)
    mylink.show_link()
    length = mylink.length()
    print(length)
    status = mylink.is_empty()
    print(status)
    # for i in range(length):
    #     status = mylink.delete_node()
    #     print('删除节点', status.value)
    for i in range(length):
        status = mylink.pop_node()
        print('删除节点:', status.value)
    status = mylink.is_empty()
    print(status)
    mylink.show_link()
    length = mylink.length()
    print(length)
