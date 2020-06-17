set hdlin_warn_on_mismatch_message "FMR_VHDL-1014 FMR_VHDL-1002 FMR_ELAB-146 FMR_ELAB-149"
suppress_message SVR-21

set hdlin_dwroot "/remote/release/synthesis/W-2004.12"
set_svf default.svf

read_vhdl -r ./src/pack_mips.vhd
read_vhdl -r ./src/alu.vhd
read_vhdl -r ./src/banc.vhd
read_vhdl -r ./src/bus_ctrl.vhd
read_vhdl -r ./src/minimips.vhd
read_vhdl -r ./src/pps_di.vhd
read_vhdl -r ./src/pps_ei.vhd
read_vhdl -r ./src/pps_ex.vhd
read_vhdl -r ./src/pps_mem.vhd
read_vhdl -r ./src/pps_pf.vhd
read_vhdl -r ./src/predict.vhd
read_vhdl -r ./src/renvoi.vhd
read_vhdl -r ./src/syscop.vhd
set_top r:/*/minimips

read_db -i ../class.db
read_verilog -i minimips.gates.vg
set_top i:/*/minimips

verify

