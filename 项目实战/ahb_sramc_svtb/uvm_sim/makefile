# Makefile 
#rtl_path = ../rtl/sramc
TB_TOP = ../uvm_tb/test.sv
#TB_TOP = ./tb.sv
AHB_IF= ../if/AHB_if.sv

UVM_HOME = ~/uvm-1.1_lab/uvm-1.1a
test = test_base
#HARNESS_TOP = $(rtl_path)/sramc_wrapper.sv
verbosity = UVM_MEDIUM
uvm_ver = uvm-1.1
#seed = 1
seed= $(shell data +%N)
defines = UVM_NO_DEPRECATED+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR
plus = 
option = UVM_TR_RECORD +UVM_LOG_RECORD
SOLVER = 2

all: compile run   
# *.sv $(DUT) $(HARNESS_TOP) $(TB_TOP)
compile: 
	vcs -Mupdate -cm line+cond+fsm -sverilog -ntb_opts ${uvm_ver} -timescale="1ns/100ps" -l comp.log -debug_all +vcs+vcdpluson \
	-y /eda/synopsys/syn/2012.06/packages/gtech/src_ver +libext+.v \
	$(AHB_IF) -f rtl.f $(TB_TOP) 
 
#$(HARNESS_TOP) $(TB_TOP) +define+${defines}

run:
	./simv -cm line+cond+fsm -l simv.log +ntb_random_seed=$(seed) +UVM_TESTNAME=$(test) +ntb_solver_mode=$(SOLVER) +UVM_VERBOSITY=$(verbosity) +${plus} +${option}

cov:
	dve -cov

clean:
	rm -rf simv* csrc* *.vpd *.log *.h *.key DVE* *.vdb transcript 
