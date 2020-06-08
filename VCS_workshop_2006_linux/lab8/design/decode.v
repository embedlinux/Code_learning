//******************************************************************************
// decode.v
//
// Decoder control and immediate datapath
//
// Get the source and target register numbers from `rs and `rt fields of the
// instruction.  Compute the value for 32 bit 
// immediate data.  Compute the quick compare select controls.  Compute whether
// a branch should be taken.  Initialize the reset vector.  Compute the program
// counter select controls.  Compute the target for jump instructions.  AND ...
// Compute the offset for branch instructions.
//******************************************************************************

module decoder (IR, RSaddr, RTaddr, RDaddr, Imm, QC, MRST, QCsel,
        PCsel, PCvector, PCoffset, PCjump);

input	[31:0]	IR;	 	// Instruction Register
output	[4:0]	RSaddr;		
reg	[4:0]	RSaddr;		// Source register address specifier
output	[4:0]	RTaddr;		
reg	[4:0]	RTaddr;		// Target register address specifier
output	[4:0]	RDaddr;		
reg	[4:0]	RDaddr;		// Destination register address specifier
output	[31:0]	Imm;	
reg	[31:0]	Imm;		// Immediate data

input		QC;		// Quick Compare result for branches
input		MRST;		// Power-On reset signal
output	[5:0]	QCsel;		
reg	[5:0]	QCsel;		// Select control for quick compare

output	[4:0]	PCsel;		
reg	[4:0]	PCsel;		// Select control for program counter
output	[31:0]	PCvector;	
reg	[31:0]	PCvector;	// Exception / reset vectors
output	[31:0]	PCoffset;
reg	[31:0]	PCoffset;	// Offset value for branches
output	[25:0]	PCjump;		
reg	[25:0]	PCjump;		// Destination address for jumps
reg     [12*12:1] instr_type;
reg     [1:0] type;

//******************************************************************************
// Take source register number from `rs field and target register number 
// from `rt field.
//******************************************************************************

always @(IR)
  begin
    RSaddr = IR[`rs];
    RTaddr = IR[`rt];
  end

//*****************************************************************************
// Compute destination register number
//*****************************************************************************

always @(IR)            // Compute destination register number
begin
   casex ({IR[`op], IR[`function]})
        // Load result goes to `rt register
        {`LW,    `dc6   }: begin RDaddr = IR[`rt]; instr_type = "LOAD/STORE"; end

        // Immediate operation results go to `rt
        {`ADDI,  `dc6   }: begin RDaddr = IR[`rt]; instr_type = "ADD"; end
        {`ADDIU, `dc6   }: begin RDaddr = IR[`rt]; instr_type = "ADD"; end
        {`SLTI,  `dc6   }: begin RDaddr = IR[`rt]; instr_type = "SHIFT"; end
        {`SLTIU, `dc6   }: begin RDaddr = IR[`rt]; instr_type = "SHIFT"; end
        {`ANDI,  `dc6   }: begin RDaddr = IR[`rt]; instr_type = "AND"; end
        {`ORI,   `dc6   }: begin RDaddr = IR[`rt]; instr_type = "OR"; end
        {`XORI,  `dc6   }: begin RDaddr = IR[`rt]; instr_type = "EXCLUSIVE OR"; end
        {`LUI,   `dc6   }: begin RDaddr = IR[`rt]; instr_type = "LOAD BYTE"; end

        // ALU operation results go to `rd register
        {`SPECIAL, `ADD }: begin RDaddr = IR[`rd]; instr_type = "ADD"; end
        {`SPECIAL, `ADDU}: begin RDaddr = IR[`rd]; instr_type = "ADD"; end
        {`SPECIAL, `SUB }: begin RDaddr = IR[`rd]; instr_type = "SUB"; end
        {`SPECIAL, `SUBU}: begin RDaddr = IR[`rd]; instr_type = "SUB"; end
        {`SPECIAL, `SLT }: begin RDaddr = IR[`rd]; instr_type = "SHIFT"; end
        {`SPECIAL, `SLTU}: begin RDaddr = IR[`rd]; instr_type = "SHIFT"; end
        {`SPECIAL, `AND }: begin RDaddr = IR[`rd]; instr_type = "AND"; end
        {`SPECIAL, `OR  }: begin RDaddr = IR[`rd]; instr_type = "OR"; end
        {`SPECIAL, `XOR }: begin RDaddr = IR[`rd]; instr_type = "EXCLUSIVE OR"; end
        {`SPECIAL, `NOR }: begin RDaddr = IR[`rd]; instr_type = "NOR"; end

        // Note, other shift decode to be added...
        // Shift operations go to `rd register
        {`SPECIAL, `SLL  }: begin RDaddr = IR[`rd]; instr_type = "SHIFT"; end
        {`SPECIAL, `SLLV }: begin RDaddr = IR[`rd]; instr_type = "SHIFT"; end
        {`SPECIAL, `SRA  }: begin RDaddr = IR[`rd]; instr_type = "SHIFT"; end
        {`SPECIAL, `SRAV }: begin RDaddr = IR[`rd]; instr_type = "SHIFT"; end
        {`SPECIAL, `SRL  }: begin RDaddr = IR[`rd]; instr_type = "SHIFT"; end
        {`SPECIAL, `SRLV }: begin RDaddr = IR[`rd]; instr_type = "SHIFT"; end

        // Link register is R31
        {`JAL,   `dc6   }: begin RDaddr = `r31; instr_type = "JUMP"; end

        // Link register is `rd
        {`SPECIAL, `JALR        }: begin RDaddr = IR[`rd]; instr_type = "JUMP"; end 

        // All other instruction results go to `r0
        default          : RDaddr = `r0;
   endcase
end


//******************************************************************************
// Compute value for 32 bit immediate data
//******************************************************************************

always @(IR)			
begin
   casex(IR[`op])
	// Sign extend for memory access operations
        `LW	: Imm = {{16{IR[15]}}, IR[`immediate]};			
        `SW	: Imm = {{16{IR[15]}}, IR[`immediate]};

	// ALU Operations that sign extend immediate
        `ADDI	: Imm = {{16{IR[15]}}, IR[`immediate]};			
        `ADDIU	: Imm = {{16{IR[15]}}, IR[`immediate]};
        `SLTI	: Imm = {{16{IR[15]}}, IR[`immediate]};
        `SLTIU	: Imm = {{16{IR[15]}}, IR[`immediate]};

	// ALU Operations that zero extend immediate
        `ANDI	: Imm = {16'b0, IR[`immediate]};				
        `ORI	: Imm = {16'b0, IR[`immediate]};
        `XORI	: Imm = {16'b0, IR[`immediate]};

	// LUI fills low order bits with zeros
        `LUI	: Imm = {IR[`immediate], 16'b0};				
        default	: Imm = {27'b0, IR[`sa]}; 
   endcase
end

//******************************************************************************
// Compute quick compare select controls
//******************************************************************************

always @(IR)    
begin
   casex({IR[`op], IR[`rt]})

      {`BEQ,    `dc5    }: begin QCsel = `select_qc_eq; instr_type = "BRANCH";  end
      {`BNE,    `dc5    }: begin QCsel = `select_qc_ne; instr_type = "BRANCH";  end
      {`BLEZ,   `dc5    }: begin QCsel = `select_qc_lez; instr_type = "BRANCH"; end
      {`BGTZ,   `dc5    }: begin QCsel = `select_qc_gtz; instr_type = "BRANCH"; end
      {`REGIMM, `BLTZ   }: begin QCsel = `select_qc_ltz; instr_type = "BRANCH"; end
      {`REGIMM, `BGEZ   }: begin QCsel = `select_qc_gez; instr_type = "BRANCH"; end
      default:             QCsel = `dc6;
   endcase
end

//******************************************************************************
// Compute whether a branch should be taken
//******************************************************************************

reg takeBranch;			
always @(IR or QC)
begin
	casex ({IR[`op], IR[`rt], QC})
		{`BEQ,    `dc5,  `true}: takeBranch = `true;
		{`BNE,    `dc5,  `true}: takeBranch = `true;
		{`BLEZ,   `dc5,  `true}: takeBranch = `true;
		{`BGTZ,   `dc5,  `true}: takeBranch = `true;
		{`REGIMM, `BLTZ, `true}: takeBranch = `true;
		{`REGIMM, `BGEZ, `true}: takeBranch = `true;
		default:		 takeBranch = `false;
	endcase
end

//******************************************************************************
// Reset vector
//******************************************************************************

initial
begin
	PCvector = `RESET_VECTOR;	
end

wire takeVector;
assign takeVector = MRST;	// Jump to reset vector if power-on reset

//******************************************************************************
// Compute program counter select controls
//******************************************************************************

always @(IR or takeBranch or takeVector)
begin
    if (takeVector) PCsel = `select_pc_vector;
    else begin
	casex ({IR[`op], IR[`rt], IR[`function], takeBranch})
		// Select jump address as target
		{`J,	   `dc5,  `dc6,	  `dc }: PCsel = `select_pc_jump;
		{`JAL,	   `dc5,  `dc6,   `dc }: PCsel = `select_pc_jump;

		// Select register value as target
		{`SPECIAL, `dc5,   `JR,   `dc }: PCsel = `select_pc_register;
		{`SPECIAL, `dc5, `JALR,	  `dc }: PCsel = `select_pc_register;

		// Select branch (PC + offset) as target
		{`BEQ,	   `dc5,  `dc6, `true }: PCsel = `select_pc_add;
		{`BNE,	   `dc5,  `dc6, `true }: PCsel = `select_pc_add;
		{`BLEZ,	   `dc5,  `dc6, `true }: PCsel = `select_pc_add;
		{`BGTZ,	   `dc5,  `dc6, `true }: PCsel = `select_pc_add;
		{`REGIMM, `BLTZ,  `dc6, `true }: PCsel = `select_pc_add;
		{`REGIMM, `BGEZ,  `dc6, `true }: PCsel = `select_pc_add;
		default: 			 PCsel = `select_pc_inc;
	endcase
    end
end

//******************************************************************************
// Compute target for jump instructions
//******************************************************************************

always @(IR)		
begin
	// Jump instructions use 26 bit `target field
	casex(IR[`op])
		`J	: PCjump = IR[`target];	
		`JAL	: PCjump = IR[`target];
		default	: PCjump = `dc32;
	endcase
end

//******************************************************************************
// Compute offset for branch instructions
//******************************************************************************

always @(IR)		
begin
	casex({IR[`op], IR[`rt]}) // Shift left twice and sign extend
		{`BEQ,   `dc5 }: PCoffset= {{14{IR[15]}}, IR[`immediate], 2'b0};
		{`BNE,	 `dc5 }: PCoffset= {{14{IR[15]}}, IR[`immediate], 2'b0};
		{`BLEZ,	 `dc5 }: PCoffset= {{14{IR[15]}}, IR[`immediate], 2'b0};
		{`BGTZ,	 `dc5 }: PCoffset= {{14{IR[15]}}, IR[`immediate], 2'b0};
		{`REGIMM,`BLTZ}: PCoffset= {{14{IR[15]}}, IR[`immediate], 2'b0};
		{`REGIMM,`BGEZ}: PCoffset= {{14{IR[15]}}, IR[`immediate], 2'b0};
		default:	 PCoffset= `dc32;
	endcase
end

endmodule	// decode 
