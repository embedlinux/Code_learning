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

    def selection_sort(self, p=self.head, n=self._size):
        head = p
        tail = p
        for i in range(n):
            tail = tail.next
            while 1 < n:
                ret = self.remove(self.select_max(head.next, n))
                self.insert_before(tail, ret)
                tail = tail.pred
                n -= 1

    def insert_sort(self, p=self.head, n=self._size):
        for r in range(n):
            self.insert_after(self.search(p.data, r, p), p.data)
            p = p.next
            self.remove(p.pred)

    def select_max(self, p, n):
        max_node = p
        cur = p.next
        for i in range(n, 0, -1):
            if cur.data >= max_node.data:
                max_node = cur
            cur = cur.next
        return max_node

    def merge_sort(self, p=self.head, n=self._size):
        if n < 2:
            return
        q = p
        m = n // 2
        for i in range(m):
            q = q.next
        self.merge_sort(p, m)
        self.merge_sort(q, n-m)
        self.merge(p, m, self, q, n-m)

    def merge(self, p, n, l, q, m):
        while 0 < m:
            if 0 < n and p.data <= q.data:
                p = p.next
                if q == p:
                    break
                n -= 1
            else:
                q = q.next
                self.insert_before(p, l.remove(q.pred))
                m -= 1


    def find(self, e, n=self._size, p=self.trailer):
        # n = self._size
        # p = self.trailer
        while 0 < n:
            p = p.pred
            if e == p.data:
                return p
            n -= 1
        return None

    def search(self, e, n=self._size, p=self.trailer):       # 在有序列表内节点p的n个前驱中,找到不大于e的最后者
        p = p.pred
        while 0 < n:
            if p.data <= e:
                break
            p = p.pred
            n -= 1
        return p

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
        if self._size < 2:
            return 0
        old_size = self._size
        p = self.first()            # p 为各区段起点
        q = p.next                  # q 为其后继
        while self.trailer != q:
            if p.data != q.data:
                p = q
            else:
                self.remove(q)
        return old_size - self._size

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
