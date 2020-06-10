//******************************************************************************
// cpu.v
//
// The Central Processing Unit
//
// Updates the program counter and maintains the PC and IR 
// Instantiates the register file, alu, quick compare,
// and all other control blocks.
//******************************************************************************

module	cpu
(
	CLK, writeCLK,				// Clock signal
	Daddr, Dread, Dwrite, Dout, 
	Din, Iaddr, Iread, Iin,		// Memory interface
	MRST				// Master reset
);

input		CLK;		// Clock 
input		writeCLK;	// Write Clock 
output	[31:0]	Daddr;		// Address for data access
output		Dread;		// Data read
output		Dwrite;		// Data write enable
output	[31:0]	Dout;		// Write path to data cache
input	[31:0]	Din;		// Read path to data cache
output	[31:0]	Iaddr;
wire	[31:0]	Iaddr;		// Address for instruction access
output		Iread;		// Instruction read control
input	[31:0]	Iin;		// Instruction input
input		MRST;		// Master reset

//******************************************************************************
// Global Signals
//******************************************************************************

wire	[31:0]	RSbus; 			// S source bus from register file
reg	[31:0]	RS_ALU;			// Latched ALU input operand
wire	[4:0]	RSaddr;			// S source address
wire	[31:0]	RTbus;			// T source bus from register file
reg	[31:0]	RT_ALU;			// Latched ALU input operand
wire	[4:0]	RTaddr;			// T source address
wire	[31:0]	RDbus;			// Destination bus
wire	[4:0]	RDaddr;			// Destination reg address
wire	[4:0]	RDaddr_wire;
reg	[4:0]	RDaddr_reg;
wire	[31:0]	ImmBus;			// Immediate bus
reg	[31:0]	PC, PCinc;		// PC 
reg	[31:0]	IR; 			// IR 
reg		Wrt_en; 		// Write enable to regfile	
reg	[31:0]	PCmux;			// Output of PCmux
wire	[31:0]	Iadd;			// Instruction address
reg	[31:0]	WBreg;			// write back register
wire		UseImm;			// Use Immediate Operand
wire 	[7:0]	ALUsel;			// Operation Select
reg     [2:0]   state_temp;     // Control state variable: Present.
reg     [2:0]   Control_state_pres;     // Control state variable: Present.
reg     [2:0]   Control_state_next;     // Control state variable: Next.
wire	[5:0]	QCsel;			// Select comparison operation
wire 		QCresult;		// Quick Compare result for branches
wire	[31:0]	PCvector;		// Exception/reset vector
wire 	[31:0]	PCoffset;		// Offset value for branches
wire	[25:0]	PCjump;			// Destination address for jumps
wire	[4:0]	PCsel;			// selection input to PCmux
wire	[31:0]	ALUout;			// Output of ALU
reg		Dread_reg;		// Data read
reg		Dwrite_reg;		// Data write enable
wire	[2:0]	WBsel;			// Data select for destination
reg	[31:0]	MAR;			// Memory address register
reg	[31:0]	SMDR;			// Store memory data register
wire	[31:0]	LMDR;			// Load memory data register
wire	[31:0]	PCbr;			// calculated PC for branch
wire	[31:0]	PCjmp;			// calculated PC for jump

//******************************************************************************
// Master Control: control machine state 
//******************************************************************************

`define FETCH           3'b000
`define DECODE          3'b001
`define EXECUTE         3'b010
`define MEMORY          3'b011
`define WRITE_BACK      3'b100

// Reset the future state of the machine.
//initial
//  Control_state_next = `FETCH;

// Propagate the state...
//propagate #(3) state_ff (Control_state_next, 1'b0, 1'b0, Control_state_pres);


// This is a large flip flop that implements all of the
// datapath registers.  (subtle hint.. In PA2, you might wish to replace this
// with a discrete flip flop chain in order to pipeline it.)

always @(posedge CLK)
begin
        casex (Control_state_next)              // set up latches for next cycle
           `FETCH: begin
                        PC = PCmux;		// implicit state
                end
           `DECODE: begin
                        IR = Iin;		// implicit state
                end
           `EXECUTE: begin
                        RS_ALU = RSbus;		// implicit state
                        RT_ALU = RTbus;		// implicit state
                end
           `MEMORY: begin
                        MAR = ALUout;		// implicit state
                        SMDR = RTbus;		// implicit state
                end
           `WRITE_BACK: begin
                end
            default: begin
                end
        endcase
end

//*****************************************************************************
// Generate control signals from machine state
//*****************************************************************************

// Control logic for generating the write enable signal
// for writing to a register 

always @(Control_state_pres)
begin
        casex (Control_state_pres)              // Set signals for current state
           `WRITE_BACK: begin
                        Wrt_en = `logic_one;		// implicit state
                end
            default: begin
                        Wrt_en = `logic_zero;
                end
        endcase
end

// Combinational control logic for generating the write enable signal
// for writing to the memory. 

always @(Control_state_pres or IR)
begin
        casex (Control_state_pres)              // Set signals for current state
           `MEMORY: begin
                        if (IR[`op] == `LW)
                             Dread_reg = `logic_one;
			else
                             Dread_reg = `logic_zero;

                        if (IR[`op] == `SW)
                             Dwrite_reg = `logic_one;
			else
                             Dwrite_reg = `logic_zero;

                end
            default: begin
                        Dread_reg = `logic_zero;
                        Dwrite_reg = `logic_zero;
                end
        endcase
end

// Combinational logic to generate next control state

always @(negedge CLK or MRST)
begin
        if (MRST)
        begin
                Control_state_pres = #10 `FETCH;
        end
        else
        begin
                Control_state_pres = #10 Control_state_next;
        end
end

always @(Control_state_pres)
begin
        casex (Control_state_pres)              // Set signals for current state
           `FETCH: begin
                        Control_state_next = `DECODE;
                end
           `DECODE: begin
                        Control_state_next = `EXECUTE;
                end
           `EXECUTE: begin
                        Control_state_next = `MEMORY;
                end
           `MEMORY: begin
                        Control_state_next = `WRITE_BACK;
                end
           `WRITE_BACK: begin
                        Control_state_next = `FETCH;
                end
            default: begin
                        Control_state_next = `FETCH;
                end
        endcase
end



//*****************************************************************************
// Calculate the next PC
//*****************************************************************************

assign Iaddr = PC;
assign PCbr = PC + PCoffset + 4;
assign PCjmp = {PC[31:28],PCjump,2'b0};

always @(PC)
begin
	PCinc = PC + 4;
end

always @(PCsel or PCbr or PCjmp or PCvector or 
	RSbus or PCinc)
begin
	case(PCsel)				// select the new PC
	   `select_pc_add: 	PCmux = PCbr;
	   `select_pc_jump: 	PCmux = PCjmp;
	   `select_pc_vector: 	PCmux = PCvector;
	   `select_pc_register:	PCmux = RSbus;
	   default: 		PCmux = PCinc;
	endcase
end

//******************************************************************************
// Decode and control logic module
//******************************************************************************

decoder Decoder		// Decoder and immediate control logic
(IR, RSaddr, RTaddr, RDaddr_wire, ImmBus, QCresult, MRST, QCsel, PCsel, 
	PCvector, PCoffset, PCjump);

always @(RDaddr_wire)
begin
	RDaddr_reg = RDaddr_wire;
end

//******************************************************************************
// Register file module 
//******************************************************************************

rf regfile		// Register File
(writeCLK, Wrt_en, RSaddr, RTaddr, RDaddr, RSbus, RTbus, RDbus);


//******************************************************************************
// ALU and ALU control modules
//******************************************************************************

alu_control ALUcontr		// ALU control
(IR, ALUsel, UseImm);

alu ALU				// Arithmetic / logic / shift unit
(RS_ALU, RT_ALU, ImmBus, UseImm, ALUsel, ALUout);

//******************************************************************************
// Quick compare logic module (for branches)
//******************************************************************************

quick_compare QC		
(RSbus, RTbus, QCsel, QCresult);

//******************************************************************************
// Access Data Memory
//******************************************************************************

assign LMDR = Din;		// Drive LMDR directly from data in

assign Daddr  = MAR;		// Data memory address
assign Dout   = SMDR;		// Data memory data out
assign Dread = Dread_reg;
assign Dwrite = Dwrite_reg;

//******************************************************************************
// Write data back to register file and write back control module
//******************************************************************************

wb_control WBcontr		// Register write back control
(IR, WBsel);

assign RDbus = WBreg;		// Drive RDbus with contents of WBreg
assign RDaddr = RDaddr_reg;	// Drive RDaddr with destination reg address

always @(WBsel or LMDR or PCinc or ALUout)
begin				// Select write back value
	case (WBsel)
		`select_wb_load : WBreg = LMDR;
		`select_wb_link : WBreg = PCinc;
		default : WBreg = ALUout;
	endcase
end

endmodule	// cpu -- Central Processing Unit

