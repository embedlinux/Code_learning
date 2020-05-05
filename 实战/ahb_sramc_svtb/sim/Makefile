#2011-6-8
#Makefile
# run the testcase
make run TC=reg_cfg_00


RTL =../rtl/DW_ahb/DW_ahb_wrapper.sv\
      ../rtl/DW_ahb/DW_ahb.v\
      ../rtl/sramc/sramc_wrapper.sv\
      ../rtl/sramc/sramc_top.v\
      ../rtl/sramc/sramc.v\
      ../rtl/sramc/sram_bank_top.v\
      ../rtl/sramc/sram_bank.v\
      ../rtl/sramc/sramc_cs.v\
      ../rtl/sramc/sramc_fsm.v\
      ../rtl/sramc/SRAM_DP_4KX8.v

TB  = ../tb/tb.sv
IF  = ../if/AHB_if.sv
#TC = ../tc/tcn_random_test.sv     
TC  = ../tc/tcn_reg_cfg.sv     
TCC =
#TC = ../tc/tcn_reg_test.sv     

#CMP_OP = -y /usr/synopsys/dc/2009-6/packages/gtech/src_ver \

# Need to modify 
CMP_OP = -y /home/klin/synopsys/syn/2012.06/packages/gtech/src_ver\
         +libext+.v \
	       -sverilog\
	       -debug_all\
	       -R -M\
	       -l sim.log
	 
SEED = 1

cov:	 
	 urg -dir ./simv.vdb\
	 urg -dir simv.vdb -format text

compile:
	vcs \
	$(CMP_OP) \
	$(IF) \
	$(RTL) \
	$(TC) \
	$(TB) 

cp:
	cp ../tc/$(TC).sv tcc.sv

run: compile

clean: 
	rm\
	 -rf csrc simv* vcdplus.vpd vcs.key  urgReport DVE* *.log *.vpd ucli.key
