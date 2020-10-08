######################################################################
#            script for bottom-up                                    #
#            written by xxn                                          #
######################################################################
read_verilog /usr/xxn/dc2/code/div.v
current_design div

link

set ALL_INPUTS_EXP_CLK [remove_from_collection [all_inputs] [get_ports clk_sys]]

create_clock -name "CLK_SYS" -period 10 -waveform { 0 5 } [get_ports clk_sys]

set_clock_uncertainty -setup 0.1 CLK_SYS
set_clock_uncertainty -hold 0.1 CLK_SYS

set_input_delay -max 1 -clock CLK_SYS $ALL_INPUTS_EXP_CLK
set_input_delay -min 0.2 -clock CLK_SYS $ALL_INPUTS_EXP_CLK
set_output_delay -max 9 -clock CLK_SYS [all_outputs]

set_dont_touch_network [get_clocks CLK_SYS]

compile

write -format db -o /usr/xxn/dc3/netlist/div.db

#####################################################################################

read_verilog /usr/xxn/dc2/code/itf.v
current_design itf

link

set ALL_INPUTS_EXP_CLK [remove_from_collection [all_inputs] [get_ports clk_sys]]

create_clock -name "CLK_SYS" -period 10 -waveform { 0 5 } [get_ports clk_sys]

set_clock_uncertainty -setup 0.1 CLK_SYS
set_clock_uncertainty -hold 0.1 CLK_SYS

set_input_delay -max 1 -clock CLK_SYS $ALL_INPUTS_EXP_CLK
set_input_delay -min 0.2 -clock CLK_SYS $ALL_INPUTS_EXP_CLK
set_output_delay -max 9 -clock CLK_SYS [all_outputs]
set_output_delay -min 8 -clock CLK_SYS [all_outputs]
set_dont_touch_network [get_clocks CLK_SYS]

set_fanout_load 3 [all_outputs]

compile

write -format db -o /usr/xxn/dc3/netlist/itf.db

############################################################################################

read_verilog /usr/xxn/dc3/code/counter.v
current_design counter

link

create_clock -name "CLK" -period 10 -waveform { 0 5 } [get_ports clk]
set_dont_touch_network [get_clocks CLK]

set_clock_uncertainty -setup 0.1 CLK
set_clock_uncertainty -hold 0.1 CLK

set_input_delay -max 1 -clock CLK [remove_from_collection [all_inputs] [get_ports clk]]
set_input_delay -min 0.2 -clock CLK [remove_from_collection [all_inputs] [get_ports clk]]

compile 

write -format db -o /usr/xxn/dc3/netlist/counter.db

#############################################################################################
remove_design -all

read_db /usr/xxn/dc3/netlist/div.db
read_db /usr/xxn/dc3/netlist/itf.db
read_db /usr/xxn/dc3/netlist/counter.db
read_verilog /usr/xxn/dc3/code/top.v

set_dont_touch div
set_dont_touch itf
set_dont_touch counter

current_design top

link

create_clock -name "CLK_SYS" -period 10 -waveform { 0 5 } [get_ports clk_sys]

set_input_delay -max 8 -clock CLK_SYS [remove_from_collection [all_inputs] [get_ports clk_sys]]
set_input_delay -min 0 -clock CLK_SYS [remove_from_collection [all_inputs] [get_ports clk_sys]]

set_output_delay -max 9 -clock CLK_SYS [all_outputs]
set_output_delay -min 8 -clock CLK_SYS [all_outputs] 

set_dont_touch_network [get_clocks CLK_SYS]

#set_false_path -from [get_ports clk_set*]
#set_false_path -from [get_ports di*]
#set_false_path -from [get_ports ld]
#set_false_path -from [get_ports rst]

#set_fix_hold CLK_SYS

set_max_area 0


compile 

report_timing > /usr/xxn/dc3/rpt/setup_time_7.rpt
report_timing -delay min > /usr/xxn/dc3/rpt/hold_time_7.rpt

write -format verilog -hier -o /usr/xxn/dc2/netlist/top.gv
write -format db -hier -o /usr/xxn/dc2/netlist/top.db































