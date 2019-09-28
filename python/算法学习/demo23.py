#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/9/27  15:42

import struct


class Node(object):
    def __init__(self, value, char=None):
        self.value = value
        self.char = char
        self.code = ''
        self.left = None
        self.right = None

    def order_tree(self):
        if self.left is None and self.right is None:
            print(self.value)
        if self.left:
            self.left.order_tree()
        if self.right:
            self.right.order_tree()

    # 如何获取编码
    def get_code(self, temp='', code_dic=None):
        if self.left is None and self.right is None:
            # print("字符%s的编码为:%s" % (self.char, temp))
            code_dic[self.char] = temp

        if self.left:
            temp += '0'
            self.left.get_code(temp, code_dic)
            temp = temp[0:-1]                      # 递归出来后,去掉添加的编码
        if self.right:
            temp += '1'
            self.right.get_code(temp, code_dic)
            temp = temp[0:-1]                      # 递归出来后,去掉添加的编码

    # 生成霍夫曼编码
    def get_str_code(self, str, code_dic):
        '''
        :param str:需要编码的字符串
        :param byte_code:编码后的字节码
        :param code_dic: 编码表
        :return:
        '''
        bytes_code = ''
        for item in str:
            print(code_dic[item], end='')
            bytes_code += code_dic[item]
        print('\n')
        return bytes_code

    # 将binary转换成字节
    def bin_to_bytes(self, bins):
        str_bytes = ''
        for i in range(0, len(bins), 8):
            # print(bins[i:i+4])
            if i+8 > len(bins):
                temp = int(bins[i:], 2)
            else:
                temp = int(bins[i:i+8], 2)
            print(temp, end=' ')
            str_bytes += chr(temp)
        print('\n')
        # print(str_bytes)
        return str_bytes

    @classmethod
    def huffman_zip(cls, str):
        array = Node.get_code_array(str)
        code_dic = {}
        node = huffman_tree(array)
        node.get_code(code_dic=code_dic)
        bin_code = node.get_str_code(str, code_dic)
        bytes_code = node.bin_to_bytes(bin_code)
        return bytes_code, code_dic

    @classmethod
    def huffman_unzip(cls, bytes_code, code_dic):
        decode_dic = {}
        res = ''
        decode_bin = ''
        for key, value in code_dic.items():
            decode_dic[value] = key
        # print(decode_dic)

        for index in range(len(bytes_code)-1):
            temp = ord(bytes_code[index])
            # print(temp, end=' ')
            temp_bin = bin(temp).replace('0b', '').zfill(8)
            decode_bin += temp_bin
            # print(temp_bin, end='')
        temp = ord(bytes_code[-1])
        temp_bin = bin(temp).replace('0b', '')
        decode_bin += temp_bin
        # print(temp_bin, end='')
        # print(decode_bin)

        temp = ''
        for item in decode_bin:
            temp += item
            if temp in decode_dic.keys():
                print(decode_dic[temp], end='')
                res += decode_dic[temp]
                temp = ''
        print('\n')
        return res

    @classmethod
    # 获得huffman编码表
    def get_code_array(cls, str):
        for item in str:
            if item in dic.keys():
                dic[item] += 1
            else:
                dic[item] = 1
        # print(dic)
        array = []
        for key, value in dic.items():
            # print(key, value)
            array.append(Node(value, key))
        array = sorted(array, key=lambda item: item.value)
        return array


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


def zip_file(src_file, dst_file):
    with open(src_file, "r") as f1:
        src = f1.read()

    dst, code_dic = Node.huffman_zip(src)
    huffman_code_len = struct.pack(">I", code_dic)
    with open(dst_file, "wb") as f2:
        f2.write(huffman_code_len)      # 编码表长度
        f2.write(code_dic)              # 编码表
        f2.write(dst)                   # 压缩后的数据


def upzip_file(src_file, dst_file):
    with open(src_file, "r") as f1:
        code_len = struct.unpack(f2.read(4))            # 编码表长度
        code_dic = f2.read(code_len)                       # 编码表
        src = f2.read()                                 # 压缩后的数据

    dst = Node.huffman_unzip(str, code_dic)
    with open(dst_file, "wb") as f2:
        f2.write(dst)


if __name__ == "__main__":
    lis = [13, 7, 8, 3, 29, 6, 1]
    array = [Node(i) for i in lis]
    array = sorted(array, key=lambda item: item.value)
    # for item in array:
    #     print(item.value, end=' ')
    # print(array)
    node = huffman_tree(array)
    node.order_tree()
    print('----------------------------')

    # dic = {'d': 1, 'y': 1, 'u': 1, 'j': 2, 'v': 2, 'o': 2, 'l': 4, 'k': 4, 'e': 4, 'i': 5, 'a': 5, ' ': 9}
    dic = {}
    code_dic = {}
    str = 'i like like like java do you like a java'
    array = Node.get_code_array(str)
    # print(array)

    # 生成霍夫曼树
    node = huffman_tree(array)
    # node.order_tree()
    node.get_code(code_dic=code_dic)
    # print(node.value)
    print("哈夫曼树编码:")
    print(code_dic)

    print("编码后的asicc字节码:")
    bin_code = node.get_str_code(str, code_dic)
    # print(bin_code)

    # print("编码后的长度:")
    # print(len(bin_code))

    # 转换为字符码存储
    print("二进制转十进制编码后存储:")
    bytes_code = node.bin_to_bytes(bin_code)

    # 转换为10进制ASCII码显示
    # for i in bytes_code:
    #     print(ord(i), end=' ')
    # print(len(bytes_code))

    print('----------------------------------------')

    # 编码
    print("编码后的数据:")
    bytes_code, code_dic = Node.huffman_zip(str)

    # 解码
    print("解码后的数据:")
    Node.huffman_unzip(bytes_code, code_dic)

    # 压缩解压文件没有测试~~~~~
