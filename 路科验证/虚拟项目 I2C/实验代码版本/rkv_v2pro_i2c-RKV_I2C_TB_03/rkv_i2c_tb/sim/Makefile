TOP       = rkv_i2c_tb
TEST     ?= rkv_i2c_quick_reg_access_test
VERDI    ?= 0
GUI      ?= 0
COV      ?= 0
SEED      = `date "+%m%d%H%M%S"`
OUT      ?= out
VERB     ?= UVM_HIGH#{UVM_NONE, UVM_LOW, UVM_MEDIUM, UVM_HIGH}
INCDIR   = +incdir+../../rkv_dw_apb_i2c/src \
					 +incdir+../agents/{lvc_apb3,lvc_i2c} \
					 +incdir+../{cfg,cov,reg,env,seq_lib} \
					 +incdir+../seq_lib/{.,elem_seqs,user_elem_seqs,user_virt_seqs} \
					 +incdir+../tests/{.,user_tests}
TESTLIST = rkv_i2c_quick_reg_access_test rkv_i2c_master_directed_write_packet_test rkv_i2c_master_directed_read_packet_test rkv_i2c_master_directed_interrupt_test 

VCOMP    = vlogan $(INCDIR) -full64 -sverilog -ntb_opts uvm-1.2 -timescale=1ps/1ps -l $(OUT)/log/comp_$(TB_TOP).log  
ELAB     = vcs -full64 -sverilog -ntb_opts uvm-1.2 -debug_all -l $(OUT)/log/elab_$(TB_TOP).log 
RUN      = simv +ntb_random_seed=$(SEED) +UVM_NO_RELNOTES +UVM_VERBOSITY=$(VERB) 
#COVOPTS  = -full64 -userdata ../doc/testcase.data -plan ../doc/rkv_i2c_vplan.hvp  -dir $(OUT)/cov.vdb 
COVOPTS  = -full64   -dir $(OUT)/cov.vdb 
CM_NAME  = $(TEST)_seed_$(SEED)

ifeq ($(VERDI),1)
	VCOMP  += -kdb
	RUN += -verdi
endif
ifeq ($(GUI),1)
	RUN += -gui
endif

ifeq ($(COV),1)
	ELAB  += -cm line+cond+fsm+tgl+branch+assert -cm_dir $(OUT)/cov.vdb
	RUN += -cm line+cond+fsm+tgl+branch+assert -covg_cont_on_error
endif

all: clean dcomp comp elab sim_all cov

prepare:
	mkdir -p $(OUT)/work
	mkdir -p $(OUT)/log
	mkdir -p $(OUT)/sim
	mkdir -p $(OUT)/obj
	mkdir -p .shadow
	mkdir -p ../doc/nd_docs

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
	$(RUN) +UVM_TESTNAME=$(TEST) -l $(OUT)/sim/$(CM_NAME).log -cm_dir $(OUT)/cov -cm_name $(CM_NAME)

regr: $(TESTLIST)
	for t in $(TESTLIST); do \
		$(RUN) +UVM_TESTNAME=$(TESTLIST) -l $(OUT)/sim/$(TESTLIST).log +vpdfile+$(OUT)/sim/$(TESTLIST)_$(SEED)_$(VPDFILE); \
	done

editcov:
	urg -format both $(COVOPTS)
	dve $(COVOPTS)

viewcov:
	urg -format both $(COVOPTS)
	firefox urgReport/dashboard.html

gendoc:
	mono /opt/NaturalDocs/NaturalDocs.exe ../doc/nd_config
  
viewdoc:
	firefox ../doc/nd_docs/index.html &

clean:
	-rm -rf csrc DVEfiles ucli.key uvm_dpi.so vc_hdrs.h  *simv* *.vpd *.log *.sml *.fsdb work.* *.vdb
	-rm -rf AN.DB urgReport novas.conf verdiLog vdCovLog novas.rc $(OUT) .shadow
	-rm -rf ../doc/nd_docs/*
	-rm -rf transcript vsim* regr_ucdb* work
