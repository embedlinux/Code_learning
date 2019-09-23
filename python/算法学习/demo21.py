#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/9/23  19:56

# lis = []
# temp = ''
# str = 'ffbe8a5c6caaf995732feac25ef0eb34027d7a40b3d6c7ae04dcd273e86bf29e'
# for item in str.upper():
#     temp += item
#     if len(temp) == 8:
#         temp = '0x' + temp[6:8] + temp[4:6] + temp[2:4] + temp[0:2]
#         lis.append(temp)
#         temp = ''
# print(lis)


class Node(object):
    def __init__(self, no, name):
        self.no = no
        self.name = name
        self.left = None
        self.right = None

    def set_no(self, no):
        self.no = no

    def set_name(self, name):
        self.name = name

    def get_left(self):
        return self.left

    def set_left(self, left):
        self.left = left

    def get_right(self):
        return self.right

    def set_right(self, right):
        self.right = right

    def __str__(self):
        return "Node [no:%d, name=%s]" % (self.no, self.name)

    # 前序遍历
    def pre_order(self):
        print(self.no, self.name)
        if self.left:
            self.left.pre_order()
        if self.right:
            self.right.pre_order()

    # 中序遍历
    def mid_order(self):
        if self.left:
            self.left.mid_order()
        print(self.no, self.name)
        if self.right:
            self.right.mid_order()

    # 后序遍历
    def post_order(self):
        if self.left:
            self.left.post_order()
        if self.right:
            self.right.post_order()
        print(self.no, self.name)


class BinaryTree(object):
    def __init__(self, root = None):
        self.root = root

    def set_root(self, node):
        self.root = node

    def pre_order(self):
        if self.root:
            self.root.pre_order()
        else:
            print("当前二叉树为空,无法遍历")

    def mid_order(self):
        if self.root:
            self.root.mid_order()
        else:
            print("当前二叉树为空,无法遍历")

    def post_order(self):
        if self.root:
            self.root.post_order()
        else:
            print("当前二叉树为空,无法遍历")

    def add_node(self, node):
        temp = self.root
        if temp is None:
            pass
        else:
            pass

    def del_node(self, node):
        pass


if __name__ == "__main__":

    binary_tree = BinaryTree()
    node1 = Node(1, "Alex")
    node2 = Node(2, "Hello")
    node3 = Node(3, "Amy")
    node4 = Node(4, "Hung")
    node5 = Node(5, "Tony")
    node1.set_left(node2)
    node1.set_right(node3)
    node3.set_right(node4)
    node3.set_left(node5)

    binary_tree.set_root(node1)

    print("-----前序遍历-----")
    binary_tree.pre_order()
    node1.pre_order()
    print("-----中序遍历-----")
    binary_tree.mid_order()
    node1.mid_order()
    print("-----后序遍历-----")
    binary_tree.post_order()
    node1.post_order()

