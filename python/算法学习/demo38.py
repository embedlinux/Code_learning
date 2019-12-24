#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/12/23  16:40


class BinaryTreeNode(object):
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None


class TrieNode(object):
    def __init__(self, data):
        self.data = data
        self.children = [None for i in range(26)]
        self.isEndingChar = False


class Trie(object):
    def __init__(self):
        self.root = TrieNode('/')

    # 往Trie树中插入一个字符串
    def insert(self, text):
        p = self.root
        for i in range(len(text)):
            index = ord(text[i]) - ord('a')
            # print(index)
            if p.children[index] is None:
                new_node = TrieNode(text[i])
                p.children[index] = new_node
            p = p.children[index]
        p.isEndingChar = True

    # 在Trie树中查找一个字符串
    def find(self, pattern):
        p = self.root
        for i in range(len(pattern)):
            index = ord(pattern[i]) - ord('a')
            if p.children[index] is None:
                return False
            p = p.children[index]
        if p.isEndingChar is False:
            return False
        else:
            return True


if __name__ == "__main__":
    my_trie = Trie()
    my_trie.insert('hello')
    my_trie.insert('her')
    ret = my_trie.find('her')
    print(ret)
