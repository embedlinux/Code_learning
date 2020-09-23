transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter3/class14_key_led_top/rtl {D:/fpga/ac620/demo_release/book_prj/chapter3/class14_key_led_top/rtl/led_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter3/class14_key_led_top/rtl {D:/fpga/ac620/demo_release/book_prj/chapter3/class14_key_led_top/rtl/key_led_top.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter3/class14_key_led_top/rtl {D:/fpga/ac620/demo_release/book_prj/chapter3/class14_key_led_top/rtl/key_filter.v}

vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter3/class14_key_led_top/prj/../testbench {D:/fpga/ac620/demo_release/book_prj/chapter3/class14_key_led_top/prj/../testbench/key_led_top_tb.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter3/class14_key_led_top/prj/../testbench {D:/fpga/ac620/demo_release/book_prj/chapter3/class14_key_led_top/prj/../testbench/key_model.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  key_led_top_tb

add wave *
view structure
view signals
run -all
