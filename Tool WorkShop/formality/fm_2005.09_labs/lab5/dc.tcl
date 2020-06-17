set hdlin_enable_presto_for_vhdl true
define_design_lib WORK -path ./DC_WORK  
set_svf tv80s.svf

lappend search_path "./rtl"

set synthetic_library ""
set target_library  "class.db" 
set link_library   " $target_library $synthetic_library "

analyze -f verilog \
  {  tv80_alu.v \
     tv80_core.v \
     tv80_mcode.v \
     tv80_reg.v \
     tv80s.v \
  }


elaborate tv80s
compile 

change_names -rule verilog
write -hier -format verilog -out tv80s.vg

ungroup -all -flatten -simple_names
change_names -rule verilog
write -hier -format verilog -out tv80s.flat.vg
