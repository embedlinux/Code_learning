#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/12/16  10:58

# 图


class Edge(object):
    def __init__(self, name):
        self.name = name
        self.next = None

    def add_node(self, ver):
        node = Edge(ver)
        # print('self = ', self.name)
        # print('ver = ', node.name)
        temp = self
        while temp and temp.next:
            temp = temp.next
        temp.next = node


# 无向图
class MyGraph(object):
    def __init__(self, size):
        self.size = size    # 顶点个数
        self.adj = [None for i in range(size)]
        self.count = 0

    # 无向图，边需要添加两次
    def add_edge(self, s, t):
        count = 0
        for index, item in enumerate(self.adj):
            if item.name == s:
                # print('index= ', self.adj[index].name)
                self.adj[index].add_node(t)
                count += 1
            if item.name == t:
                self.adj[index].add_node(s)
                count += 1
            if count == 2:
                break

    def add_vertex(self, ver):
        if self.count >= self.size:
            print("无法在添加顶点~")
            return
        else:
            vertex = Edge(ver)
            self.adj[self.count] = vertex
            self.count += 1

    # 广度优先
    def bfs(self, s, t):
        if s == t:
            return
        visited = {}
        for item in self.adj:
            visited[item.name] = False
        # 存储已经被访问、但相连的顶点还没有被访问的顶点
        my_queue = []
        my_queue.append(s)
        count = 0
        while len(my_queue) != 0:
            w = my_queue.pop()
            if not visited[w]:
                print(w, end=' ')
                visited[w] = True
                count += 1
                if count == self.size:
                    break
            # if w == t:
            #     break
            for item in self.adj:
                if item.name == w:
                    temp = item.next
                    while temp:
                        my_queue.insert(0, temp.name)
                        temp = temp.next
                    break
        print('\n')

    # 深度优先
    def dfs(self, s, t):
        visited = {}
        found = False
        for item in self.adj:
            visited[item.name] = False
        self.recur_dfs(s, t, visited, found)
        print('\n')

    def recur_dfs(self, w, t, visted, found=False):
        if found is True:
            return
        if not visted[w]:
            print(w, end=' ')
        if w == t:
            found = True
            return
        visted[w] = True
        if w == t:
            return
        for item in self.adj:
            if item.name == w:
                temp = item
                while temp and temp.next and visted[temp.name]:
                    temp = temp.next
                self.recur_dfs(temp.name, t, visted, found)

    def list_graph(self):
        for item in self.adj:
            temp = item
            while temp:
                print(temp.name, end=' ')
                temp = temp.next
            print('\n')


if __name__ == "__main__":
    my_graph = MyGraph(8)
    lis = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
    for i in lis:
        my_graph.add_vertex(i)
    # my_graph.list_graph()
    my_graph.add_edge('A', 'B')
    my_graph.add_edge('A', 'D')
    my_graph.add_edge('B', 'C')
    my_graph.add_edge('B', 'E')
    my_graph.add_edge('C', 'F')
    my_graph.add_edge('D', 'E')
    my_graph.add_edge('E', 'F')
    my_graph.add_edge('E', 'G')
    my_graph.add_edge('F', 'H')
    my_graph.add_edge('G', 'H')
    my_graph.list_graph()
    my_graph.bfs('C', 'H')
    my_graph.dfs('A', 'H')

