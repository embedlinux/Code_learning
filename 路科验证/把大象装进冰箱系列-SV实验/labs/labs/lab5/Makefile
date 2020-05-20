

RTL =  ../rtl/router.v
TB = router_test_top
OPTION = -sverilog +v2k +libext+.v +libext+.svh -debug_all  +incdir+./ -timescale=1ns/1ps -l comp.log \
		 -full64 -cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed \

VFILES = Packet.sv test.sv router_io.sv Driver.sv DriverBase.sv Generator.sv  Receiver.sv ReceiverBase.sv Scoreboard.sv $(TB).sv 

all: compile simulate

compile:
	vcs $(OPTION) $(RTL)  $(VFILES) -top $(TB) -o $(TB).simv

simulate:
	./$(TB).simv -l run.log -gui & 

clean:
	rm -rf *.simv.daidir csrc comp.log DVEfiles run.log *.simv ucli.key vcdplus.vpd inter.vpd *.h
