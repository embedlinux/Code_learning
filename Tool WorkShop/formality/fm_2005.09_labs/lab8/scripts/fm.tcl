set search_path " ./ ./netlists ./lib"

read_db -tech hcos893.db
read_db -tech hios893.db


read_veri -r -netlist gate.orig.v
set_top r:/WORK/chkblk

read_verilog -i  -netlist  gate.eco.v
set_top i:/WORK/chkblk

match
verify

