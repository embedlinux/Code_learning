`timescale 1ns/100ps
// `include "router_io.sv"


module router_test_top;
	parameter simulation_cycle = 100;
	bit SystemClock;
       
	router_io top_io(SystemClock);
	test t(top_io);

	router dut(
		.reset_n	(top_io.reset_n),
		.clock		(top_io.clock),
		.frame_n	(top_io.framei_n),
		.valid_n	(top_io.validi_n),
		.din		(top_io.din),
		.dout		(top_io.dout),
		.busy_n		(top_io.busy_n),
		.valido_n	(top_io.valido_n),
		.frameo_n	(top_io.frameo_n)
	);
  	
	initial begin
		$timeformat(-9,1,"ns",10);
		SystemClock = 0;
		forever begin
			#(simulation_cycle/2)
			SystemClock = ~SystemClock;
		end
	end

endmodule: router_test_top
