transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter3/class13_key_filter/rtl {D:/fpga/ac620/demo_release/book_prj/chapter3/class13_key_filter/rtl/key_filter.v}

vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter3/class13_key_filter/prj/../testbench {D:/fpga/ac620/demo_release/book_prj/chapter3/class13_key_filter/prj/../testbench/key_filter_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  key_filter_tb

add wave *
view structure
view signals
run -all
