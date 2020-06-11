// Example 3-1 New procedural statements and operators
initial begin : example
	integer array[10], sum, j;
	// Declare i in for statement
	for (int i=0; i<10; i++) 		// Increment i
		array[i] = i;
	// Add up values in the array
	sum = array[9];
	j=8;
	do 								// do...while loop
		sum += array[j]; 			// Accumulate
	while (j--); 					// Test if j=0
	$display("Sum=%4d", sum); 		// %4d - specify width
end : example 						// End label
	
// Example 3-2 Using break and continue while reading a file
initial begin
	logic [127:0] cmd;
	integer file, c;
	file = $fopen("commands.txt", "r");
	while (!$feof(file)) begin
		c = $fscanf(file, "%s", cmd);
		case (cmd)
			"": continue; 		// Blank line - skip to loop end
			"done": break; 		// Done - leave loop
								// Process other commands here
				...;
		endcase 				// case(cmd)
	end
	$fclose(file);
end

// Example 3-3 Ignoring a function’s return value
void(my_func(42));

// Example 3-4 Void function for debug
function void print_state(...);
	$display("@%0d: state = %0s", $time, cur_state.name);
endfunction

// Example 3-5 Simple task without begin...end
task multiple_lines;
	$display("First line");
	$display("Second line");
endtask : multiple_lines

// Example 3-6 Verilog-1995 routine arguments
task mytask2;
	output [31:0] x;
	reg [31:0] x;
	input y;
	...;
endtask

// Example 3-7 C-style routine arguments
task mytask1(output logic [31:0] x,input logic y);
	...;
endtask

// Example 3-8 Verbose Verilog-style routine arguments
task T3;
	input a, b;
	logic a, b;
	output [15:0] u, v;
	bit [15:0] u, v;
	...;
endtask

// Example 3-9 Routine arguments with sticky types
task T3(a, b, output bit [15:0] u, v);

// Example 3-10 Passing arrays using ref and const
function void print_sum (const ref int a[]);
	int sum = 0;
	for (int i=0; i<a.size; i++)
		sum += a[i];
	$display("The sum of the arrays is ", sum);
endfunction

// Example 3-11 Using ref across threads
task bus_read(input logic [31:0] addr,ref logic [31:0] data);
	// Request bus and drive address
	bus.request = 1’b1;
	@(posedge bus.grant) bus.addr = addr;
	// Wait for data from memory
	@(posedge bus.enable) data = bus.data;
	// Release bus and wait for grant
	bus.request = 1’b0;
	@(negedge bus.grant);
endtask
logic [31:0] addr, data;
initial
	fork
		bus_read(addr, data);
		begin
			@data; // Trigger on data change
			$display("Read %h from bus", data);
		end
	join
	
// Example 3-12 Function with default argument values
function void print_sum (ref int a[],input int start = 0,input int end = -1);
	int sum = 0, last;
	if (last == -1 || last > a.size)
		last = a.size;
	for (int i=start; i<last; i++) begin
		sum += a[i];
	$display("The sum of the arrays is ", sum);
endfunction

// Example 3-13 Using default argument values
print_sum(a); 			// Sum a[0:size-1] – default
print_sum(a, 2, 5); 	// Sum a[2:5]
print_sum(a, 1); 		// Start at 1
print_sum(a,, 3); 		// Sum a[0:3]
print_sum(); 			// error: a has no default

// 采用名字传递参数
task many(input a=1,b=2,c=3,d=4)
	$display("%0d %0d %0d %0d ",a,b,c,d);
endtask

initial begin
	many(6,7,8,9);  // a b c data
	many();
	many(.c(5)); 
	many(,6,.d(8)); 1 6 3 8
end

// Example 3-14 Original task header
task sticky(int a, b);

// Example 3-15 Task header with additional array argument
task sticky(ref int array[50],
			int a, b); 			// What direction are these?  ref

// Example 3-16 Task header with additional array argument
task sticky(ref int array[50],
			input int a, b); 	// Be explicit	

// Example 3-17 Return in a task
task load_array(int len, ref int array[]);
	if (len <= 0) begin
		$display("Bad len");
		return;
	end
	// Code for the rest of the task
	...;
endtask

// Example 3-18 Return in a function
function bit transmit(...);
	// Send transaction
	...;
	return ~ifc.cb.error; // Return status: 0=error
endfunction

// Example 3-19 Specifying automatic storage in program blocks
program automatic test;
	task wait_for_mem(input [31:0] addr, expect_data,
		output success);
		while (bus.addr !== addr)
			@(bus.addr);
		success = (bus.data == expect_data);
	endtask
	...;
endprogram

// Example 3-20 Static initialization bug
program initialization; // Buggy version
	task check_bus;
		repeat (5) @(posedge clock);
		if (bus_cmd == ‘READ) begin
			// When is local_addr initialized?
			reg [7:0] local_addr = addr<<2; // Bug
			$display("Local Addr = %h", local_addr);
		end
	endtask
endprogram

// Example 3-21 Static initialization fix: use automatic
program automatic initialization; // Bug solved
	...;
endmodule

// Example 3-22 Time literals and $timeformat
module timing;
	timeunit 1ns;
	timeprecision 1ps;
	initial begin
		$timeformat(-9, 3, "ns", 8);
		#1 $display("@%t", $realtime); 		// @1.000ns
		#2ns $display("@%t", $realtime); 	// @3.000ns
		#0.1ns $display("@%t", $realtime); 	// @3.100ns
		#41ps $display("@%t, $realtime);    // @3.141ns
	end
endmodule



