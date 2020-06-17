set svf_debug true
set svf_datapath true
set_svf default.svf

set verification_datapath_effort_level low
set verification_timeout_limit 0:02:0

read_db lsi_10k.db
read_verilog -r rx.v
read_verilog -r tx.v
read_verilog -r hierA.v
read_verilog -r hierB.v
read_verilog -r hierC.v
read_verilog -r top.v
set_top top

read_verilog -i gate_top.v
set_top top 

match
verify
