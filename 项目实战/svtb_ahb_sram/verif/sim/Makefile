
SEED = $(shell date +%s)

all:  compile simulate



compile:
	vcs -l comp.log -sv -mfcu -f rtl.f  \
		+incdir+../agent/ahb \
		+incdir+../env \
		+incdir+../tests \
		+incdir+../tb \
		../agent/ahb/ahb_slv_if.sv \
		../agent/ahb/ahb_slv_pkt.sv \
		../agent/ahb/ahb_slv_generator.sv \
		../agent/ahb/ahb_slv_driver_base.sv \
		../agent/ahb/ahb_slv_driver.sv \
		../tests/ahb_sramc_base_test.sv \
		../tb/ahb_sramc_svtb_top.sv


simulate:
	vsim -coverage -assertdebug -sv_seed $(SEED) ahb_sramc_svtb_top -l sim.log -novopt -do "log -r *; assertion enable -on; coverage save ./test.ucdb; add wave /ahb_sramc_svtb_top/u_sramc_top/*; run -all"

clean: 
	rm -rf work mti_lib transcript modelsim.ini *.log *.wlf test.ucdb
