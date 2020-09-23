transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter3/class7_decoder3_8/rtl {D:/fpga/ac620/demo_release/book_prj/chapter3/class7_decoder3_8/rtl/decoder3_8.v}

vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter3/class7_decoder3_8/prj/../testbench {D:/fpga/ac620/demo_release/book_prj/chapter3/class7_decoder3_8/prj/../testbench/decoder3_8_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  decoder3_8_tb

add wave *
view structure
view signals
run -all
