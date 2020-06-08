# TCL script for DC
#######################################################
set hdlin_translate_off_skip_text "true"
set verilogout_no_tri             "true"
set default_schematic_options     "-size infinite"
set write_name_nets_same_as_ports "true"
#
#######################################################
#
# dc_shell TcL startup script:
#
set designer "klin"
set company  "QiXin"
#
# Some design environment variables:
#
set search_path ". $search_path ../../../library"
#
# tc = Typical; bc = Best; wc = Worst:
set target_library typical.db
set link_library   "* typical.db"
#
set symbol_library tsmc090.sdb
#
# ---------------------------------
#
# Set up a work library for this design in a subdirectory:
define_design_lib syn_ws -path ./syn_ws
#
# Precompile and check all modules:
analyze   -work syn_ws -format verilog ./SerFrameEnc.v
elaborate -work syn_ws SerFrameEnc
#
# ---------------------------------
set_operating_conditions   typical
set_wire_load_model -name "tsmc090_wl10" [all_designs]
#
# For XG mode portability to back-end tools:
set_fix_multiple_port_nets -all -buffer_constants
#
# Some netlist-level design rules:
set_drive      10.0 [all_inputs]
set_load       30.0 [all_outputs]  
set_max_fanout 5    [all_inputs]
#
# Design-specific constraints:
set_max_area   0
set_max_delay  6 -to [all_outputs]
create_clock -period 10 DoFrame
set_input_delay  1 [all_inputs]  -clock DoFrame
set_output_delay 1 [all_outputs] -clock DoFrame
#
# Drop into interactive mode for compile & optimize:
#
# compile
# ungroup -all -flatten
 compile -map_effort high 
#
# check the timing and area infomation
 report_timing 
 report_area
# 
# Save the netlist in Synopsys (ddc) format:
# write -hierarchy -format ddc
#
# Save the netlist in verilog netlist format:
 write -hierarchy -format verilog -output SerFrameEncNetlist.v
#
# Write a Standard Delay Format (SDF) back-annotation
# file for future simulation, using DC library delays:
 write_sdf SerFrameEnc.sdf
#
# Quit DC:
 exit
# 
# re-synthesize the RTL to improve the timing
# dc_shell-t -f syn_ws.sct
# ungroup -all -flatten
# compile -map_effort high
# change_names -rules verilog
# write -hierarchy -format verilog -output Intro_Flatten_Netlist.v
# write_sdf syn_ws.sdf
