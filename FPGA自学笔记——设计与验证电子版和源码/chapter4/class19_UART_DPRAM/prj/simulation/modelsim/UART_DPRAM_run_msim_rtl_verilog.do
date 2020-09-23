transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter4/class19_UART_DPRAM/prj/ip {D:/fpga/ac620/demo_release/book_prj/chapter4/class19_UART_DPRAM/prj/ip/dpram.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter4/class19_UART_DPRAM/rtl {D:/fpga/ac620/demo_release/book_prj/chapter4/class19_UART_DPRAM/rtl/UART_DPRAM.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter4/class19_UART_DPRAM/rtl {D:/fpga/ac620/demo_release/book_prj/chapter4/class19_UART_DPRAM/rtl/uart_byte_tx.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter4/class19_UART_DPRAM/rtl {D:/fpga/ac620/demo_release/book_prj/chapter4/class19_UART_DPRAM/rtl/uart_byte_rx.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter4/class19_UART_DPRAM/rtl {D:/fpga/ac620/demo_release/book_prj/chapter4/class19_UART_DPRAM/rtl/key_filter.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter4/class19_UART_DPRAM/rtl {D:/fpga/ac620/demo_release/book_prj/chapter4/class19_UART_DPRAM/rtl/CTRL.v}

vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter4/class19_UART_DPRAM/prj/../testbench {D:/fpga/ac620/demo_release/book_prj/chapter4/class19_UART_DPRAM/prj/../testbench/UART_DPRAM_tb.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter4/class19_UART_DPRAM/prj/../testbench {D:/fpga/ac620/demo_release/book_prj/chapter4/class19_UART_DPRAM/prj/../testbench/key_model.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  UART_DPRAM_tb

add wave *
view structure
view signals
run -all
