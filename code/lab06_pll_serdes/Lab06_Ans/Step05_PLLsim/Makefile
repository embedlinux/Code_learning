all: compile simulate

compile:
	vcs \
	-debug_all \
	-l com.log \
	-f verif.f 

simulate:
	./simv -l sim.log 

clean:
	@rm -rf csrc DVEfiles simv simv.daidir ucli.key VCS*
	@rm -rf *.log *.vpd *.ddc *.svf *.SDF *Synth *Netlist*
	@rm -rf alib-52 work vsim* transcript
