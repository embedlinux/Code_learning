#------------------------------------------------------------------------------
# File   : A TCL format DC script file for a ADDER
# Author : xinxn 
# date   : 2009-04-02    
#------------------------------------------------------------------------------
set TECH_LIB_PATH "/usr/iclib/fsa0a_c/2004Q4v1.1/SC/FrontEnd/synopsys"
set IO_LIB_PATH   "/usr/iclib/fsa0a_c/2004Q4v1.1/IO/FrontEnd/synopsys"
#------------------------------------------------------------------------------
set search_path [concat $TECH_LIB_PATH $IO_LIB_PATH $search_path]
echo $search_path
#------------------------------------------------------------------------------
set target_library {fsa0a_c_sc_tc.db}
set link_library {* fsa0a_c_sc_tc.db fsa0a_c_io_tc.db}
set symbol_library {fsa0a_c_sc.sdb}
#------------------------------------------------------------------------------
# add DesignWare Libs to link library
#------------------------------------------------------------------------------
set synthetic_library {dw_foundation.sldb}
lappend link_library $synthetic_library
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
set TECH_LIB fsa0a_c_sc_tc
set IO_LIB   fsa0a_c_io_tc
set WORK_DIR /usr/dcpt09/adder/dc
set THIS_DESIGN adder
#------------------------------------------------------------------------------
# reports path and file
#------------------------------------------------------------------------------
set SETUP_RPT_FILE $WORK_DIR/report/setup_time.rpt
set HOLD_RPT_FILE  $WORK_DIR/report/hold_time.rpt
set AREA_RPT_FILE  $WORK_DIR/report/area.rpt
set CELL_RPT_FILE  $WORK_DIR/report/cell.rpt
set POWER_RPT_FILE $WORK_DIR/report/power.rpt
set VIOL_FILE      $WORK_DIR/report/voilation.rpt
#------------------------------------------------------------------------------
set NETLIST_FILE $WORK_DIR/netlist/adder_gate.v
set DESIGN_DB_FILE $WORK_DIR/netlist/adder.db
set SDC_FILE  $WORK_DIR/sdc/adder.sdc
#------------------------------------------------------------------------------
set CLK_PER 1.5
set HALF_PER [expr $CLK_PER/2.0]
set IN_DLY [expr $CLK_PER * 0.3]
set OUT_DLY [expr $CLK_PER * 0.3]
set MAX_TRANSITION [expr $CLK_PER/20.0]
#----------------------------------------------------------------------------------
read_verilog $WORK_DIR/code/adder.v
current_design $THIS_DESIGN
link
check_design
set ALL_EX_CLK [remove_from_collection [all_inputs] [get_ports clk]]
#----------------------------------------------------------------------------------
# design rules constraints
#----------------------------------------------------------------------------------
set_operating_conditions TCCOM
set_wire_load_model -name G5K
set_wire_load_mode  top
#----------------------------------------------------------------------------------
set_driving_cell -no_design_rule -lib_cell XMD -library $IO_LIB -pin O $ALL_EX_CLK

set_drive 0 [get_ports clk]
set_load [load_of $IO_LIB/YA2GSD/I] [all_outputs]

set_max_transition $MAX_TRANSITION [get_designs $THIS_DESIGN]

set MAX_LOAD [expr [load_of $TECH_LIB/BUF1/I]*8]
set_max_capacitance $MAX_LOAD $ALL_EX_CLK

set_max_transition $MAX_TRANSITION $ALL_EX_CLK

set_max_fanout 8 $ALL_EX_CLK

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
set_multicycle_path 4 -setup -to [get_pins s_reg["*"]/next_state]
set_multicycle_path 4 -hold -to [get_pins s_reg["*"]/next_state]
#-----------------------------------------------------------------------------------
report_port 
#-----------------------------------------------------------------------------------
set_dont_touch_network [get_clocks CLK]
uniquify
set_max_area 0
compile -map_effort high
#-----------------------------------------------------------------------------------
set_multicycle_path 8 -setup -to [get_pins s_reg["*"]/D]
set_multicycle_path 8 -hold -to [get_pins s_reg["*"]/D]
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
write -format db -hier -o $DESIGN_DB_FILE
write_sdc -nosplit $SDC_FILE
#quit











 