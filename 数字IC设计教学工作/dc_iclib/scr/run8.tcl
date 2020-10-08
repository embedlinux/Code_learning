######################################################################
#            script for top-down                                     #
#            written by xxn                                          #
######################################################################
read_verilog /usr/xxn/dc2/code/div.v
read_verilog /usr/xxn/dc2/code/itf.v
read_verilog /usr/xxn/dc3/code/counter.v
read_verilog /usr/xxn/dc3/code/top.v
current_design top

link

set ALL_INPUTS_EXP_CLK [remove_from_collection [all_inputs] [get_ports clk_sys]]

create_clock -name "CLK_SYS" -period 10 -waveform { 0 5 } [get_ports clk_sys]

set_clock_uncertainty -setup 0.1 CLK_SYS
set_clock_uncertainty -hold 0.1 CLK_SYS

set_input_delay -max 1 -clock CLK_SYS $ALL_INPUTS_EXP_CLK
set_input_delay -min 0.2 -clock CLK_SYS $ALL_INPUTS_EXP_CLK
set_output_delay -max 9 -clock CLK_SYS [all_outputs]

set_dont_touch_network [get_clocks CLK_SYS]
set_max_area 0

set_false_path -from [get_ports di*] 
set_false_path -from [get_ports clk_set*] 
set_false_path -from [get_ports ld] 

compile

report_timing > /usr/xxn/dc3/rpt/setup_time_8.rpt
report_timing -delay min > /usr/xxn/dc3/rpt/hold_time_8.rpt

write -format verilog -hier -o /usr/xxn/dc2/netlist/top.gv
write -format db -hier -o /usr/xxn/dc2/netlist/top.db
















