# Makefile for SystemVerilog Lab5
RTL= ../../rtl_lib/router.v
BADRTL= ../../rtl_lib/bad/router.v
SVTB = ./router_test_top.sv ./router_io.sv ./test.sv ./assert.sva
SEED = 1
BROWSER = firefox

default: clean test 

test: compile run

bad: clean compile_bad run

run:
	./simv -l simv.log +ntb_random_seed=$(SEED) -cm assert

compile:
	vcs -sverilog -debug_all -assert dve +define+ASSERT_ON -y ${VCS_HOME}/packages/sva +libext+.sv +incdir+${VCS_HOME}/packages/sva $(SVTB) $(RTL) -cm assert

compile_bad:
	vcs -sverilog -debug_all -assert dve +define+ASSERT_ON -y ${VCS_HOME}/packages/sva +libext+.sv +incdir+${VCS_HOME}/packages/sva $(SVTB) $(BADRTL)

dve:
	dve -vpd vcdplus.vpd &

debug:
	./simv -l simv.log -gui -tbug +ntb_random_seed=$(SEED)

solution: clean

	cp ../../solutions/lab4/*.sv .
	cp ../../solutions/lab4/*.sva .

clean:
	rm -rf simv* csrc* *.tmp *.vpd *.key *.log

nuke: clean
	rm -rf *.v* include *.sv *.sva .*.lock *.old .*.old DVE* *.tcl *.h
	cp ../../solutions/lab4/*.sv .
	cp ../../solutions/lab4/.original/*.sva .
	

help:
	@echo ===========================================================================
	@echo  " 								        "
	@echo  " USAGE: make target <SEED=xxx>                                          "
	@echo  " 								        "
	@echo  " ------------------------- Test TARGETS --------------------------------"
	@echo  " test       => Compiles TB and GOOD DUT files, runs the simulation.     "
	@echo  " bad        => Compiles TB and BAD DUT files, runs the simulation.      "
	@echo  " compile    => Compiles the TB and DUT.                                 "
	@echo  " run        => Runs the simulation.                                     "
	@echo  " dve        => Runs dve in post-processing mode                         "
	@echo  " debug      => Runs simulation interactively with dve                   "
	@echo  " clean      => Removes all intermediate simv and log files.             "
	@echo  "                                                                        "
	@echo  " -------------------- ADMINISTRATIVE TARGETS ---------------------------"
	@echo  " help       => Displays this message.                                   "
	@echo  " copy       => Copies lab files from previous working  directory        "
	@echo  " mycopy     => Copies lab files from previous solution  directory       "
	@echo  " solution   => Copies all files from current solutions directory        "
	@echo  " nuke       => Erases all changes. Put all files back to original state "
	@echo  "				     			                "
	@echo ===========================================================================
