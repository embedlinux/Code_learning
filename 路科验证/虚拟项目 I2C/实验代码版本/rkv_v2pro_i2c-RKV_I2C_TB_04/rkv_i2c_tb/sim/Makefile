TOP       = rkv_i2c_tb
TEST     ?= rkv_i2c_quick_reg_access_test
VERDI    ?= 0
GUI      ?= 0
COV      ?= 0
PARTCOMP ?= 1
SEED      = `date "+%m%d%H%M%S"`
OUT      ?= out
VERB     ?= UVM_HIGH#{UVM_NONE, UVM_LOW, UVM_MEDIUM, UVM_HIGH}
INCDIR   = +incdir+../../rkv_dw_apb_i2c/src \
					 +incdir+../agents/{lvc_apb3,lvc_i2c} \
					 +incdir+../{cfg,cov,reg,env,seq_lib} \
					 +incdir+../seq_lib/{.,elem_seqs,user_elem_seqs,user_virt_seqs} \
					 +incdir+../tests/{.,user_tests}
TESTLIST = rkv_i2c_quick_reg_access_test rkv_i2c_master_directed_write_packet_test rkv_i2c_master_directed_read_packet_test rkv_i2c_master_directed_interrupt_test 

VCOMP    = vlogan $(INCDIR) -full64 -sverilog -ntb_opts uvm-1.2 -timescale=1ps/1ps -l $(OUT)/log/comp_$(TOP).log  
ELAB     = vcs -full64 -sverilog -ntb_opts uvm-1.2 -debug_acc+all -debug_region+cell+encrypt -l $(OUT)/log/elab_$(TOP).log -o $(OUT)/obj/rkv_i2c_tb.simv
RUN      = $(OUT)/obj/rkv_i2c_tb.simv +ntb_random_seed=$(SEED) +UVM_NO_RELNOTES +UVM_VERBOSITY=$(VERB) 
#COV_OPTS  = -full64 -userdata ../doc/testcase.data -plan ../doc/vcs_vplan.hvp  -dir $(OUT)/cov.vdb 
COV_OPTS = -full64 -userdata ../doc/testcase.data -plan ../doc/vcs_vplan.hvp -dir $(CM_DIR)
CM_DIR  ?= $(OUT)/cov.vdb
CM_NAME ?= $(TEST)_$(SEED)

ifeq (1, $(strip $(PARTCOMP)))
  ELAB += -partcomp -fastpartcomp=j4 
endif

ifeq ($(VERDI),1)
	VCOMP  += -kdb
	RUN += -verdi
endif
ifeq ($(GUI),1)
	RUN += -gui
endif

ifeq ($(COV),1)
	ELAB  += -cm line+cond+fsm+tgl+branch+assert -cm_dir $(CM_DIR)
	RUN += -cm line+cond+fsm+tgl+branch+assert -covg_cont_on_error
endif

export SYNOPSYS_SIM_SETUP = ./synopsys_sim.setup

all: clean dcomp comp elab sim_all cov

prepare:
	mkdir -p $(OUT)/work
	mkdir -p $(OUT)/log
	mkdir -p $(OUT)/sim
	mkdir -p $(OUT)/obj
	mkdir -p .shadow

dcomp: prepare
	$(VCOMP)  -f rkv_i2c.flist 

comp: .shadow/compile_uvm .shadow/compile_lvc_apb .shadow/compile_lvc_i2c
	$(VCOMP)  ../env/rkv_i2c_pkg.sv 
	$(VCOMP)  ../tb/rkv_i2c_if.sv 
	$(VCOMP)  ../tb/rkv_i2c_tb.sv 

.shadow/compile_uvm:
	${VCOMP} -ntb_opts uvm-1.2
	@touch $@;

.shadow/compile_lvc_apb:
	$(VCOMP) ../agents/lvc_apb3/lvc_apb_if.sv 
	$(VCOMP) ../agents/lvc_apb3/lvc_apb_pkg.sv 
	#@touch $@;

.shadow/compile_lvc_i2c:
	$(VCOMP)  ../agents/lvc_i2c/lvc_i2c_if.sv 
	$(VCOMP)  ../agents/lvc_i2c/lvc_i2c_pkg.sv 
	#@touch $@;

elab: comp
	$(ELAB) $(TOP)

run: 
	$(RUN) +UVM_TESTNAME=$(TEST) -l $(OUT)/sim/$(CM_NAME).log -cm_dir $(CM_DIR) -cm_name $(CM_NAME)

regr: $(TESTLIST)
	for t in $(TESTLIST); do \
		$(RUN) +UVM_TESTNAME=$(TESTLIST) -l $(OUT)/sim/$(TESTLIST).log +vpdfile+$(OUT)/sim/$(TESTLIST)_$(SEED)_$(VPDFILE); \
	done


mergecov:
	urg -format both $(COV_OPTS)

dvecov:
	dve $(COV_OPTS)

verdicov:
	verdi -cov -plan ../doc/vcs_vplan.hvp -covdir $(CM_DIR)

htmlcov:
	firefox urgReport/dashboard.html

clean:
	-rm -rf csrc DVEfiles ucli.key uvm_dpi.so vc_hdrs.h  *simv* *.vpd *.log *.sml *.fsdb work.* *.vdb
	-rm -rf AN.DB urgReport novas.conf verdiLog vdCovLog novas.rc $(OUT) .shadow
	-rm -rf eman* vhdl_objs_dir
	-rm -rf transcript vsim* regr_ucdb* work rkv_i2c_tb rkv_i2c_tb.vdb
