############################################################
#          constraint  for div.v                           #
############################################################

read_verilog /usr/xxn/dc3/code/div.v



current_design div

create_clock -name "CLK_IN" -period 10 -waveform { 0 5 } [get_ports clk_sys]

set_clock_uncertainty -setup 0.05 CLK_IN
set_clock_uncertainty -hold 0.05 CLK_IN

set_input_delay -max 1 -clock CLK_IN [get_ports clk_set*]
set_input_delay -min 0.1 -clock CLK_IN [get_ports clk_set*]

set_output_delay -max 9 -clock CLK_IN [get_ports clk_tx]

set_dont_touch_network [get_clocks CLK_IN]

compile

write -format db /usr/xxn/dc3/netlist/div.db

############################################################################

read_verilog /usr/xxn/dc3/code/itf.v

link

current_design itf

create_clock -name "CLK_IN" -period 10 -waveform { 0 5 } [get_ports clk_sys]

set_clock_uncertainty -setup 0.05 CLK_IN
set_clock_uncertainty -hold 0.05 CLK_IN

set_output_delay -max 9 -clock CLK_IN [all_outputs]

set_dont_touch_network [get_clocks CLK_IN]

compile

write -format db /usr/xxn/dc3/netlist/div.db

#############################################################################

read_verilog /usr/xxn/dc3/code/counter.v

link

current_design counter

create_clock -name "CLK" -period 20 [get_ports clk]

set_clock_uncertainty -setup 0.05 CLK
set_clock_uncertainty -hold 0.05 CLK

set_dont_touch_network [get_clocks CLK]

compile

write -format db /usr/xxn/dc3/netlist/counter.db

##############################################################################
remove_design -all

read_db /usr/xxn/dc3/netlist/div.db
read_db /usr/xxn/dc3/netlist/itf.db
read_db /usr/xxn/dc3/netlist/counter.db
read_verilog /usr/xxn/dc3/code/top.v

link

set_dont_touch div
set_dont_touch itf
set_dont_touch counter

current_design top

create_clock -name "CLK_IN" -period 10 -waveform { 0 5 } [get_ports clk_sys]

compile

report_timing -max
report_timing -min


























                              