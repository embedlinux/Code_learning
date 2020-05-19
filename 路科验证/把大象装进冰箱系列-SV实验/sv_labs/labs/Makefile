
# User variables
RTL = ../rtl/router.v
TB = router_test_top
VFILE =  router_io.sv test.sv $(TB).sv
SEED = 2
export demo_name = tb1_wave
# Environment variables
VCOMP = vcs -sverilog -debug_acc+all  -timescale=1ns/100ps +libext+.v +incdir+./ -l compile.log
RUN   = ./$(TB).simv  +ntb_random_seed=$(SEED) -gui &
# RUN   = ./$(TB).simv -l sim.log  +ntb_random_seed=$(SEED) -ucli -i ../scripts/dump_fsdb_vcs.tcl \
	+fsdb+autoflush
all: cmp_vcs sim_vcs

cmp_vcs:
	@echo " ->   Compile the TB Code            "
	@echo "Now compiling the testbench, please wait ..."
	$(VCOMP) $(RTL) $(VFILE) -top $(TB) -o $(TB).simv
	@echo "Compiling testbench completed!"

sim_vcs:
	@echo " ->   Run the simulation             "
	@echo "Now running the simulation: "
	$(RUN)
	@echo "Running simulation completed. Exiting the simulator!" 
	@echo "Well done! Congratulations !!!"
g_sim:
	$(RUN) -gui &

clean: 
	rm -rf csrc *simv* vcdplus.vpd vcs.key  urgReport DVE* *.log *.vpd ucli.key AN.DB *.sml *.h
