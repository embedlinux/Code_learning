transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter5/class27_TFT_CTRL/rtl {D:/fpga/ac620/demo_release/book_prj/chapter5/class27_TFT_CTRL/rtl/TFT_CTRL_test.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter5/class27_TFT_CTRL/rtl {D:/fpga/ac620/demo_release/book_prj/chapter5/class27_TFT_CTRL/rtl/TFT_CTRL.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter5/class27_TFT_CTRL/prj {D:/fpga/ac620/demo_release/book_prj/chapter5/class27_TFT_CTRL/prj/TFT_test_pll.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter5/class27_TFT_CTRL/prj/db {D:/fpga/ac620/demo_release/book_prj/chapter5/class27_TFT_CTRL/prj/db/tft_test_pll_altpll.v}

vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter5/class27_TFT_CTRL/prj/../testbench {D:/fpga/ac620/demo_release/book_prj/chapter5/class27_TFT_CTRL/prj/../testbench/TFT_CTRL_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  TFT_CTRL_tb

add wave *
view structure
view signals
run -all
