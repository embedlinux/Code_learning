transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter5/class25_ADCadc128s022/rtl {D:/fpga/ac620/demo_release/book_prj/chapter5/class25_ADCadc128s022/rtl/adc128s022.v}

vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter5/class25_ADCadc128s022/prj/../testbench {D:/fpga/ac620/demo_release/book_prj/chapter5/class25_ADCadc128s022/prj/../testbench/adc128s022_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  adc128s022_tb

add wave *
view structure
view signals
run -all
