
// Example 2-1 Using the logic type
module logic_data_type(input logic rst_h);
	parameter CYCLE = 20;
	logic q, q_l, d, clk, rst_l;
	initial begin
		clk <= 0; 						// Procedural assignment
		forever #(CYCLE/2) clk = ~clk;
	end
	assign rst_l = ~rst_h; 				// Continuous assignment
	not n1(q_l, q); 					// q_l is driven by gate
	my_dff d1(q, d, clk, rst_l); 		// d1 is driven by module
endmodule

// Example 2-2 Signed data types
bit b; 					// 2-state, single-bit
bit [31:0] b32; 		// 2-state, 32-bit unsigned integer
int i; 					// 2-state, 32-bit signed integer
byte b8; 				// 2-state, 8-bit signed integer
shortint s; 			// 2-state, 16-bit signed integer
longint l; 				// 2-state, 64-bit signed integer

// Example 2-3 Checking for four-state values
if ($isunknown(iport))
	$display("@%0d: 4-state value detected on input port",$time, iport);
	
// Example 2-4 Declaring fixed-size arrays 
int lo_hi[0:15]; // 16 ints [0]..[15]
int c_style[16]; // 16 ints [0]..[15]

// Example 2-5 Declaring and using multidimensional arrays
int array2 [0:7][0:3]; 	// Verbose declaration
int array3 [8][4]; 		// Compact declaration
array2[7][3] = 1; 		// Set last array element

// Example 2-6 Unpacked array declarations
bit [7:0] b_unpacked[3]; // Unpacked

// Example 2-7 Initializing an array
int ascend[4] = '{0,1,2,3}; 		// Initialize 4 elements
int decend[5];
int md[2][3] = '{'{0,1,2}, '{3,4,5}};
descend = '{4,3,2,1,0}; 			// Set 5 elements
descend[0:2] = '{5,6,7}; 			// Set first 3 elements
ascend = '{4{8}}; 					// Four values of 8
descend = '{9,8,default:1}          //{9,8,1,1,1}

// Example 2-8 Using arrays with for and foreach loops
initial begin
	bit [31:0] src[5], dst[5];
	for (int i=0; i<$size(src); i++)
		src[i] = i;
	foreach (dst[j])
		dst[j] = src[j] * 2; // dst doubles src values
end

// Example 2-9 Initialize and step through a multidimensional array
int md[2][3] = '{'{0,1,2},'{3,4,5}};
initial begin
	$display("Initial value:");
	foreach (md[i,j]) 						// Yes, this is the right syntax
		$display("md[%0d][%0d] = %0d", i, j, md[i][j]);
	$display("New value:");
	md = '{'{9, 8, 7}, '{3{32'd5}}}; 		// Replicate last 3 values
	foreach (md[i,j]) 						// Yes, this is the right syntax
		$display("md[%0d][%0d] = %0d", i, j, md[i][j]);
end

// Example 2-10 Output from printing multidimensional array values
/*
	Initial value:
		md[0][0] = 0
		md[0][1] = 1
		md[0][2] = 2
		md[1][0] = 3
		md[1][1] = 4
		md[1][2] = 5
	New value:
		md[0][0] = 9
		md[0][1] = 8
		md[0][2] = 7
		md[1][0] = 5
		md[1][1] = 5
		md[1][2] = 5
*/

// Example 2-11 Array copy and compare operations
initial begin
	bit [31:0] 	src[5] = '{0,1,2,3,4},
				dst[5] = '{5,4,3,2,1};
	// Aggregate compare the two arrays
	if (src==dst)
		$display("src == dst");
	else
		$display("src != dst");
		// Aggregate copy all src values to dst
	dst = src;
		// Change just one element
	src[0] = 5;
		// Are all values equal (no!)
	$display("src %s dst", (src == dst) ? "==" : "!=");
		// Are last elements 1-4 equal (yes!)
	$display("src[1:4] %s dst[1:4]",(src[1:4] == dst[1:4]) ? "==" : "!=");
end

// Example 2-12 Using word and bit subscripts together
initial begin
	bit [31:0] src[5] = `{5{5}};
	$displayb(src[0],, 		// 'b101 or 'd5
			  src[0][0],, 	// 'b1
	          src[0][2:1]); // 'b10
end

// Example 2-13 Packed array declaration and usage
bit [3:0] [7:0] bytes; // 4 bytes packed into 32-bits
bytes = 32'hdead_beef;
$displayh(bytes,, // Show all 32-bits
		  bytes[3], // most significant byte "de"
		  bytes[3][7]); // most significant bit "1"
		  
// Example 2-14 Declaration for mixed packed/unpacked array
bit [3:0] [7:0] barray [3]; // Packed: 3x32-bit
bit [31:0] 1w=32'h0123_4567;  // World
bit [7:0][3:0] nibbles;     // Packed array
barray[0] = 1w;
barray[0][3] = 8'h01;
barray[0][1][6] = 1'b1;
nibbles = barray[0];

// Example 2-15 Using dynamic arrays
int dyn[], d2[]; 				// Empty dynamic arrays
initial begin
	dyn = new[5]; 				// Allocate 5 elements
	foreach (dyn[j])
		dyn[j] = j; 			// Initialize the elements
	d2 = dyn; 					// Copy a dynamic array
	d2[0] = 5; 					// Modify the copy
	$display(dyn[0],d2[0]); 	// See both values (0 & 5)
	dyn = new[20](dyn); 		// Expand and copy
	dyn = new[100]; 			// Allocate 100 new integers, Old values are lost
	dyn.delete; 					// Delete all elements
end

// Example 2-16 Using a dynamic array for an uncounted list
bit [7:0] mask[] = ’{8’b0000_0000, 8’b0000_0001,
					 8’b0000_0011, 8’b0000_0111,
					 8’b0000_1111, 8’b0001_1111,
					 8’b0011_1111, 8’b0111_1111,
					 8’b1111_1111};

// Example 2-17 Queue operations
int j = 1,
	b[$] = {3,4},
	q[$] = {0,2,5}; // {0,2,5} Initial queue
initial begin
	q.insert(1, j); // {0,1,2,5} Insert 1 before 2
	q.insert(3, b); // {0,1,2,3,4,5} Insert whole q.
	q.delete(1); 	// {0,2,3,4,5} Delete elem. #1
// The rest of these are fast
	q.push_front(6); // {6,0,2,3,4,5} Insert at front
	j = q.pop_back; //  {6,0,2,3,4} j = 5
	q.push_back(8); //  {6,0,2,3,4,8} Insert at back
	j = q.pop_front; // {0,2,3,4,8} j = 6
	foreach (q[i])
		$display(q[i]);
end

// 例子:队列操作
int j = 1,
	q2[$] = {3,4},
	q[$] = {0,2,5}; // {0,2,5} Initial queue
initial begin				// 结果
	q = {q[0],j,q[1:$]};	// {0,1,2,5}
	q = {q[0:2],q2,q[3:$]}; // {0,1,2,3,4,5}
	q = {q[0],q[2:$]};		// {0,2,3,4,5}
	
	q = {6, q};				// {6,0,2,3,4,5}
	j = q{$};				// j = 5
	q = q{0:$-1};
	q = {q, 8};
	j = q[0];
	q = q[1:$];
	q = {};					// 删除整个队列
end

// Example 2-18 Declaring, initializing, and using associative arrays
initial begin
	logic [63:0] assoc[bit[63:0]], idx = 1;
	// Initialize widely scattered values
	repeat (64) begin
		assoc[idx] = idx;
		idx = idx << 1;
	end
	// Step through all index values with foreach
	foreach (assoc[i])
		$display("assoc[%h] = %h", i, assoc[i]);
	// Step through all index values with functions
	if (assoc.first(idx))
		begin // Get first index
			do
				$display("assoc[%h]=%h", idx, assoc[idx]);
			while (assoc.next(idx)); // Get next index
		end
	// Find and delete the first element
	assoc.first(idx);
	assoc.delete(idx);
end

// Example 2-19 Using an associative array with a string index
/*
Input file looks like:
42 min_address
1492 max_address
*/
int switch[string], min_address, max_address;
initial begin
	int i, r, file;
	string s;
	file = $fopen("switch.txt", "r");
	while (! $feof(file)) begin
		r = $fscanf(file, "%d %s", i, s);
		switch[s] = i;
	end
	$fclose(file);
	// Get the min address, default is 0
	mid_address = switch["min_address"];
	// Get the max address, default = 1000
	if (switch.exists("max_address"))
		max_address = switch["max_address"];
	else
		max_address = 1000;
	foreach (switch[s])
		$display("switch['%s']=%0d",s,switch[s]);
end

// Example 2-20 Creating the sum of an array
bit on[10]; 								// Array of single bits
int summ;
initial begin
	foreach (on[i])
		on[i] = i; 							// on[i] gets 0 or 1
	// Print the single-bit sum
	$display("on.sum = %0d", on.sum); 		// on.sum = 1
	// Sum the values using 32-bits as summ is 32-bits
	summ = on.sum;
	$display("summ = %0d", summ); 			// summ = 5
	// Compare the sum to a 32-bit value
	if (on.sum >=32’d5) 					// True
		$display("sum has 5 or more 1’s");
	// 使用带32比特有符号运算的with表达式
	$display("int sum=%0d",on.sum with (int'(item)));
end

// 例子:从关联数组中随机选择一个元素
int aa[int], rand_idx,element, count;
element=$urandom_range(aa.size()-1);
foreach(aa[i])
	if (count++ == element) begin
		rand_idx = i;
		break;
	end
$display("%0d element aa[%0d]=%0d",element,rand_idx,aa[rand_idx]);

// Example 2-21 Array locator methods: min, max, unique
int f[6] = ‘{1,6,2,6,8,6};
int q[$] = ‘{1,3,5,7}, tq[$];
tq = q.min(); // {1}
tq = q.max(); // {7}
tq = f.unique(); // {1,6,2,8}

// Example 2-22 Array locator methods: find
int d[] = ‘{9,1,8,3,4,4}, tq[$];
// Find all elements greater than 3
tq = d.find with (item > 3); // {9,8,4,4}
// Equivalent code
tq.delete;
foreach (d[i])
	if (d[i] > 3)
		tq.push_back(d[i]);
tq = d.find_index with (item > 3); 		// {0,2,4}
tq = d.find_first with (item > 99); 	// {} – none found
tq = d.find_first_index with (item==8); // {2} d[2]=8
tq = d.find_last with (item==4); 		// {4}
tq = d.find_last_index with (item==4); 	// {6} d[5]=4

// Example 2-23 Array locator methods
int count, d[] = ‘{9,1,8,3,4,4};
count = d.sum with (item > 7); 	// 2: {9, 8}
count = d.sum with (item < 8); 	// 4: {1, 3, 4, 4}
count = d.sum with (item == 4); // 2: {4, 4}

// Example 2-24 User-defined type-macro in Verilog
// Old Verilog style
`define OPSIZE 8
`define OPREG reg [`OPSIZE-1:0]
`OPREG op_a, op_b;

// Example 2-25 User-defined type in SystemVerilog
// New SystemVerilog style
parameter OPSIZE = 8;
typedef reg [OPSIZE-1:0] opreg_t;
opreg_t op_a, op_b;

// Example 2-26 Definition of uint
typedef bit [31:0] uint; // 32-bit unsigned 2-state
typedef int unsigned uint; // Equivalent definition

// Example 2-27 Creating a single pixel type
struct {bit [7:0] r, g, b;} pixel;

// Example 2-28 The pixel struct
typedef struct {bit [7:0] r, g, b;} pixel_s;
pixel_s my_pixel;

// Example 2-29 Using typedef to create a union
typedef union { int i; real f; } num_u;
num_u un;
un.f = 0.0; // set n in floating point format

// Example 2-30 Packed structure
typedef struct packed {bit [7:0] r, g, b;} pixel_p_s;
pixel_p_s my_pixel;

// Example 2-32 Enumerated types
// Create data type for values 0, 1, 2
typedef enum {INIT, DECODE, IDLE} fsmstate_e;
fsmstate_e pstate, nstate; // declare typed variables
initial begin
	case (pstate)
		IDLE: nstate = INIT; // data assignment
		INIT: nstate = DECODE;
		default: nstate = IDLE;
	endcase
	$display("Next state is %0s",nstate.name); // Use name function
end

// Example 2-34 Incorrectly specifying enumerated values
typedef enum {FIRST=1, SECOND, THIRD} ordinal_e;
ordinal_e position;

// Example 2-35 Correctly specifying enumerated values
typedef enum {ERR_O=0, FIRST=1, SECOND, THIRD} ordinal_e;
ordinal_e position;

// Example 2-36 Stepping through all enumerated members
enum {RED, BLUE, GREEN} color;
color = color.first;
do
	begin
		$display("Color = %0d/%0s", color, color.name);
		color = color.next;
	end
while (color != color.first); // Done at wrap-around

// Example 2-37 Assignments between integers and enumerated types
typedef enum {RED, BLUE, GREEN} COLOR_E;
COLOR_E color, c2;
integer c;
initial begin
	c = color; // Convert from enum to integer
	c++; // Increment integer
	if (!$cast(color, c)) // Cast integer back to enum
		$display("Cast failed for c=%0d", c);
	$display("Color is %0d / %0s", color, color.name);
	c2 = COLOR_E’(c); // No type checking done
end

// Example 2-39 String methods
string s;
initial begin
	s = "SystemVerilog";
	$display(s.getc(0)); // Display: 83 (‘S’)
	$display(s.toupper()); // Display: SYSTEMVERILOG
	s = {s, "3.1b"}; // "SystemVerilog3.1b"
	s.putc(s.len()-1, "a"); // change b-> a
	$display(s.substr(2, 5)); // Display: stem
	// Create temporary string, note format
	my_log($psprintf("%s %5d", s, 42));
end
task my_log(string message);
// Print a message to a log
	$display("@%0d: %s", $time, message);
endtask

// Example 2-40 Expression width depends on context
bit [7:0] b8;
bit one = 1’b1; // Single bit
$displayb(one + one); // A: 1+1 = 0
b8 = one + one; // B: 1+1 = 2
$displayb(b8);
$displayb(one + one + 2’b0); // C: 1+1 = 2 with constant
$displayb(2’(one) + one); // D: 1+1 = 2 with cast