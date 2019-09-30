#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/9/29  21:48


class Node(object):
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

    def add_node(self, node):
        if self.value >= node.value:
            if self.left is None:
                self.left = node
            else:
                self.left.add_node(node)
        else:
            if self.right is None:
                self.right = node
            else:
                self.right.add_node(node)
        # 左旋转
        if self.right_height() - self.left_height() > 1:
            if self.right and self.right.left_height() > self.right.right_height():
                # 1.当前结点的右子结点进行右旋转
                self.right.rotate_right()
                # 2.当前结点进行左旋转
                self.rotate_left()
            else:
                self.rotate_left()
            # 处理完直接结束
            return

        # 右旋转
        if self.left_height() - self.right_height() > 1:
            # print(self.node_height())
            # print(self.left_height())
            # print(self.right_height())
            # print(self.left.right_height(), self.left_height())
            # 左子树的右子树高度大于左子树的左子树高度
            if self.left and self.left.right_height() > self.left.left_height():
                # 1.当前结点的左子结点进行左旋转
                self.left.rotate_left()
                # 2.当前结点进行右旋转
                self.rotate_right()
            else:
                self.rotate_right()

    def mid_order(self):
        if self.left:
            self.left.mid_order()
        print(self.value, end=' ')
        if self.right:
            self.right.mid_order()

    def node_height(self):
        return max(self.left.node_height() if self.left else 0,
                   self.right.node_height() if self.right else 0) + 1

    def left_height(self):
        if self.left:
            return self.left.node_height()
        else:
            return 0

    def right_height(self):
        if self.right:
            return self.right.node_height()
        else:
            return 0

    def rotate_left(self):
        # 1.创建新结点
        new_node = Node(self.value)
        # 2.新结点的左子树设置为当前结点的左子树
        if self.left:
            new_node.left = self.left
        # 3.新结点的右子树设置为当前结点的右子树的左子树
        if self.right and self.right.left:
            new_node.right = self.right.left

        # 4.当前结点的值换为右子节点的值
        self.value = self.right.value
        # 5.当前结点的右子树换成右子树的右子树
        self.right = self.right.right
        # 6.当前结点的左子树设为新的结点
        self.left = new_node

    def rotate_right(self):
        # 1.创建新结点
        new_node = Node(self.value)
        # 2.新结点的右子树设置为当前结点的右子树
        if self.right:
            new_node.right = self.right
        # 3.新结点的左子树设置为当前结点的左子树的右子树
        if self.left and self.left.right:
            new_node.left = self.left.right
        # 4.当前结点的值换为左子节点的值
        self.value = self.left.value
        # 5.当前结点的左子树换成左子树的左子树
        self.left = self.left.left
        # 6.当前结点的右子树设为新的结点
        self.right = new_node

    def rotate_double(self):
        # 1.当前结点的左子结点进行坐旋转
        self.left.rotate_left()
        # 2.当前结点进行右旋转
        self.rotate_right()


class AvlTree(object):
    def __init__(self):
        self.head = None

    def get_root(self):
        return self.head

    def add_node(self, value):
        node = Node(value)
        temp = self.head
        if temp is None:
            self.head = node
        else:
            temp.add_node(node)

    def mid_order(self):
        temp = self.head
        if temp is None:
            print("该二叉树为空，无法遍历~~~")
            return
        else:
            print("中序遍历该二叉树：", end='')
            temp.mid_order()
        print('\n')

    @staticmethod
    def tree_height(node):
        return node.node_height()

    @staticmethod
    def left_height(node):
        return node.left_height()

    @staticmethod
    def right_height(node):
        return node.right_height()


if __name__ == "__main__":
    # array = [4, 3, 6, 5, 7, 8]
    # array = [10, 12, 8, 9, 7, 6]
    array = [10, 11, 7, 6, 8, 9]
    my_tree = AvlTree()
    for item in array:
        my_tree.add_node(item)
    my_tree.mid_order()
    root = my_tree.get_root()
    print("树的高度：", my_tree.tree_height(root))
    print('树的左子树高度：', my_tree.left_height(root))
    print('树的右子树高度：', my_tree.right_height(root))
    print('当前根节点：', my_tree.get_root().value)
