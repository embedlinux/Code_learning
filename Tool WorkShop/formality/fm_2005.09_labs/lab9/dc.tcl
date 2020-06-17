#
# Written by : DC-Transcript, Version V-2003.12 -- Nov 19, 2003
# Date       : Fri Jul 16 10:40:37 2004
#

#
# Translation of script: compile.dc
#

set synthetic_library dw_foundation.sldb
set target_library lsi_10k.db
set link_library {* lsi_10k.db}
set link_library [concat  $link_library $synthetic_library]

#set enable_dw_multiplier_in_svf true
#set synlib_debug_print low
#set formality_link_debug true
#set_svf csmult.svf
#set dw_prefer_mc_inside true

read_file -f verilog rx.v
read_file -f verilog tx.v
read_file -f verilog hierA.v
read_file -f verilog hierB.v
read_file -f verilog hierC.v
read_file -f verilog top.v

link
compile
write -f verilog -h -out gate_top.v
