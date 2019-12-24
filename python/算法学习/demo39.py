#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/12/24  15:43


class AcNode(object):
    def __init__(self, data):
        self.children = [None for i in range(26)]   # 字符集只包含a~z这26个字符
        self.isEndingChar = False                   # 结尾字符为true
        self.length = -1                            # 当isEndingChar=true时，记录模式串长度
        self.fail = None
        self.data = data


class Ac(object):
    def __init__(self):
        self.root = AcNode('/')

    # 构建fail指针
    def build_failure_pointer(self):
        self.root.fail = None
        queue = []
        queue.append(self.root)
        while len(queue) > 0:
            p = queue.pop()
            if p is None:
                continue
            for i in range(26):
                pc = p.children[i]
                if pc is None:
                    continue
                if p == self.root:
                    pc.fail = self.root
                else:
                    q = p.fail
                    while q is not None:
                        qc = q.children[ord(pc.data) - ord('a')]
                        if qc is not None:
                            pc.fail = qc
                            break
                        q = q.fail
                    if q is None:
                        q = q.fail
            queue.insert(0, pc)

    # 匹配
    def match(self, text):
        n = len(text)
        p = self.root
        for i in range(n):
            idx = ord(text[i]) - ord('a')
            while p and p.children[idx] is None and p is not self.root:
                p = p.fail
            if p is None:
                continue
            p = p.children[idx]
            if p is None:
                p = self.root
            tmp = p
            while tmp != self.root and tmp is not None:
                if tmp.isEndingChar is True:
                    # pos = i - tmp.length + 1
                    pos = i - tmp.length + 1
                    print("匹配起始下标{};长度{}".format(pos, tmp.length))
                    return
                tmp = tmp.fail
        else:
            print("没有匹配")
            return

    # 往Trie树中插入一个字符串
    def insert(self, text):
        p = self.root
        for i in range(len(text)):
            index = ord(text[i]) - ord('a')
            # print(index)
            if p.children[index] is None:
                new_node = AcNode(text[i])
                p.children[index] = new_node
            p = p.children[index]
        p.isEndingChar = True
        p.length = len(text)


if __name__ == "__main__":
    my_ac = Ac()
    my_ac.insert('abce')
    my_ac.insert('bcd')
    my_ac.insert('ce')
    my_ac.build_failure_pointer()
    my_ac.match('abce')





