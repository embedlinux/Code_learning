
使用questasim仿真器

$ vlib work（如果出错，则删除work文件夹）
$ vlog –sv +define+UVM_NO_DPI +incdir+../../uvm-1.1d/src ../../uvm-1.1d/src/uvm_pkg.sv top.sv
$ vsim  -novopt +UVM_TESTNAME=my_test  top –l simulation.log –do “run -all”

说明
1. makefile仅供参考，不确保每一个实验中都可用
2. 前几个实验用到的顶层是test.sv中的test，后几个实验中用到的顶层是top.sv中的top，使用时注意区分。
