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
        return "HeroNode [no:%d, name=%s]" % (self.no, self.name)

    # 前序遍历
    def pre_order(self, array=None):
        print(self.no, self.name)
        if type(array) == list:
            array.append(self.no)
            # print(array)
        if self.left:
            self.left.pre_order(array)
        if self.right:
            self.right.pre_order(array)

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

    # 前序查找
    def pre_find(self, no):
        if self.no == no:
            return self
        res = None
        if self.left:
            res = self.left.pre_find(no)
        if res:
            return res
        if self.right:
            res = self.right.pre_find(no)
        return res

    # 中序查找
    def mid_find(self, no):
        res = None
        if self.left:
            res = self.left.mid_find(no)
        if res:
            return res
        if self.no == no:
            return self
        if self.right:
            res = self.right.mid_find(no)
        return res

    # 后续查找
    def post_find(self, no):
        res = None
        if self.left:
            res = self.left.post_find(no)
        if res:
            return res
        if self.right:
            res = self.right.post_find(no)
        if res:
            return res
        if self.no == no:
            return self
        return res

    # 删除节点, 包含其子结点
    def del_nodes(self, no):
        if self.left and self.left.no == no:
            self.left = None
            return
        if self.right and self.right.no == no:
            self.right = None
            return
        if self.left:
            self.left.del_node(no)
        if self.right:
            self.right.del_node(no)

    # 删除节点
    def del_no(self, temp):
        temp_left = temp.left
        temp_right = temp.right
        if temp_left:
            while temp_left.right:
                temp_left = temp_left.right
            temp_left.right = temp_right
            return temp_left
        else:
            return temp_right

    # 删除节点但不包含其子节点
    def del_node(self, no):
        if self.left and self.left.no == no:
            node = self.left
            self.left = self.del_no(node)
        if self.right and self.right.no == no:
            node = self.right
            self.right = self.del_no(node)
        if self.left:
            self.left.del_node(no)
        if self.right:
            self.right.del_node(no)

    # 顺出存储二叉树时通常只考虑完全二叉树
    # 第n个元素的左子树节点为2*n + 1
    # 第n个元素的左子树节点为2 * n + 2
    # 第n个元素的父节点为(n-1)/2
    def to_line_pre(self, index, array):
        if array is None or len(array) == 0:
            print("数组为空, 不能按照二叉树前序遍历")
        else:
            print(array[index], end=' ')
            # 向左递归遍历
            if index*2 + 1 < len(array):
                self.to_line_pre(index*2 + 1, array)
            # 向右递归遍历
            if index*2 + 2 < len(array):
                self.to_line_pre(index*2 + 2, array)

    def to_line_mid(self, index, array):
        if array is None or len(array) == 0:
            print("数组为空, 不能按照二叉树前序遍历")
        else:
            # 向左递归遍历
            if index*2 + 1 < len(array):
                self.to_line_mid(index*2 + 1, array)
            print(array[index], end=' ')
            # 向右递归遍历
            if index*2 + 2 < len(array):
                self.to_line_mid(index*2 + 2, array)

    def to_line_post(self, index, array):
        if array is None or len(array) == 0:
            print("数组为空, 不能按照二叉树前序遍历")
        else:
            # 向左递归遍历
            if index*2 + 1 < len(array):
                self.to_line_post(index*2 + 1, array)
            # 向右递归遍历
            if index*2 + 2 < len(array):
                self.to_line_post(index*2 + 2, array)
            print(array[index], end=' ')


class BinaryTree(object):
    def __init__(self, root=None):
        self.root = root

    def set_root(self, node):
        self.root = node

    def pre_order(self, array=None):
        if self.root:
            self.root.pre_order(array)
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

    def pre_find(self, no):
        if self.root:
            return self.root.pre_find(no)
        else:
            return None

    def mid_find(self, no):
        if self.root:
            return self.root.mid_find(no)
        else:
            return None

    def post_find(self, no):
        if self.root:
            return self.root.post_find(no)
        else:
            return None

    def add_node(self, node):
        temp = self.root
        if temp is None:
            pass
        else:
            pass

    # 删除节点包含子节点
    def del_nodes(self, no):
        if self.root:
            if self.root.no == no:
                self.root = None
                return
            else:
                self.root.del_nodes(no)
        else:
            print("空树，没有结点删除...")

    # 删除节点，不包含子节点
    def del_node(self, no):
        if self.root:
            if self.root.no == no:
                if self.root.left:
                    temp_left = self.root.left
                    temp_right = self.root.right
                    self.root = temp_left
                    while temp_left.right:
                        temp_left = temp_left.right
                    temp_left.right = temp_right
                elif self.root.right:
                    self.root = self.root.right
                else:
                    self.root = None
            else:
                self.root.del_node(no)
        else:
            print("空树，没有结点可被删除...")

    def to_line_pre(self, array):
        print("前序遍历列表:")
        self.root.to_line_pre(0, array)
        print('\n')

    def to_line_mid(self, array):
        print("中序遍历列表:")
        self.root.to_line_mid(0, array)
        print('\n')

    def to_line_post(self, array):
        print("后序遍历列表:")
        self.root.to_line_post(0, array)
        print('\n')


if __name__ == "__main__":
    array = [1, 2, 3, 4, 5, 6, 7]
    binary_tree = BinaryTree()
    node1 = Node(1, "Alex")
    node2 = Node(2, "Hello")
    node3 = Node(3, "Amy")
    node4 = Node(4, "Hung")
    node5 = Node(5, "Tony")
    node6 = Node(6, "Hung")
    node7 = Node(7, "Tony")
    node1.set_left(node2)
    node1.set_right(node3)
    node2.set_left(node4)
    node2.set_right(node5)
    node3.set_left(node6)
    node3.set_right(node7)

    binary_tree.set_root(node1)

    print("-----前序遍历-----")
    binary_tree.pre_order()
    # node1.pre_order()
    print("-----中序遍历-----")
    binary_tree.mid_order()
    # node1.mid_order()
    print("-----后序遍历-----")
    binary_tree.post_order()
    # node1.post_order()
    no = 4
    res = binary_tree.pre_find(no)
    if res:
        print(res)
    else:
        print("没有找到编号%d的英雄" % no)

    # binary_tree.del_nodes(1)
    # binary_tree.post_order()
    # binary_tree.del_nodes(1)

    binary_tree.del_node(6)
    binary_tree.pre_order()
    # binary_tree.del_nodes(1)
    # print(array)
    binary_tree.to_line_pre(array)
    binary_tree.to_line_mid(array)
    binary_tree.to_line_post(array)
