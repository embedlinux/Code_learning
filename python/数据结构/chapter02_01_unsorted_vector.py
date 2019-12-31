#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/12/29  20:13

import random


class Fib(object):
    def __init__(self, n):
        self.f = 1
        self.g = 0
        while self.g < n:
            self.next()

    def get(self):
        return self.g

    def next(self):
        self.g += self.f
        self.f = self.g - self.f
        return self.g

    def pre(self):
        self.f = self.g - self.f
        self.g -= self.f
        return self.g


class UnsortedVector(object):
    def __init__(self, capacity):
        self._size = 0
        self._capacity = capacity
        self._elem = [-1 for i in range(self._capacity)]

    def insert(self, r, e):
        self.expand()
        for i in range(self._size, r, -1):
            self._elem[i] = self._elem[i-1]
        self._elem[r] = e
        self._size += 1
        return r

    def put(self, r, e):
        if 0 <= r < self._size:
            self._elem[r] = e
            return self._elem[r]
        else:
            return None

    def size(self):
        return self._size

    def get(self, r):
        if 0 <= r < self._size:
            return self._elem[r]
        return None

    def remove(self, low, high):            # 删除[low, high)区间的元素
        if low == high:
            return 0
        while high < self._size:
            self._elem[low] = self._elem[high]
            low += 1
            high + 1
        self._size = low
        return high-low                     # 返回删除元素的数目

    def disordered(self):
        pass

    def sort(self):
        case = random.randint(0, 5)
        if case == 0:
            self.bubble_sort()
        elif case == 1:
            self.selection_sort()
        elif case == 2:
            self.merge_sort()
        elif case == 3:
            self.heap_sort()
        else:
            self.quick_sort()

    def bubble_sort(self):
        pass

    def selection_sort(self):
        pass

    def heap_sort(self):
        pass

    def quick_sort(self):
        pass

    def merge_sort(self):
        pass

    def find(self, e, low, high):
        while low < high and e != self._elem[high]:     # 逆向查找
            high -= 1
        return high

    def search(self, e, low, high):
        return self.bin_search(e, low, high) if random.randint(0, 2) % 2 else self.fib_search(e, low, high)

    # 返回不大于e的最后一个元素
    def bin_search(self, e, low, high):
        while low < high:
            mid = (low + high) // 2
            if e < self._elem[mid]:
                high = mid
            else:
                low = mid + 1
        low -= 1
        return low

    def fib_search(self, e, low, high):
        fib = Fib(high-low)
        while low < high:
            while high - low < fib.get():
                fib.pre()
            mid = low + fib.get() - 1
            if e < self._elem[mid]:
                high = mid
            elif self._elem[mid] < e:
                low = mid + 1
            else:
                return mid
        return -1

    def deduplicate(self):
        old_size = self._size
        i = 1
        while i < self._size:
            i += 1 if self.find(self._elem[i], 0, i) < 0 else self.remove(i)
        return old_size - self._size

    def uniquify(self):
        i = 0
        j = 1
        while j < self._size:
            if self._elem[i] != self._elem[j]:
                i += 1
                self._elem[i] = self._elem[j]
            j += 1
        i += 1
        self._size = i
        return j - i                  # 被删除元素的总数

    def traverse(self):
        for i in range(self._size):
            print(self._elem[i], end=' ')
        print('\n')

    def expand(self):
        if self._size < self._capacity:
            return
        old_elem = self._elem
        self._elem = [-1 for i in range(self._capacity*2)]
        for i in range(self._size):
            self._elem[i] = old_elem[i]


if __name__ == "__main__":
    vector = UnsortedVector(10)
    for i in range(10):
        e = random.randint(0, 100)
        vector.insert(i, e)
    vector.traverse()

    ret = vector.fib_search(10, 0, vector.size())
    # vector.traverse()
    print(ret)
