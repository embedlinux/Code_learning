#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/9/10  20:43


class Node(object):
    def __init__(self, value):
        self.value = value
        self.next = None


class MyLink(object):
    def __init__(self, name="MyLinkList"):
        self.head = None
        self.size = 0
        self.name = name

# 头插法
    def add_node(self, value):
        node = Node(value)
        temp = self.head
        if temp is None:
            self.head = node
        else:
            node.next = temp
            self.head = node
        self.size += 1
        return node

# 显示列表元素
    def show_node(self):
        temp = self.head
        if temp is None:
            print("链表为空...")
        else:
            while temp:
                print(temp.value, end=" ")
                temp = temp.next
            print("\n")

    def __str__(self):
        return self.name

# 获取有效结点个数
    def get_size(self):
        temp = self.head
        size = 0
        while temp:
            size += 1
            temp = temp.next
        return size

# 倒数第k个结点
    def get_re_node(self, index):
        length = self.size
        lindex = length - index
        temp = self.head
        if temp is None or index <= 0 or index > length:
            return None
        else:
            for i in range(lindex):
                temp = temp.next
            return temp.value

# 单链表的反转
    def reverse_link(self):
        cur = self.head
        # 只有一个节点不需要反转
        if cur is None or cur.next is None:
            return
        # cur 当前节点; next 指向cur的下一个节点
        cur = cur.next              # cur从第二个节点开始
        next = None
        reverse_head = self.head    # 头指针
        reverse_head.next = None
        # 遍历原来的链表,霉变粒一个节点,将其取出添加到新的节点中
        while cur:
            next = cur.next                 # 保存当前节点的下一个
            cur.next = reverse_head         # cur指向下一个节点的头部
            reverse_head = cur
            cur = next                      # cur后移
        self.head = reverse_head

# 合并两个列表
    def merge_link(self, link1, link2):
        temp1 = link1.head
        temp2 = link2.head

        while temp1 and temp2:
            if temp1.value > temp2.value:
                self.add_node(temp2.value)
                temp2 = temp2.next
            else:
                self.add_node(temp1.value)
                temp1 = temp1.next
        while temp1:
            self.add_node(temp1.value)
            temp1 = temp1.next
        while temp2:
            self.add_node(temp2.value)
            temp2 = temp2.next


if __name__ == "__main__":
    # mylink = MyLink()
    # for i in range(5):
    #     value = mylink.add_node(i)
    #     print(value.value, end=' ')
    # print("\n")
    # mylink.show_node()
    # print(mylink.get_size())
    # ret = mylink.get_re_node(2)
    # print(ret)
    # mylink.reverse_link()
    # mylink.show_node()

# 逆序输出链表
#     len = mylink.size
#     for i in range(1, len + 1):
#         value = mylink.get_re_node(i)
#         print(value, end=" ")

    mylink1 = MyLink()
    for i in range(0, 10):
        if i % 2 == 0:
            value = mylink1.add_node(i)
    mylink1.reverse_link()
    mylink1.show_node()

    mylink2 = MyLink()
    for i in range(0, 20):
        if i % 2 != 0:
            value = mylink2.add_node(i)
    mylink2.reverse_link()
    mylink2.show_node()

    mylink3 = MyLink()
    mylink3.merge_link(mylink1, mylink2)
    mylink3.reverse_link()
    mylink3.show_node()
    mylink1.show_node()
    mylink2.show_node()


