#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/9/11  22:16


class Node(object):
    def __init__(self, value):
        self.value = value
        self.pre = None
        self.next = None


class DoubleLinkList(object):
    def __init__(self, name = "MyDoubleLinkList"):
        self.head = None
        self.size = 0
        self.name = name

# 添加节点到头部
    def add_node(self, value):
        temp = self.head
        node = Node(value)
        if temp is None:
            pass
        else:
            node.next = temp
            temp.pre = node
        self.head = node
        self.size += 1
        return node.value

# 添加节点到尾部
    def append_node(self, value):
        temp = self.head
        node = Node(value)
        if temp is Node:
            self.head = node
        else:
            while temp.next:
                temp = temp.next
            temp.next = node
            node.pre = temp
        self.size += 1
        return node.value

# 删除指定数值节点
    def del_node(self, value):
        temp = self.head
        # 链表为空
        if temp is None:
            print("链表为空")
            return
        # 删除第一个节点
        elif temp.value == value:
            self.head = temp.next
            if self.head:
                self.head.pre = None
            self.size -= 1
            return value
        flag = False
        while temp:
            if temp.value == value:
                flag = True
                break
            else:
                temp = temp.next
        if flag:
            temp.pre.next = temp.next
            if temp.next:
                temp.next.pre = temp.pre
            self.size -= 1
            return value
        else:
            print("未找到该节点")
            return

# 删除指定位置的节点
    def del_pos_node(self, index):
        pass

# 显示链表中的节点
    def show_node(self):
        temp = self.head
        while temp:
            print(temp.value, end=' ')
            temp = temp.next
        print('\n')

# 显示链表大小
    def link_size(self):
        return self.size

    def __str__(self):
        return self.name


if __name__ == "__main__":
    mylink = DoubleLinkList()
    for i in range(5):
        value = mylink.add_node(i)
    mylink.show_node()
    print("\n")
    # size = mylink.link_size()
    # print(size)
    for i in range(1, 5):
        value = mylink.append_node(i)
    mylink.show_node()
    print('\n', mylink.size)
    mylink.del_node(4)
    mylink.show_node()
    mylink.del_node(5)
    mylink.del_node(4)
    mylink.show_node()

    mylink.del_node(0)
    mylink.show_node()