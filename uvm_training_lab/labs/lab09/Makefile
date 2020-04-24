

SEED=$(shell date +"%s")
TESTNAME=my_test

all: title compile simulate

title:
	@reset
	@echo ""
	@echo ""
	@echo "The simuliaton is going to running ..."
	@echo ""
	@echo ""


compile: workspace dut testbench

workspace:
	@echo "====================================="
	@echo " -> Step 1.  Create the workspace    "
	@echo "====================================="
	@echo "Now creating the workspace, please wait ..."
	@echo ""
	@rm -rf work
	@vlib work
	@echo ""
	@echo "Creating workspace completed!"
	@echo ""

dut:
	@echo "====================================="
	@echo " -> Step 2.  Compile the DUT Code    "
	@echo "====================================="
	@echo "Now compiling the DUT, please wait ..."
	@echo ""
	@vlog -l dut_compile.log ../../rtl/router.v
	@echo ""
	@echo "Compiling DUT completed!"
	@echo ""

testbench:
	@echo "====================================="
	@echo " -> Step 3.  Compile the TB Code     "
	@echo "====================================="
	@echo "Now compiling the testbench, please wait ..."
	@echo ""
	@vlog -sv -mfcu -l testbench.log +define+UVM_NO_DPI \
	                                 +incdir+../../uvm-1.1d/src \
	                                 ../../uvm-1.1d/src/uvm_pkg.sv \
																	 top.sv
	@echo ""
	@echo "Compiling testbench completed!"
	@echo ""


simulate:
	@echo "====================================="
	@echo " -> Step 4.  Run the simulation      "
	@echo "====================================="
	@echo "Now running the simulation: "
	@echo ""
	@vsim -novopt -sv_seed ${SEED} -c -debugdb -l simulation.log +UVM_TESTNAME=${TESTNAME} top -do "run -all; log -r * "
	@echo ""
	@echo "Running simulation completed. Exiting the simulator!" 
	@echo "Well done! Congratulations !!!"
	@echo ""


cleanall:
	@rm -rf work *.log transcript *.wlf *.ucdb *.dbg
