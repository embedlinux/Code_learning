######################################################################
#            script for output_delay                                 #
#            written by xxn                                          #
######################################################################
read_verilog /usr/xxn/dc2/code/itf.v
read_verilog /usr/xxn/dc2/code/div.v
read_verilog /usr/xxn/dc2/code/counter.v
read_verilog /usr/xxn/dc2/code/top.v
current_design top

link

set auto_wire_load_selection true
set_max_transition 0.2 div
set_fanout_load 3 [all_outputs]

set ALL_EX_CLK [remove_from_collection [all_inputs] [get_ports clk_sys]]

create_clock -name "clk_1" -period 10 -waveform { 0 5 } [get_ports clk_sys]

set_clock_uncertainty -setup 0.1 clk_1
set_clock_uncertainty -hold 0.1 clk_1

set_input_delay -max 2 -clock clk_1 $ALL_EX_CLK
set_input_delay -min 0.1 -clock clk_1 $ALL_EX_CLK
set_output_delay -max 5 -clock clk_1 [all_outputs]
set_output_delay -min 1 -clock clk_1 [all_outputs]
set_dont_touch_network [get_clocks clk_1]
set_fix_hold clk_1

compile

report_timing > /usr/xxn/dc2/rpt//setup_time_5.rpt
report_timing -delay min > /usr/xxn/dc2/rpt/hold_time_5.rpt
report_cell > /usr/xxn/dc2/rpt/cell_5.rpt
report_area > /usr/xxn/dc2/rpt/area_5.rpt
report_power > /usr/xxn/dc2/rpt/power_5.rpt



write -format verilog -hier -o /usr/xxn/dc2/netlist/top.gv
