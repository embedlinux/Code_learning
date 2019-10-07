#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/10/4  7:13


class Graph(object):
    def __init__(self, size):
        self.size = size                                                # 顶点最大数目
        self.vertex_list = []                                           # 存储顶点
        self.edges = [[0 for i in range(size)] for i in range(size)]    # 储存边
        self.num_of_edge = 0                                            # 边的数量
        self.is_visited = [False for i in range(size)]

    # 添加顶点
    def insert_vertex(self, vertex):
        self.vertex_list.append(vertex)

    # 返回顶点的数量
    def get_vertex_size(self):
        return len(self.vertex_list)

    # 添加边,无向图
    def insert_edge(self, v1, v2, weight):
        self.edges[v1][v2] = weight
        self.edges[v2][v1] = weight
        self.num_of_edge += 1

    def get_edge_size(self):
        return self.num_of_edge

    # 结点下标所对应的数据
    def get_value_by_index(self, index):
        if index >= self.size:
            print("没有该顶点")
            return
        else:
            return self.vertex_list[index]

    # 顶点对应的权值
    def get_weight(self, v1, v2):
        if v1 >= self.size or v2 >= self.size:
            print("没有这一条边...")
            return
        else:
            return self.edges[v1][v2]

    # 显示(图)矩阵
    def show_graph(self):
        for i in range(self.size):
            for j in range(self.size):
                print(self.edges[i][j], end=' ')
            print('\n')

    # 第一个邻接节点下标
    def get_first_neighbor(self, index):
        for i in range(self.size):
            if self.edges[index][i] > 0:
                return i
        # 没有邻接节点
        else:
            return -1

    # 根据前一个邻接节点下标获取下一个结点
    def get_next_neighbor(self, v1, v2):
        for i in range(v2+1, self.size):
            if self.edges[v1][i] > 0:
                return i
        else:
            return -1

    # 单个节点遍历
    def order_dfs(self, i):
        print(self.get_value_by_index(i), '-->', end='')
        self.is_visited[i] = True
        w = self.get_first_neighbor(i)

        while w != -1:
            if not self.is_visited[w]:
                self.order_dfs(w)
            w = self.get_next_neighbor(i, w)

    # 对dfs所有节点遍历
    def dfs(self):
        # 遍历所有节点进行dfs(回溯)
        print('深度优先遍历:', end='')
        for i in range(self.get_vertex_size()):
            if not self.is_visited[i]:
                self.order_dfs(i)
        print('\n')
        self.clear_is_visit()

    # 对单个节点广度优先遍历
    def order_bfs(self, i):
        lis = []                                # 队列, 记录访问节点顺序
        print(self.get_value_by_index(i), '-->', end='')
        self.is_visited[i] = True
        lis.append(i)

        while lis:
            u = lis.pop(0)                       # 队列头结点对应的下标
            w = self.get_first_neighbor(u)       # 邻接节点
            while w != -1:
                if not self.is_visited[w]:
                    print(self.get_value_by_index(w), '-->', end='')
                    self.is_visited[w] = True
                    lis.append(w)
                # 以u为前驱访问w后面的下一个邻接节点
                w = self.get_next_neighbor(u, w)

    # 对所有节点广度优先遍历
    def bfs(self):
        print('广度优先遍历:', end='')
        for i in range(self.size):
            if not self.is_visited[i]:
                self.order_bfs(i)
        print('\n')
        self.clear_is_visit()

    # 清除遍历标记
    def clear_is_visit(self):
        for index in range(len(self.is_visited)):
            self.is_visited[index] = False


if __name__ == "__main__":
    lis = ['1', '2', '3', '4', '5', '6', '7', '8']
    my_graph = Graph(8)
    my_graph.vertex_list = lis

    my_graph.insert_edge(0, 1, 1)
    my_graph.insert_edge(0, 2, 1)
    my_graph.insert_edge(1, 3, 1)
    my_graph.insert_edge(1, 4, 1)
    my_graph.insert_edge(3, 7, 1)
    my_graph.insert_edge(4, 7, 1)
    my_graph.insert_edge(2, 5, 1)
    my_graph.insert_edge(2, 6, 1)
    my_graph.insert_edge(5, 6, 1)
    my_graph.show_graph()
    my_graph.dfs()          # [1->2->4->8->5->3->6->7]
    my_graph.bfs()          # [1->2->3->4->5->6->7->8]

