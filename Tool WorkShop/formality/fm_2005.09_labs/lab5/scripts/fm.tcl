set hdlin_vhdl_presto_naming true
#set_svf tv80s.svf

lappend search_path "./rtl"

read_verilog -r \
  {  tv80_alu.v \
     tv80_core.v \
     tv80_mcode.v \
     tv80_reg.v \
     tv80s.v \
  }


set_top r:/*/tv80s

read_db -i ../class.db
read_verilog -i ./tv80s.flat.vg
set_top i:/*/tv80s

verify
