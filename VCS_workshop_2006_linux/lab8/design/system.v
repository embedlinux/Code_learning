//******************************************************************************
// system.v (highest level module)
// 
// Builds a complete system simulation.  Contains the memory 
// system, CPU and clock.
//******************************************************************************

module TOP;

reg	[31:0]	Din;			// Data bus to memory system
reg	[31:0]	Iin;			// Instruction bus to memory system
reg		MRST, CLK, writeCLK;	// Master reset and clocks
wire	[31:0]	Daddr;
wire		Dread;
wire		Dwrite;
wire	[31:0]	Dout;
wire	[31:0]	Iaddr;
wire		Iread;
reg	[31:0]	sramArray [0:16383];	// Memory array to mimic memory system
reg	[31:0]	cycle_counter;		// Processor cycle counter


//******************************************************************************
// Create a 50% duty cycle clock
//******************************************************************************
always
begin
	CLK = 0;
	# 10		// Delay 10 time units
       	CLK = 1;
        # 10
        CLK = 0;
end

//******************************************************************************
// The write clock should be time-delayed from the CLK
//******************************************************************************

always @(CLK)
	#1 writeCLK = CLK;


cpu CPU			// Instantiate CPU
(CLK, writeCLK, Daddr, Dread, Dwrite, Dout, Din, Iaddr, Iread, Iin, MRST);

//******************************************************************************
// Initialize memory system
//******************************************************************************
integer i;
always @(posedge MRST)
begin
	$display("Initializing Memory ...");
	$readmemh("text_segment", sramArray);
	$readmemh("data_segment", sramArray);
	sramArray[`MEM_SIZE-7] = 32'h00000000;
	sramArray[`MEM_SIZE-6] = 32'h0c00004c;	// <jal 0x130> to user code.
	sramArray[`MEM_SIZE-5] = 32'h00000000;	// Return from user code
	sramArray[`MEM_SIZE-4] = 32'h00000000;	//     and execute 5 nops
	sramArray[`MEM_SIZE-3] = 32'h00000000;	//     before halting.
	sramArray[`MEM_SIZE-2] = 32'h00000000;
	sramArray[`MEM_SIZE-1] = 32'h00000000;
end

initial
begin
	force MRST = 1;			// initialize the pipe with nops
	repeat(8)@(posedge `TOP.CLK);
	force MRST = 0;
end

//******************************************************************************
// Mimic memory system
//******************************************************************************
always @(Iaddr)				// Mimic instruction reads
begin
	Iin = sramArray[Iaddr[15:2]];
end

always @(Dread or Daddr)		// Mimic data reads
begin
	if (Dread) begin
	   Din = sramArray[Daddr[15:2]];
        end
end

always @(posedge writeCLK)	// Mimic data writes
begin
	if (Dwrite) begin
	   sramArray[Daddr[15:2]] = Dout;
	end
end

//******************************************************************************
// Program exit routine
//******************************************************************************

integer FP;
always @(Iaddr)				// Program exit
begin
	if (Iaddr == ((`MEM_SIZE-1)*4)) 	// exit address
	begin
    	    if ($test$plusargs("output")) 
	    begin	// dump memory
         //      $display("\nNumber of IMMEDIATE instructions = %d", testbench.imm_inst);
         //        $display("Number of BRANCH    instructions = %d", testbench.branch_inst);
         //        $display("Number of JUMP      instructions = %d", testbench.jump_inst);
         //        $display("Number of RESETS/EXCEPTIONS      = %d", testbench.resets);
         //        $display("Blocks to COVER                  = %f", testbench.coverage_limit);
         //        $display("Blocks COVERED                   = %f \n",testbench.coverage);
	       $display("\nCreating microprocessor design's memory image ...");
	 //      FP = $fopen("memory.core");
	 //      $fdisplay(FP," cycle counter = %d",cycle_counter);
	 //      $fdisplay(FP,"\n     MEMORY DUMP");
	 //      $fdisplay(FP," address      data");
	 //      $fdisplay(FP,"----------  ----------");
	 //      for (i=0; i<`MEM_SIZE; i=i+1)
	//		$fdisplay(FP,"0x%h  0x%h",i*4,sramArray[i]);
	       $display("cycle counter = %d",cycle_counter);
	       $display("\n     MEMORY DUMP");
	       $display(" address      data");
	       $display("----------  ----------");
	       for (i=0; i<`MEM_SIZE; i=i+1)
		  $display("0x%h  0x%h",i*4,sramArray[i]);
	    end
	    $display("Program Exit");
	    $finish;
	end
end

//******************************************************************************
// Cycle counter
//******************************************************************************

always @(posedge CLK) begin
   if (CPU.PC == 32'hffe4)
	cycle_counter = 0;
   else
   	cycle_counter = cycle_counter + 1;
end

endmodule	// system
