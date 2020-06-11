all: compile simulate

rnd_seed = $(shell date +%s)
tc_num = 0

compile:
	vcs -l comp.log -sverilog -f rtl.f -debug_pp -timescale=1ns/1ns \
			-cm line+cond+fsm+tgl									\
			../tb/ahb_slv_if.sv										\
			../env/generator/generator.sv							\
			../env/agent/agent.sv									\
			../env/driver/driver.sv									\
			../env/monitor/monitor.sv								\
			../env/scoreboard/scoreboard.sv							\
			../env/transaction.sv									\
			../env/environment.sv									\
			../tests/ahb_sram_test.sv								\
			../tb/ahb_sramc_svtb_top.sv
			
simulate:
	./simv -l sim_$(tc_num).log +plusags_save	\
			+ntb_random_seed=$(rnd_seed)		\
			-cm line+cond+fsm+tgl				\
			-cm_dir test_$(tc_num)				\
			+tc_num=$(tc_num)
			
dve_wave:
	dve -vpd vcsplus.vpd &
	
dve_cov:
	dve -covdir simv.vdb &
	
log:
	sed '/^[^*].*/d' sim_$(tc_num).log > rslt.log

open:
	gvim rslt.log
clean:
	
	