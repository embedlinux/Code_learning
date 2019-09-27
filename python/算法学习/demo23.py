#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/9/27  15:42


class Node(object):
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

    def order_tree(self):
        if self.left is None and self.right is None:
            print(self.value)
        if self.left:
            self.left.order_tree()
        if self.right:
            self.right.order_tree()


def huffman_tree(array):
    while len(array) >= 2:
        node = Node(0)
        node.left = array.pop(0)
        node.right = array.pop(0)
        node.value = node.left.value + node.right.value
        for i in range(len(array)):
            if node.value > array[i].value:
                continue
            else:
                break
        array.append(node)
        array = sorted(array, key=lambda item:item.value)
        # print(array)
        # array.insert(i+1, node)
    # for i in array:
    #     print(i.value)
    # print(node.value)
    return node
    # print(array[0].value)


if __name__ == "__main__":
    lis = [13, 7, 8, 3, 29, 6, 1]
    array = [Node(i) for i in lis]
    array = sorted(array, key=lambda item:item.value)
    # for item in array:
    #     print(item.value, end=' ')
    # print(array)
    node = huffman_tree(array)
    node.order_tree()
