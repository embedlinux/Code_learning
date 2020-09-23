transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/src {D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/src/uart_eeprom.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/src {D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/src/uart_byte_tx.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/src {D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/src/uart_byte_rx.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/src {D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/src/I2C.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/src {D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/src/cmd_analysis.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/core {D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/core/fifo_rd.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/core {D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/core/fifo_wr.v}

vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/dev/../sim {D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/dev/../sim/uart_eeprom_tb.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/dev/../sim {D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/dev/../sim/24LC64.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/dev/../sim {D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/dev/../sim/24LC04B.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/dev/../src {D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/dev/../src/uart_eeprom.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/dev/../src {D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/dev/../src/uart_byte_tx.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/dev/../src {D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/dev/../src/uart_byte_rx.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/dev/../src {D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/dev/../src/I2C.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/dev/../src {D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/dev/../src/cmd_analysis.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/dev/../core {D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/dev/../core/fifo_rd.v}
vlog -vlog01compat -work work +incdir+D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/dev/../core {D:/fpga/ac620/demo_release/book_prj/chapter6/30_Uart2EEPROM/dev/../core/fifo_wr.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  uart_eeprom_tb

add wave *
view structure
view signals
run -all
