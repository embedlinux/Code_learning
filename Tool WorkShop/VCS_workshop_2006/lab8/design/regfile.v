//******************************************************************************
// regfile.v
//
// Register File
//
// The register file is a three ported memory device with 31 
// read/write locations, each 32 bits wide.  A read-only cell 
// (register r0) provides a 32-bit zero.
//******************************************************************************

module	rf(writeCLK, Wrt_en, RSaddr, RTaddr, RDaddr, RS, RT, RD);

input		writeCLK;	// Write clock
input		Wrt_en;	      	// Write enable into the register file
input	[4:0]	RSaddr;		// Read address for source read port
input	[4:0]	RTaddr;		// Read address for target read port
input	[4:0]	RDaddr;		// Store address for destination write port
output	[31:0]	RS;		// Source read port
output	[31:0]	RT;		// Target read port
input	[31:0]	RD;		// Destination write port

reg	[31:0]	RAM [0:31];	// A 32 x 32 bit memory array
reg	[31:0]	RS, RT;		// Declare read ports as registers

initial
begin
    RAM[0] = 32'b0;		// Initialize register r0 with zeros
    RAM[29] = (`MEM_SIZE-8)*4;	// Initialize sp to end of memory
end

always @(posedge writeCLK)
begin
    // Write the register during the first half of WB so that result 
    // can be read during the same cycle.
    if (RDaddr != 0 && Wrt_en)	// Register r0 is read-only
    RAM[RDaddr] = RD;		// Write RD data to cell addressed by RDaddr
end

always @(RAM[RSaddr])
begin
    RS = RAM[RSaddr];		// Fetch RS data using RSaddr
end

always @(RAM[RTaddr])
begin
    RT = RAM[RTaddr];		// Fetch RT data using RTaddr
end

endmodule	// rf -- Register File

