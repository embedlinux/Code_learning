set hdlin_enable_presto_for_vhdl true
define_design_lib WORK -path ./DC_WORK  

set synthetic_library ""
set target_library  "../class.db" 
set link_library   " $target_library $synthetic_library "

analyze -f vhdl -lib WORK ./src/pack_mips.vhd
analyze -f vhdl -lib WORK ./src/alu.vhd
analyze -f vhdl -lib WORK ./src/banc.vhd
analyze -f vhdl -lib WORK ./src/bus_ctrl.vhd
analyze -f vhdl -lib WORK ./src/minimips.vhd
analyze -f vhdl -lib WORK ./src/pps_di.vhd
analyze -f vhdl -lib WORK ./src/pps_ei.vhd
analyze -f vhdl -lib WORK ./src/pps_ex.vhd
analyze -f vhdl -lib WORK ./src/pps_mem.vhd
analyze -f vhdl -lib WORK ./src/pps_pf.vhd
analyze -f vhdl -lib WORK ./src/predict.vhd
analyze -f vhdl -lib WORK ./src/renvoi.vhd
analyze -f vhdl -lib WORK ./src/syscop.vhd
elaborate -lib WORK minimips

compile

write -hier -format db -out minimips.gates.db

define_name_rules -last_restricted "_" -replacement_char "_0" no_trailing_underscore
change_names -rule verilog
change_names -rule no_trailing_underscore

write -hier -format verilog -out minimips.gates.vg

