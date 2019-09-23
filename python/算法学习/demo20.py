#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/9/23  15:50

'''
散列表（Hash table，也叫哈希表），是根据关键码值(Key value)而直接进行访问的数据结构。也就是说，
它通过把关键码值映射到表中一个位置来访问记录，以加快查找的速度。这个映射函数叫做散列函数，存放记录的数组叫做散列表
'''


# 链表中的元素, 雇员
class EmpNode(object):
    def __init__(self, id, name, address='xxx'):
        self.id = id
        self.name = name
        self.address = address
        self.next = None


# 链表, 雇员链表
class ListList(object):
    def __init__(self):
        self.head = None
        self.size = 0

    def add_node(self, emp):
        temp = self.head
        if temp is None:
            self.head = emp
        else:
            while temp.next:
                temp = temp.next
            temp.next = emp
        self.size += 1
        return emp

    def del_node(self, id):
        temp = self.head
        if temp is None:
            print("没有找到id为%d的员工，删除失败..." % id)
        else:
            if temp.id == id:
                self.head = temp.next
                print("删除id为%d的员工，删除成功" % id)
            else:
                while temp.next:
                    if temp.next.id == id:
                        temp.next = temp.next.next
                        print("删除id为%d的员工，删除成功" % id)
                        break
                    else:
                        temp = temp.next
                else:
                    print("没有找到id为%d的员工，删除失败..." % id)

    def list_node(self):
        temp = self.head
        if temp is None:
            print("该链表为空")
        else:
            while temp:
                print("id = %d, name = %s, address = %s" % (temp.id, temp.name, temp.address))
                temp = temp.next

    def find_node(self, id):
        temp = self.head
        if temp is None:
            # print("该链表为空，无法找到该元素")
            print("没有找到该元素")
            return
        else:
            while temp:
                if temp.id == id:
                    print("找到该元素:id = %d,name= %s, address = %s" % (temp.id, temp.name, temp.address))
                    return id
                else:
                    temp = temp.next
            else:
                print("没有找到该元素")
                return


# 哈希表,每个元素都是一个链表
class MyHashTable(object):
    def __init__(self, num):
        self.num = num
        self.lis = []
        for i in range(num):
            li = ListList()
            self.lis.append(li)

    def show_hash_table(self):
        for i in range(self.num):
            print(self.lis[i])

    def add_item(self, item):
        list_num = self.hash_fun(item)
        self.lis[list_num].add_node(item)

    def del_item(self, id):
        lis_num = id % self.num
        self.lis[lis_num].del_node(id)

    def find_item(self, id):
        lis_num = id % self.num
        self.lis[lis_num].find_node(id)

    def list_item(self):
        for index in range(self.num):
            print("当前遍历第%d条链表:" % (index+1))
            self.lis[index].list_node()

    def hash_fun(self, item):
        return item.id % self.num


if __name__ == "__main__":
    hash_table = MyHashTable(7)
    # hash_table.show_hash_table()
    for i in range(14):
        item = EmpNode(i, "Hello" + str(i))
        hash_table.add_item(item)
    # hash_table.list_item()
    hash_table.find_item(12)
    hash_table.del_item(12)
    hash_table.del_item(5)
    hash_table.list_item()
    hash_table.del_item(14)

