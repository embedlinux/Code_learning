# Makefile for SVA Lab3
RTL= ../../rtl/router.v
SVTB = ./router_test_top.sv ./router_io.sv ./assert.sva ./assert_binds.sva ./test.sv
SEED = 1
BROWSER = firefox

default: test 

test: clean compile run

run:
	./simv -l simv.log +ntb_random_seed=$(SEED) -cm assert

compile:
	vcs -sverilog -ntb_opts dtm -debug_all $(SVTB) $(RTL) -assert dve -assert enable_diag -cm assert

compile_no_assert:
	vcs -sverilog -ntb_opts dtm -debug_all $(SVTB) $(RTL)

copy: 
	cp ../../solutions/lab2/*.sv .
	cp ../../solutions/lab2/*.sva .
	rm assert.sva
	cp ../../solutions/lab2/.lab3/assert.sva .
	

my_copy:
	cp ../lab2/*.sv .
	cp ../lab2/*.sva .

urg:
	urg -dir simv.vdb
	urg -dir simv.vdb -format text
	$(BROWSER) $(PWD)/urgReport/asserts.html &

coverage:
	$(BROWSER) $(PWD)/urgReport/asserts.html &

dve:
	dve -vpd vcdplus.vpd &

debug:
	./simv -l simv.log -gui -tbug +ntb_random_seed=$(SEED)

solution: clean
	cp ../../solutions/lab3/*.sv .
	cp ../../solutions/lab3/*.sva .

clean:
	rm -rf simv* csrc* *.tmp *.vpd *.key *.log urg*

nuke: clean
	rm -rf *.v* include *.sv .*.lock *.old .*.old DVE* *.tcl urg* *.h
	cp ../../solutions/lab2/*.sv .
	cp ../../solutions/lab2/*.sva .
	rm assert.sva
	cp ../../solutions/lab2/.lab3/assert.sva .

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
