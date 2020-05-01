#!/bin/sh

# workspace
rm -rf work
vlib work

# testbench
vlog -sv -mfcu -l testbench.log +define+UVM_NO_DPI +incdir+../../uvm-1.1d/src  ../../uvm-1.1d/src/uvm_pkg.sv test.sv
									
# simulate
vsim -novopt -c -debugdb -l simulation.log +UVM_TESTNAME=my_test test -do "run -all; log -r * "
				
# clean
# rm -rf work *.log transcript *.wlf *.ucdb *.dbg

