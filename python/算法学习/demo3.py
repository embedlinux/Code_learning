#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/9/7  11:13
# 矩阵乘法的Strassen运算


def square_matrix_multiply(A, B):
    rows_a = len(A)
    cols_a = len(A[0])
    cols_b = len(B[0])
    # print(rows_a, cols_b)
    C = [[0 for i in range(cols_b)] for j in range(rows_a)]
    # print(C)
    for i in range(rows_a):
        for j in range(cols_b):
            C[i][j] = 0
            for k in range(cols_a):
                # print(A[i][k], B[k][j])
                C[i][j] = C[i][j] + A[i][k]*B[k][j]
    return C


def square_matrix_multiply_recursive(A, B):
    rows_a = len(A)
    cols_a = len(A[0])
    cols_b = len(B[0])
    C = [[0 for i in range(cols_b)] for j in range(rows_a)]
    if rows_a == 1:
        C[1][1] = A[1][1]*B[1][1]
    else:
        pass


if __name__ == "__main__":
    A = [[1, 2, 3], [2, 3, 4]]
    B = [[2, 4], [3, 5], [4, 6]]
    # B = [[2], [3], [4]]
    C = square_matrix_multiply(A, B)
    print(C)