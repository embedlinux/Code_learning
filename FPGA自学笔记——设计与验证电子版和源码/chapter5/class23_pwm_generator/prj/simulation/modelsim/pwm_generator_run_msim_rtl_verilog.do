transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter5/class23_pwm_generator/rtl {D:/fpga/ac620/demo_release/book_prj/chapter5/class23_pwm_generator/rtl/pwm_generator.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter5/class23_pwm_generator/rtl {D:/fpga/ac620/demo_release/book_prj/chapter5/class23_pwm_generator/rtl/pwm_generator_test.v}

vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter5/class23_pwm_generator/prj/../testbench {D:/fpga/ac620/demo_release/book_prj/chapter5/class23_pwm_generator/prj/../testbench/pwm_generator_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  pwm_generator_tb

add wave *
view structure
view signals
run -all
