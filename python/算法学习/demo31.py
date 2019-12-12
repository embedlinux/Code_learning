#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/12/12  10:12

# 当结点从0开始计数时：
#   如果节点的下标是i，
#   左子节点的下标就是2*i+1，
#   右子节点的下标就是2*i+2，
#   父节点的下标就是frac{i-1}{2}


class MyHeap(object):
    def __init__(self, capacity):
        self.capacity = capacity
        self.lis = [-1 for i in range(self.capacity + 1)]
        self.count = 0

    def insert(self, value):
        if self.count >= self.capacity:
            print("堆已满")
            return
        # 起始元素从零开始
        self.count += 1
        self.lis[self.count] = value
        temp = self.count
        # 自下往上堆化
        while temp//2 and self.lis[temp] > self.lis[temp//2]:
            self.lis[temp], self.lis[temp//2] = self.lis[temp//2], self.lis[temp]
            temp = temp // 2

    def remove_max(self):
        if self.count == 0:
            return
        self.lis[1] = self.lis[self.count]
        self.count -= 1
        self.heapify(self.count, 1)

    # 自上往下堆化
    def heapify(self, num, temp):
        while True:
            max_pos = temp
            if temp * 2 <= num and self.lis[temp] < self.lis[temp * 2]:
                max_pos = temp * 2
            if temp * 2 + 1 < num and self.lis[max_pos] < self.lis[temp * 2 + 1]:
                max_pos = temp * 2 + 1
            if max_pos == temp:
                break
            self.lis[temp], self.lis[max_pos] = self.lis[max_pos], self.lis[temp]
            temp = max_pos

    def build_heap(self, num):
        for item in range(num // 2, 0, -1):
            self.heapify(num, item)

    def print_heap(self):
        print(self.lis[1:self.count + 1])

    def sort(self):
        self.build_heap(self.count)
        print(self.lis[1], end=' ')
        k = self.count
        while k > 1:
            self.lis[1], self.lis[k] = self.lis[k], self.lis[1]
            k -= 1
            self.heapify(k, 1)
            print(self.lis[1], end=' ')
        print('\n')


if __name__ == "__main__":
    heap = MyHeap(10)
    heap.print_heap()
    for i in range(11):
        heap.insert(i)
    heap.print_heap()
    # heap.remove_max()
    # heap.print_heap()
    heap.sort()
