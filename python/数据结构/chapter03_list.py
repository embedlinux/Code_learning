#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2020/1/2  21:42


class ListNode(object):
    def __init__(self, data=None, p=None, s=None):
        self.data = data
        self.pred = p        # 前驱
        self.next = s        # 后继

    def insert_as_pred(self, e):    # 前插入
        x = ListNode(e, self.pred, self)
        self.pred.next = x
        self.pred = x
        return x

    def insert_as_next(self, e):    # 后插入
        x = ListNode(e, self, self.next)
        self.next.pred = x
        self.next = x
        return x


class List(object):
    def __init__(self):
        self._size = 0
        self.header = ListNode()            # 头哨兵
        self.trailer = ListNode()           # 尾哨兵
        self.header.next = self.trailer
        self.trailer.pred = self.header

    def size(self):
        return self._size

    def first(self):
        if self.header.next.data is None:
            return None
        else:
            return self.header.next

    def last(self):
        if self.trailer.pred.data is None:
            return None
        else:
            return self.trailer.pred

    def insert_as_first(self, e):           # e当作首节点插入
        self._size += 1
        return self.header.insert_as_next(e)

    def insert_as_last(self, e):
        self._size += 1
        return self.trailer.insert_as_pred(e)

    def insert_before(self, p, e):      # p之前插入e
        self._size += 1
        return p.insert_as_pred(e)

    def insert_after(self, p, e):       # p之后插入e
        self._size += 1
        return p.insert_as_next(e)

    def copy_nodes(self, p, n):
        x = List()
        while n:
            x.insert_as_last(p.data)
            p = p.next
            n -= 1
        return x

    def remove(self, p):
        e = p.data
        p.pred.next = p.next
        p.next.pred = p.pred
        p.pred = None
        p.next = None
        self._size -= 1
        return e

    def disordered(self):
        pass

    def sort(self):
        pass

    def find(self, e, n=self._size, p=self.trailer):
        # n = self._size
        # p = self.trailer
        while 0 < n:
            p = p.pred
            if e == p.data:
                return p
            n -= 1
        return None

    def search(self):
        pass

    def deduplicate(self):
        if self._size < 2:
            return 0
        old_size = self._size
        p = self.first()
        r = 1
        while self.trailer != p.next:
            q = self.find(p.data, r, p)
            self.remove(q) if q else r += 1
        return old_size - self._size

    def uniquify(self):
        pass

    def traverse(self):
        p = self.header.next
        while p != self.trailer:
            print(p.data)
            p = p.next

    def clear(self):
        old_size = self._size
        while 0 < self._size:
            self.remove(self.header.next)
        return old_size


if __name__ == "__main__":
    pass
