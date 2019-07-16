#!/usr/bin/env python
# -*- coding:utf-8 -*-

# Author:
# @Time    :2019/7/16  21:36

import os
filepath = os.path.abspath(__file__)
project_path = os.path.abspath(os.path.join(filepath, "../../"))
staff_info = os.path.abspath(os.path.join(project_path, "db/emp.db"))

if __name__ == "__main__":
    print(staff_info)
