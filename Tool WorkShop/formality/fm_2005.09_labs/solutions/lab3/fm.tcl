set search_path "./rtl ./lib ./netlists"

read_verilog -container r -libname WORK { alu.v cntrl.v r4000.v register.v } 
read_db { vsc1083.db } 
set_top r:/WORK/mR4000 

read_verilog -container i -libname WORK { r4000.vo } 
set_top i:/WORK/mR4000 

verify 
