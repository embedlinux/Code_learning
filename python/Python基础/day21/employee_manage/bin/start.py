#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/16  21:14
import os
import sys

project_path = os.path.abspath(os.path.join(os.path.abspath(__file__), "../../"))
# print(project_path)
sys.path.append(project_path)
from core import main


if __name__ == "__main__":
    main.home()