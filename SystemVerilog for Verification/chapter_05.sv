// Example 5-1 Arbiter model using ports
module arb_port (output logic [1:0] grant,
				input logic [1:0] request,
				input logic reset,
				input logic clk);
	...;
	always @(posedge clk or posedge reset) begin
	if (reset)
		grant <= 2'b00;
	else
		...;
	end
endmodule

// Example 5-2 Testbench using ports
module test(input logic [1:0] grant,
			output logic [1:0] request,
			output logic reset,
			input logic clk);
	initial begin
		@(posedge clk) 
			request <= 2'b01;
		$display("@%0d: Drove req=01", $time);
		repeat (2) @(posedge clk);
		if (grant != 2'b01)
			$display("@%0d: a1: grant != 2'b01", $time);
			...;
			$finish;
	end
endmodule

// Example 5-3 Top-level netlist without an interface
module top;
	logic [1:0] grant, request;
	logic clk=0, reset;
	always #5 clk = ~clk;
	arb_port a1 (grant, request, reset, clk);
	test t1(grant, request, reset, clk);
endmodule

// Example 5-4 Simple interface for arbiter
interface arb_if(input bit clk);
	logic [1:0] grant, request;
	logic reset;
endinterface

// Example 5-5 Testbench using a simple arbiter interface
module test (arb_if arbif);
	...;
	initial begin
		// reset code left out
		@(posedge arbif.clk);
			arbif.request <= 2'b01;
		$display("@%0d: Drove req=01", $time);
		repeat (2) @(posedge arbif.clk);
		if (arbif.grant != 2'b01)
			$display("@%0d: a1: grant != 2'b01", $time);
		$finish;
	end
endmodule : test

// Example 5-6 Arbiter using a simple interface
module arb (arb_if arbif);
	...;
	always @(posedge arbif.clk or posedge arbif.reset)
		begin
		if (arbif.reset)
			arbif.grant <= 2'b00;
		else
			arbif.grant <= next_grant;
		...;
		end
endmodule

// Example 5-7 Top module using a simple arbiter interface
module top;
	bit clk;
	always #5 clk = ~clk;
	arb_if arbif(clk);
	arb a1 (arbif);
	test t1(arbif);
endmodule : top

// Example 5-8 Connecting an interface to a module that uses ports
module top;
	bit clk;
	always #5 clk = ~clk;
	arb_if arbif(clk);
	arb_port a1 (.grant (arbif.grant),
				.request (arbif.request),
				.reset (arbif.reset),
				.clk (arbif.clk));
	test t1(arbif);
endmodule : top

// Example 5-9 Interface with modports
interface arb_if(input bit clk);
	logic [1:0] grant, request;
	logic reset;
	modport TEST (output request, reset, input grant, clk);
	modport DUT (input request, reset, clk,output grant);
	modport MONITOR (input request, grant, reset, clk);
endinterface

// Example 5-10 Arbiter model with interface using modports
module arb (arb_if.DUT arbif);
	...;
endmodule

// Example 5-11 Testbench with interface using modports
module test (arb_if.TEST arbif);
	...;
endmodule

Example 5-12 Arbiter model with interface using modports
module monitor (arb_if.MONITOR arbif);
	always @(posedge arbif.request[0]) begin
		$display("@%0d: request[0] asserted", $time);
		@(posedge arbif.grant[0]);
		$display("@%0d: grant[0] asserted", $time);
	end
	always @(posedge arbif.request[1]) begin
		$display("@%0d: request[1] asserted", $time);
		@(posedge arbif.grant[1]);
		$display("@%0d: grant[1] asserted", $time);
	end
endmodule

// Example 5-13 Interface with a clocking block
interface arb_if(input bit clk);
	logic [1:0] grant, request;
	logic reset;
	clocking cb @(posedge clk); // Declare cb
		output request;
		input grant;
	endclocking
	modport TEST (clocking cb, output reset);
	modport DUT (input request, reset, output grant);
endinterface

// Example 5-14 Race condition between testbench and design
module memory(input wire start, write,
			input wire [7:0] addr, data);
			logic [7:0] mem[256];
	always @(posedge start) begin
		if (write)
			mem[addr] = data;
		...;
	end
endmodule

module test(output logic start, write,
			output logic [7:0] addr, data);
	initial begin
		start = 0; 		// Initialize signals
		write = 0;
		#10; 			// Short delay
		start = 1; 		// Start first command
		write = 1;
		addr = 8’h42;
		data = 8’h5a;
		...;
	end
endmodule

// Example 5-15 Testbench using interface with clocking block
program automatic test (arb_if.TEST arbif);
	...;
	initial begin
		arbif.cb.request <= 2'b01;
		$display("@%0d: Drove req=01", $time);
		repeat (2) @arbif.cb;
		if (arbif.cb.grant != 2'b01)
			$display("@%0d: a1: grant != 2'b01", $time);
	end
endprogram : test

// Example 5-16 Signal synchronization
program automatic test(bus_if.TB bus);
	initial begin
		@bus.cb; 					// Continue on active edge in clocking block
		repeat (3) @bus.cb; 		// Wait for 3 active edges
		@bus.cb.grant; 				// Continue on any edge
		@(posedge bus.cb.grant); 	// Continue on posedge
		@(negedge bus.cb.grant); 	// Continue on negedge
		wait (bus.cb.grant==1); 	// Wait for expression , No delay if already true
		@(posedge bus.cb.grant or negedge bus.reset); 		// Wait for several signals
	end
endprogram

// Example 5-17 Synchronous interface sample and module drive
program test(arb_if.TEST arbif);
	initial begin
		$monitor("@%0d: grant=%h", $time, arbif.cb.grant);
		#50 $display("End of test");
	end
endprogram
module arb(arb_if.DUT arbif);
	initial begin
		#7  arbif.grant = 1; // @ 7ns
		#12 arbif.grant = 2; // @ 12ns
		#18 arbif.grant = 3; // @ 30ns
	end
endmodule

// Example 5-18 Testbench using interface with clocking block
program automatic test (arb_if.TEST arbif);
	initial begin
		arbif.cb.request <= 2'b01;
		$display("@%0d: Drove req=01", $time);
		repeat (2) @arbif.cb;
		if (arbif.cb.grant != 2'b01)
			$display("@%0d: a1: grant != 2'b01", $time);
	end
endprogram : test

// Example 5-19 Interface signal drive
busif.cb.request <= 1; 			// Nonblocking sync drive
busif.cb.cmd <= cmd_buf; 		// Nonblocking sync drive

// Example 5-20 Driving a synchronous interface
program test(arb_if.TEST arbif);
	initial begin
		# 2 arbif.cb.request <= 3; // @ 2ns
		#10 arbif.cb.request <= 2; // @ 12ns
		#18 arbif.cb.request <= 1; // @ 30ns
		#50 finish;
	end
endprogram
module arb(arb_if.DUT arbif);
	initial
		$monitor("@%0d: req=%h", $time, arbif.request);
endmodule

// Example 5-21 Interface signal drive
##2 arbif.cb.request <= 0; 	// Wait 2 cycles then assign
##3; 						// Illegal - must be used with an assignment

// Example 5-22 Bidirectional signals in a program and interface
interface master_if (input bit clk);
	wire [7:0] data; 				// Bidirectional signal
	clocking cb @(posedge clk);
		inout data;
	endclocking
	modport TEST (clocking cb);
endinterface
program test(master_if mif);
	initial begin
		mif.cb.data <= 'z; 			// Tri-state the bus
		@mif.cb;
		$displayh(mif.cb.data); 	// Read from the bus
		@mif.cb;
		mif.cb.data <= 7’h5a; 		// Drive the bus
		@mif.cb;
		mif.cb.data <= 'z; 			// Release the bus
	end
endprogram

// Example 5-23 Bad clock generator in program block
program bad_generator (output bit clk, out_sig);
	bit clk=0, out_sig=0;
	initial
		forever #5 clk <= ~clk ;
	initial
		forever @(posedge clk)
		out_sig <= ~out_sig;
endprogram

// Example 5-24 Good clock generator in module
module clock_generator (output bit clk);
	bit clk = 1;
	always #5 clk = ~clk; // Use blocking assignment
endmodule

// Example 5-26 Top-level scope for arbiter design
// root.sv
`timescale 1ns/1ns
parameter int TIMEOUT = 1_000_000;
const string time_out_msg = "ERROR: Time out";
module top;
	test t1(.*);
endmodule
program automatic test;
	...;
	initial begin
		#TIMEOUT;
		$display("%s", time_out_msg);
		$finish;
	end
endprogram

// Example 5-27 Cross-module references with $root
// root.sv
`timescale 1ns/1ns
parameter TIMEOUT = 1_000_000;
top t1(); // Explicitly instantiate top-level module
module top;
	bit clk;
	test t1(.*);
endmodule
program automatic test;
	...;
	initial begin
	// Absolute reference
	$display("clk=%b", $root.t1.clk)
	// Relative reference
	$display("clk=%b", t1.clk)
endprogram

// Example 5-28 Checking a signal with an if-statement
bus.cb.request <= 1;
repeat (2) @bus.cb;
if (bus.cb.grant != 2’b01)
	$display("Error, grant != 1");
// rest of the test

// Example 5-29 Simple procedural assertion
bus.cb.request <= 1;
repeat (2) @bus.cb;
a1: assert (bus.cb.grant == 2’b01);
// rest of the test

// Example 5-30 Error from failed procedural assertion
"test.sv", 7: top.t1.a1: started at 55ns failed at 55ns
Offending '(bus.cb.grant == 2’b1)'

// Example 5-31 Creating a custom error message in a procedural assertion
a1: assert (bus.cb.grant == 2’b01)
else $error("Grant not asserted");

// Example 5-32 Error from failed procedural assertion
"test.sv", 7: top.t1.a1: started at 55ns failed at 55ns
Offending '(bus.cb.grant == 2’b1)'
Error: "test.sv", 7: top.t1.a1: at time 55 ns
Grant not asserted

// Example 5-33 Creating a custom error message
a1: assert (bus.cb.grant == 2’b01)
	grants_received++; // Another succesful result
else
	$error("Grant not asserted");
	
// Example 5-34 Concurrent assertion to check for X/Z
interface arb_if(input bit clk);
	logic [1:0] grant, request;
	logic reset;
	property request_2state;
		@(posedge clk) disable iff (reset);
		$isunknown(request) == 0;       // 确保没有z或者x值存在
	endproperty
	assert_request_2state: assert property request_2state
endinterface

// Example 5-38 Rx interface
// Rx interface with modports and clocking block
interface Rx_if (input logic clk);
	logic [7:0] data;
	logic soc, en, clav, rclk;
	clocking cb @(posedge clk);
		output data, soc, clav; // Directions are relative
		input en; // to the testbench
	endclocking : cb
	modport DUT (output en, rclk, input data, soc, clav);
	modport TB (clocking cb);
endinterface : Rx_if

// Example 5-39 Tx interface
// Tx interface with modports and clocking block
interface Tx_if (input logic clk);
	logic [7:0] data;
	logic soc, en, clav, tclk;
	clocking cb @(posedge clk);
		input data, soc, en;
		output clav;
	endclocking : cb
	modport DUT (output data, soc, en, tclk, input clk, clav);
	modport TB (clocking cb);
endinterface : Tx_if

// Example 5-40 ATM router model with interface using modports
module atm_router(	Rx_if.DUT Rx0, Rx1, Rx2, Rx3,
					Tx_if.DUT Tx0, Tx1, Tx2, Tx3,
					input logic clk, rst);
	...;
endmodule

// Example 5-41 Top-level netlist with interface
module top;
	bit clk, rst;
	always #5 clk = !clk;
	
	Rx_if Rx0 (clk), Rx1 (clk), Rx2 (clk), Rx3 (clk);
	Tx_if Tx0 (clk), Tx1 (clk), Tx2 (clk), Tx3 (clk);
	atm_router a1(	Rx0, Rx1, Rx2, Rx3,
					Tx0, Tx1, Tx2, Tx3, clk, rst);   // 或者仅使用(.*)
	test t1(Rx0, Rx1, Rx2, Rx3,
			Tx0, Tx1, Tx2, Tx3, clk, rst);			 // 或者仅使用(.*)
endmodule : top

// Example 5-42 Testbench using interface with clocking block
program test(	Rx_if.TB Rx0, Rx1, Rx2, Rx3,
				Tx_if.TB Tx0, Tx1, Tx2, Tx3,
				input logic clk, output logic rst);
	bit [7:0] bytes[ATM_CELL_SIZE];
	initial begin
		// Reset the device
		rst <= 1;
		Rx0.cb.data <= 0;
		...;
		receive_cell0();
		...;
	end
	task receive_cell0();
		@(Tx0.cb);
		Tx0.cb.clav <= 1; 			// Assert ready to receive
		wait (Tx0.cb.soc == 1); 	// Wait for Start of Cell
		for (int i=0; i<ATM_CELL_SIZE; i++) begin
			wait (Tx0.cb.en == 0); // Wait for enable
			@(Tx0.cb);
			bytes[i] = Tx0.cb.data;
			@(Tx0.cb);
			Tx0.cb.clav <= 0; 		// Deassert flow control
		end
	endtask : receive_cell0
endprogram : test



