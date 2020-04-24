`ifndef __DUT_INTERFACE__SV__
`define __DUT_INTERFACE__SV__


interface dut_interface(input bit clk);

	logic			reset_n;
	logic [15:0]	din;
	logic [15:0]	frame_n;
	logic [15:0]	valid_n;
	logic [15:0]	dout;
	logic [15:0]	busy_n;
	logic [15:0]	valido_n;
	logic [15:0]	frameo_n;


	clocking driver_cb@(posedge clk);
		default input #1 output #0;
		output reset_n;
		output frame_n;
		output valid_n;
		output din;
		input  busy_n;
	endclocking


	clocking imonitor_cb@(posedge clk);
		default input #1 output #0;
		input  frame_n;
		input  valid_n;
		input  din;
		input  busy_n;
	endclocking


	clocking omonitor_cb@(posedge clk);
		default input #1 output #0;
		input  dout;
		input  valido_n;
		input  frameo_n;
	endclocking


	// clocking dut_cb@(posedge clk);
	// 	default input #1 output #0;
	// 	input  frame_n;
	// 	input  valid_n;
	// 	input  din;
	// 	output dout;
	// 	output busy_n;
	// 	output valido_n;
	// 	output frameo_n;
	// endclocking


	modport driver(clocking driver_cb, output reset_n);
	modport imonitor(clocking imonitor_cb);
	modport omonitor(clocking omonitor_cb);
	// modport dut_io(clocking dut_cb, input reset_n);



endinterface


`endif // __DUT_INTERFACE__SV__