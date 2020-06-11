# Makefile for SVA Lab1
RTL= ../../rtl/router.v
BADRTL= ../../rtl/bad/router.v
SVTB = ./router_test_top.sv ./router_io.sv ./test.sv
SEED = 1
BROWSER = firefox

default: test 

test: compile run

bad: compile_bad run

run:
	./simv -l simv.log +ntb_random_seed=$(SEED) -cm assert

compile:
	vcs -sverilog -ntb_opts dtm -debug_all $(SVTB) $(RTL) -assert dve -assert enable_diag -cm assert

compile_bad:
	vcs -sverilog -ntb_opts dtm -debug_all $(SVTB) $(BADRTL) -assert dve -assert enable_diag

coverage:
	urg -dir simv.vdb
	urg -dir simv.vdb -format text
	$(BROWSER) $(PWD)/urgReport/dashboard.html &

dve:
	dve -vpd vcdplus.vpd &

debug:
	./simv -l simv.log -gui -tbug +ntb_random_seed=$(SEED)

solution: clean
	cp ../../solutions/lab1/*.sv .

clean:
	rm -rf simv* csrc* *.tmp *.vpd *.key *.log urg*

nuke: clean
	rm -rf *.v* include *.sv .*.lock *.old .*.old DVE* *.tcl urg* *.h
	cp ../../solutions/lab1/.original/*.sv .

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
	@echo  " solution   => Copies all files from current solutions directory        "
	@echo  " nuke       => Erases all changes. Put all files back to original state "
	@echo  "				     			                "
	@echo ===========================================================================

