#------------------------------------------------------------------------------
# File   : A TCL format DC script file 
# Author : xinxn 
# date   : 2010-08-04    
#------------------------------------------------------------------------------
set TECH_LIB_PATH   "/iclibs/CSMCBCD05/synopsys"
set SYMBOL_LIB_PATH "/iclibs/CSMCBCD05/icons"
set CORE_LIB        "IC05CScore_50_typbcdv10.db"
set IO_LIB          "IC05CSpad_50_typbcdv10.db"
#------------------------------------------------------------------------------
set search_path [concat $TECH_LIB_PATH $search_path]
set search_path [concat $SYMBOL_LIB_PATH $search_path]
echo $search_path
#------------------------------------------------------------------------------
set target_library {IC05CScore_50_typbcdv10.db}
set link_library {* IC05CScore_50_typbcdv10.db IC05CSpad_50_typbcdv10.db}
set symbol_library {IC05CScore.sdb}
#------------------------------------------------------------------------------
# add DesignWare Libs to link library
#------------------------------------------------------------------------------
set SYN_LIB {dw_foundation.sldb}
lappend link_library $SYN_LIB
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
set WORK_DIR /home/socusr/dc
set THIS_DESIGN counter
#------------------------------------------------------------------------------
# reports path and file
#------------------------------------------------------------------------------
set SETUP_RPT_FILE $WORK_DIR/report/setup_time.rpt
set HOLD_RPT_FILE  $WORK_DIR/report/hold_time.rpt
set AREA_RPT_FILE  $WORK_DIR/report/area.rpt
set CELL_RPT_FILE  $WORK_DIR/report/cell.rpt
set POWER_RPT_FILE $WORK_DIR/report/power.rpt
set VIOL_FILE      $WORK_DIR/report/voilation.rpt
#----------------------------------------------------------------------------------
set NETLIST_FILE   $WORK_DIR/netlist/counter_gate.v
set SDC_FILE       $WORK_DIR/sdc/counter.sdc
#----------------------------------------------------------------------------------
set CLK_PER 2.5
set IN_DLY [expr $CLK_PER * 0.3]
set OUT_DLY [expr $CLK_PER * 0.3]
set MAX_TRANSITION 0.1
#----------------------------------------------------------------------------------
read_verilog $WORK_DIR/code/counter.v
current_design $THIS_DESIGN
link
check_design
#----------------------------------------------------------------------------------
set ALL_EX_CLK [remove_from_collection [all_inputs] [get_ports clk]]
#----------------------------------------------------------------------------------
# design rules constraints
#----------------------------------------------------------------------------------
# set driving ability of input ports and load of output ports.
#----------------------------------------------------------------------------------
set_drive 1.0 $ALL_EX_CLK
set_drive 0 [get_ports clk]
set_load  0.1 [all_outputs]
#----------------------------------------------------------------------------------
set auto_wire_load_selection true
set_max_transition $MAX_TRANSITION $THIS_DESIGN
set_max_fanout 6 $ALL_EX_CLK
set_max_fanout 2 [get_ports rst]
#-----------------------------------------------------------------------------------
# Timing constraints
#-----------------------------------------------------------------------------------
create_clock -p $CLK_PER -name CLK [get_ports clk]
set_clock_uncertainty -setup 0.2 CLK
set_clock_uncertainty -hold 0.1 CLK
set_input_delay -max $IN_DLY -clock CLK $ALL_EX_CLK
set_input_delay -min 0 -clock CLK $ALL_EX_CLK
set_output_delay $OUT_DLY [all_outputs]
#-----------------------------------------------------------------------------------
report_port
#-----------------------------------------------------------------------------------
set_dont_touch_network [get_clocks CLK]
uniquify
set_max_area 0
compile -map_effort high
#-----------------------------------------------------------------------------------
report_constraint -all_violators > $VIOL_FILE
#-----------------------------------------------------------------------------------
report_timing > $SETUP_RPT_FILE
report_timing -delay min > $HOLD_RPT_FILE
#-----------------------------------------------------------------------------------
report_cell  >  $CELL_RPT_FILE
report_area  >  $AREA_RPT_FILE
report_power >  $POWER_RPT_FILE
#-----------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------
write -format verilog -hier -o $NETLIST_FILE
write_sdc -nosplit $SDC_FILE
#quit











 
