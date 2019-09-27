#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Auther:
# @Time    :2019/9/27  15:42


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
        return bytes_code

    # 将binary转换成字节
    def bin_to_bytes(self, bins):
        str_bytes = ''
        # len_bytes = len(bins) // 7 + 1
        # if len(bins) % 8 == 0:
        #     len_bytes = len(bins) // 8
        # else:
        #     len_bytes = len(bins) // 8 + 1
        # print(len(bins))
        # print(bins)
        for i in range(0, len(bins), 8):
            # print(bins[i:i+4])
            if i+8 > len(bins):
                temp = int(bins[i:], 2)
            else:
                temp = int(bins[i:i+8], 2)
            # print(hex(temp).replace('0x', ''))
            # str_bytes += hex(temp).replace('0x', '')
            # print(temp, end=' ')
            str_bytes += chr(temp)
        # print(str_bytes)
        return str_bytes
        # print(a)


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


if __name__ == "__main__":
    lis = [13, 7, 8, 3, 29, 6, 1]
    array = [Node(i) for i in lis]
    array = sorted(array, key=lambda item:item.value)
    # for item in array:
    #     print(item.value, end=' ')
    # print(array)
    node = huffman_tree(array)
    node.order_tree()
    print('----------------------------')

    dic = {'d': 1, 'y': 1, 'u': 1, 'j': 2, 'v': 2, 'o': 2, 'l': 4, 'k': 4, 'e': 4, 'i': 5, 'a': 5, ' ': 9}
    code_dic = {}
    str = 'i like like like java do you like a java'
    array = []
    for key, value in dic.items():
        # print(key, value)
        array.append(Node(value, key))
    array = sorted(array, key=lambda item:item.value)
    node = huffman_tree(array)
    # node.order_tree()
    node.get_code(code_dic=code_dic)
    # print(node.value)
    print("哈夫曼树编码:")
    print(code_dic)
    print("编码后的字节码:")
    bin_code = node.get_str_code(str, code_dic)
    # print(bin_code)
    print("编码后的长度:")
    print(len(bin_code))
    # 转换为字符码存储
    bytes_code = node.bin_to_bytes(bin_code)

    # 转换为10进制编码
    for i in bytes_code:
        print(ord(i), end=' ')
    # print(len(bytes_code))
