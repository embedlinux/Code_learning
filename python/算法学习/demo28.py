#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/11/24  18:57

# 单链表反转
# 链表中环的检测
# 两个有序的链表合并
# 删除链表倒数第n个结点
# 求链表的中间结点


class Node(object):
    def __init__(self, value, name="node"):
        self.name = name
        self.value = value
        self.next = None


class LinkList(object):
    def __init__(self):
        self.size = 0
        self.head = None

# 链表头节点
    def link_head(self):
        return self.head

# 设置头结点
    def set_head(self, head):
        self.head = head

# 添加节点
    def add_node(self, value):
        name = "node" + str(self.size + 1)
        node = Node(value, name=name)
        temp = self.head
        if self.head is None:
            self.head = node
            self.size += 1
        else:
            while temp.next:
                temp = temp.next
            temp.next = node
            self.size += 1
        return value

# 显示链表所有节点
    def show_list(self):
        temp = self.head
        if temp is None:
            print("该链表为空~~")
        else:
            print('------------show link list node---------------')
            while temp:
                print("node name = %s, name value = %s" % (temp.name, temp.value))
                temp = temp.next

# 单链表反转
    def reverse_list(self):
        temp = self.head
        # 该链表为空
        if temp is None:
            print("链表为空~~")
            return
        new_head = temp
        cur = None
        temp = temp.next
        # 该链表只有一个结点,无需反转
        if temp is None:
            return
        new_head.next = None
        while temp.next:
            cur = temp
            temp = temp.next
            cur.next = new_head
            new_head = cur
        temp.next = new_head
        new_head = temp
        self.head = new_head

    # 链表中环的检测
    def check_cycle(self):
        low_temp = self.head
        fast_temp = self.head
        if low_temp is None:
            print("该链表为空~~")
            return False
        while fast_temp and fast_temp.next:
            low_temp = low_temp.next
            fast_temp = fast_temp.next.next
            if low_temp == fast_temp:
                print("该链表存在环~~")
                return True
        else:
            print("该链表没有环~~")
            return False

    # 设置链表结尾指向
    def set_cycle(self):
        temp = self.head
        while temp.next:
            temp = temp.next
        temp.next = self.head.next

    # 合并两个链表
    @classmethod
    def merge_link_list(cls, link1, link2):
        new_head = None
        new_temp = None
        temp1 = link1.link_head()
        temp2 = link2.link_head()
        # 两个链表都不为空
        if temp1 and temp2:
            if temp1.value > temp2.value:
                new_head = temp2
                temp2 = temp2.next
            else:
                new_head = temp1
                temp1 = temp1.next
            new_temp = new_head

        # 两个链表比较
        while temp1 and temp2:
            if temp1.value > temp2.value:
                new_temp.next = temp2
                temp2 = temp2.next
            else:
                new_temp.next = temp1
                temp1 = temp1.next
            new_temp = new_temp.next

        if temp1:
            new_temp.next = temp1

        if temp2:
            new_temp.next = temp2
        link1.set_head(new_head)


if __name__ == "__main__":
    mylist = LinkList()
    for i in range(10):
        if i % 2:
            mylist.add_node(i)
    mylist.show_list()
    # mylist.reverse_list()
    # mylist.show_list()
    mylist.check_cycle()
    # mylist.set_cycle()
    # mylist.check_cycle()

    mylist2 = LinkList()
    for i in range(20):
        if i % 2 == 0:
            mylist2.add_node(i)
    mylist2.show_list()
    LinkList.merge_link_list(mylist, mylist2)
    mylist.show_list()