######################################################################
#            run script for counter                                  #
#            written by xxn                                          #
######################################################################
read_verilog /usr/xxn/dc2/code/counter.v
current_design counter

link

set auto_wire_load_selection true
set_max_transition 0.2 counter
set_fanout_load 3 [all_outputs]

create_clock -name "clk" -period 10 -waveform { 0 5 } [get_ports clk]

set_clock_uncertainty -setup 0.1 clk
set_clock_uncertainty -hold 0.1 clk

set_input_delay -max 2 -clock clk [all_inputs]
set_input_delay -min 0.1 -clock clk [all_inputs]
set_dont_touch_network [get_clocks clk]


compile

report_timing > /usr/xxn/dc2/rpt//setup_time_1.rpt
report_timing -delay min > /usr/xxn/dc2/rpt/hold_time_1.rpt
report_cell > /usr/xxn/dc2/rpt/cell_1.rpt
report_area > /usr/xxn/dc2/rpt/area_1.rpt
report_power > /usr/xxn/dc2/rpt/power_1.rpt



write -format verilog -hier -o /usr/xxn/dc2/netlist/counter.gv
