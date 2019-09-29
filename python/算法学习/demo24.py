#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/9/29  10:05


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

    def mid_order(self):
        if self.left:
            self.left.mid_order()
        print(self.value, end=' ')
        if self.right:
            self.right.mid_order()

    # 返回该结点的当前结点
    def find_node(self, value):
        if self.value == value:
            return self
        elif value < self.value:
            if self.left is None:
                return None
            return self.left.find_node(value)
        else:
            if self.right is None:
                return None
            return self.right.find_node(value)

    # 返回当前结点的父节点
    def find_parent_node(self, value):
        if (self.left and self.left.value == value) or (self.right and self.right.value == value):
            return self
        else:
            if self.left and value < self.value:
                return self.left.find_parent_node(value)
            elif self.right:
                return self.right.find_parent_node(value)
            else:
                return None

    # 返回当前结点和父节点
    def find_both_node(self, value):
        if (self.left and self.left.value == value) or (self.right and self.right.value == value):
            if self.left and self.left.value == value:
                return self, self.left
            elif self.right and self.right.value == value:
                return self, self.right
        else:
            if self.left and value < self.value:
                return self.left.find_both_node(value)
            elif self.right:
                return self.right.find_both_node(value)
            else:
                return None, None

    # 删除结点
    def del_node(self, parent_target, target):
        # 删除的结点为叶子节点
        if target.left is None and target.right is None:
            if parent_target.left and parent_target.left.value == target.value:
                parent_target.left = None
            else:
                parent_target.right = None
        # 删除的结点只有一个子节点
        elif target.left or target.right:
            if target.left and target.right is None:
                if parent_target.left == target:
                    parent_target.left = target.left
                elif parent_target.right == target:
                    parent_target.right = target.left
            elif target.right and target.left is None:
                if parent_target.left == target:
                    parent_target.left = target.right
                elif parent_target.right == target:
                    parent_target.right = target.right
            # 删除的结点有两个子节点
            else:
                pre = target
                temp = target.right
                while temp and temp.left:
                    pre = temp              # 父结点
                    temp = temp.left        # 需要被删除的结点
                target.del_node(pre, temp)
                target.value = temp.value


class BinarySortTree(object):
    def __init__(self):
        self.head = None
        self.left = None
        self.right = None

    def add_node(self, value):
        node = Node(value)
        temp = self.head
        if self.head is None:
            self.head = node
        else:
            temp.add_node(node)

    def mid_order(self):
        temp = self.head
        if temp is None:
            print("该二叉树没有结点，无法遍历...")
            return
        else:
            print("中序排序：")
            temp.mid_order()
            print('\n')

    def del_node(self, value):
        if self.head is None:
            print("该二叉树为空，没有结点可被删除~~~")
            return
        else:
            parent_target, target = self.head.find_both_node(value)
            if target is None:
                print("没有找到该节点")
                return
            else:
                # 删除的结点为根节点
                if parent_target is None:
                    pass
                # 删除的结点不是根结点
                else:
                    self.head.del_node(parent_target, target)

    def find_node(self, node):
        if self.head is None:
            print("该二叉树没有结点...")
            return None
        else:
            return self.head.find_node(node)

    def find_parent_node(self, node):
        if self.head is None:
            print("该二叉树没有结点...")
            return None
        else:
            if self.head.value == node:
                return None
            return self.head.find_parent_node(node)

    def find_both_node(self, node):
        if self.head is None:
            print("该二叉树没有结点...")
            return None
        else:
            if self.head.value == node:
                return None, self.head
            return self.head.find_both_node(node)


if __name__ == "__main__":
    my_tree = BinarySortTree()
    lis = [7, 3, 10, 12, 5, 1, 9, 2, 13]
    for item in lis:
        my_tree.add_node(item)
    my_tree.mid_order()
    # target = my_tree.find_node(9)
    # if target:
    #     print(target.value)
    # else:
    #     print(target)
    # print('----------------------')
    # #
    # parent_target = my_tree.find_parent_node(9)
    # if parent_target:
    #     print(parent_target.value)
    # else:
    #     print(parent_target)
    # print('----------------------')
    # parent_target, target = my_tree.find_both_node(9)
    # if parent_target:
    #     print(parent_target.value)
    # else:
    #     print(parent_target)
    # if target:
    #     print(target.value)
    # else:
    #     print(target)
    my_tree.del_node(10)
    my_tree.mid_order()


