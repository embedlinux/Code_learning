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


