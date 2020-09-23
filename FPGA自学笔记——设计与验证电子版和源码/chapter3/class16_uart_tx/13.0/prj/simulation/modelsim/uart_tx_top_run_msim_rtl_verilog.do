transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter3/class16_uart_tx/13.0/rtl {D:/fpga/ac620/demo_release/book_prj/chapter3/class16_uart_tx/13.0/rtl/uart_tx_top.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter3/class16_uart_tx/13.0/rtl {D:/fpga/ac620/demo_release/book_prj/chapter3/class16_uart_tx/13.0/rtl/uart_byte_tx.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter3/class16_uart_tx/13.0/rtl {D:/fpga/ac620/demo_release/book_prj/chapter3/class16_uart_tx/13.0/rtl/key_filter.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter3/class16_uart_tx/13.0/prj/ip {D:/fpga/ac620/demo_release/book_prj/chapter3/class16_uart_tx/13.0/prj/ip/ISSP.v}

vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter3/class16_uart_tx/13.0/prj/../testbench {D:/fpga/ac620/demo_release/book_prj/chapter3/class16_uart_tx/13.0/prj/../testbench/uart_byte_tx_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  uart_byte_tx_tb

add wave *
view structure
view signals
run -all
