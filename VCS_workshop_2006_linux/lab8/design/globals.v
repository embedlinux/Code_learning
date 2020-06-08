//*****************************************************************************
// globals.v
//
// This file contains all text macro definitions that are 
// globally accessable to the MIPS-Lite model.
// 
// To enhance readability, MIPS-Lite model descriptions will use the 
// mnemonics defined here in place of actual binary codes.
//*****************************************************************************

//*****************************************************************************
// Clock parameters 
//*****************************************************************************
`define	cycle		10	// 4 ns clock cycle time
`define	delay		1	// Small delay for edge triggered flip-flops
`define FF_clk		TOP.CLK

//*****************************************************************************
// Control States
//*****************************************************************************
//`define FETCH		3'b000
//`define DECODE		3'b001
//`define EXECUTE		3'b010
//`define MEMORY		3'b011
//`define WRITE_BACK	3'b100

//*****************************************************************************
// Instruction Fields
//*****************************************************************************
`define	op		31:26	// 6-bit operation code
`define	rs		25:21	// 5-bit source register specifier
`define	rt		20:16	// 5-bit source/dest register specifier 
				//    or sub-operation code
`define	immediate	15:0	// 16-bit immediate, branch or address disp
`define	target		25:0	// 26-bit jump target address
`define	rd		15:11	// 5-bit destination register specifier
`define	sa		10:6	// 5-bit shift amount
`define	function	5:0	// 6-bit function field
`define	sub		20:16	// 5-bit sub-operation code
`define	coprocessor	20:0	// 21-bit coprocessor-specific field

//*****************************************************************************
// Register name switch for disassembler
//*****************************************************************************
`define	hardware_names		0	// Hardware register names
`define	compiler_names		1	// Compiler register names
`define	default_register_names	`hardware_names  // Default register names

//*****************************************************************************
// Symbolic Register Names for Hardware
//*****************************************************************************

// Hardware register names
`define	r0	5'b00000
`define	r1	5'b00001
`define	r2	5'b00010
`define	r3	5'b00011
`define	r4	5'b00100
`define	r5	5'b00101
`define	r6	5'b00110
`define	r7	5'b00111
`define	r8	5'b01000
`define	r9	5'b01001
`define	r10	5'b01010
`define	r11	5'b01011
`define	r12	5'b01100
`define	r13	5'b01101
`define	r14	5'b01110
`define	r15	5'b01111
`define	r16	5'b10000
`define	r17	5'b10001
`define	r18	5'b10010
`define	r19	5'b10011
`define	r20	5'b10100
`define	r21	5'b10101
`define	r22	5'b10110
`define	r23	5'b10111
`define	r24	5'b11000
`define	r25	5'b11001
`define	r26	5'b11010
`define	r27	5'b11011
`define	r28	5'b11100
`define	r29	5'b11101
`define	r30	5'b11110
`define	r31	5'b11111

// Symbolic Register Names for Assembler and Compiler
`define	zero	5'b00000	// Read only zero value
`define	at	5'b00001	// Assembler temporary
`define	v0	5'b00010	// Integer function value
`define	v1	5'b00011
`define	a0	5'b00100	// Parameters
`define	a1	5'b00101
`define	a2	5'b00110
`define	a3	5'b00111
`define	t0	5'b01000	// General use, not preserved by subroutines
`define	t1	5'b01001
`define	t2	5'b01010
`define	t3	5'b01011
`define	t4	5'b01100
`define	t5	5'b01101
`define	t6	5'b01110
`define	t7	5'b01111
`define	s0	5'b10000	// General use, preserved by subroutines
`define	s1	5'b10001
`define	s2	5'b10010
`define	s3	5'b10011
`define	s4	5'b10100
`define	s5	5'b10101
`define	s6	5'b10110
`define	s7	5'b10111
`define	t8	5'b11000	// General use, not preserved by subroutines
`define	t9	5'b11001
`define	k0	5'b11010	// Kernel
`define	k1	5'b11011
`define	gp	5'b11100	// Global pointer
`define	sp	5'b11101	// Stack pointer
`define	s8	5'b11110	// General use, preserved by subroutines
`define	ra	5'b11111	// Link register

//******************************************************************************
// Opcode Assignments for `op Operations
//******************************************************************************
`define	SPECIAL		6'b000000
`define	REGIMM		6'b000001
`define	J		6'b000010
`define	JAL		6'b000011
`define	BEQ		6'b000100
`define	BNE		6'b000101
`define	BLEZ		6'b000110
`define	BGTZ		6'b000111
//------------------------------------------------
`define	ADDI		6'b001000
`define	ADDIU		6'b001001
`define	SLTI		6'b001010
`define	SLTIU		6'b001011
`define	ANDI		6'b001100
`define	ORI		6'b001101
`define	XORI		6'b001110
`define	LUI		6'b001111
//-------------------------------------------------
`define	LW		6'b100011
//-------------------------------------------------
`define	SW		6'b101011
//-------------------------------------------------

//******************************************************************************
// Opcode Assignments for `SPECIAL function Operations
//******************************************************************************
`define	SLL		6'b000000
`define	SRL		6'b000010
`define	SRA		6'b000011
`define	SLLV		6'b000100
`define	SRLV		6'b000110
`define	SRAV		6'b000111
//-------------------------------------------------
`define	JR		6'b001000
`define	JALR		6'b001001
//-------------------------------------------------
`define	ADD		6'b100000
`define	ADDU		6'b100001
`define	SUB		6'b100010
`define	SUBU		6'b100011
`define	AND		6'b100100
`define	OR		6'b100101
`define	XOR		6'b100110
`define	NOR		6'b100111
//-------------------------------------------------
`define	SLT		6'b101010
`define	SLTU		6'b101011
//-------------------------------------------------

//******************************************************************************
// Opcode Assignments for `REGIMM rt Operations
//******************************************************************************
`define	BLTZ		5'b00000
`define	BGEZ		5'b00001
//-------------------------------------------------


//******************************************************************************
// Short macros for long hierarchical names
//******************************************************************************
`define	TOP	TOP
`define CLKGEN	`TOP.CLKGEN
`define CPU	`TOP.CPU
`define RF	`CPU.RF
`define ALU	`CPU.ALU


//******************************************************************************
// Encoded data path controls
//******************************************************************************

// Next program counter value select
`define	select_pc_inc		5'b11110
`define	select_pc_add		5'b11101
`define	select_pc_jump		5'b11011
`define	select_pc_vector	5'b10111
`define	select_pc_register	5'b01111

// Operand select controls for stage II in data path
`define	select_stage3_bypass	4'b1110
`define	select_stage4_bypass	4'b1101
`define	select_reg_file_path	4'b1011
`define	select_immediate_path	4'b0111

// Operand select controls for stage II in data path
`define	select_stage3_bypass3	3'b110
`define	select_stage4_bypass3	3'b101
`define	select_reg_file_path3	3'b011

// Decoded ALU operation select (ALUsel) signals
`define	select_alu_add		8'b00000001
`define	select_alu_and		8'b00000010
`define	select_alu_xor		8'b00000100
`define	select_alu_or		8'b00001000
`define	select_alu_nor		8'b00010000
`define	select_alu_sub		8'b00100001
`define	select_alu_sltu		8'b01010000
`define	select_alu_slt		8'b01100000
`define	select_alu_shift	8'b10000000
`define	select_alu_srl		8'b10000001
`define	select_alu_sra		8'b10000010
`define	select_alu_sll		8'b10000100

// Decoded quick compare condition select (QCsel) signals
`define	select_qc_ne		6'b000001
`define	select_qc_eq		6'b000010
`define	select_qc_lez		6'b000100
`define	select_qc_gtz		6'b001000
`define	select_qc_gez		6'b010000
`define	select_qc_ltz		6'b100000

// Select data to be written back to register file
`define	select_wb_alu		3'b110
`define	select_wb_load		3'b101
`define select_wb_link		3'b011


//******************************************************************************
// Miscellaneous
//******************************************************************************

// Size of memory structure in words (word == 32 bits)
`define MEM_SIZE	32'h4000
`define RESET_VECTOR	32'hffe4

// Various width don't care and invalid values
`define	dc32		32'bxxxxxxxx
`define	invalid		32'bxxxxxxxx
`define	undefined	32'bxxxxxxxx
`define	dc8		8'bxxxxxxxx
`define	dc6		6'bxxxxxx
`define	dc5		5'bxxxxx
`define	dc3		3'bxxx
`define	dc2		2'bxx
`define	dc		1'bx
`define	null		1'bx

`define	byte		7:0	// Byte size
`define	half		15:0	// Half-word size
`define	triple		23:0	// Triple-byte size
`define	word		31:0	// Word size

`define	byte0		7:0	// Part selects for bytes in a word
`define	byte1		15:8
`define	byte2		23:16
`define	byte3		31:24

`define	half0		15:0	// Part selects for half-words in a word
`define	half1		31:16

`define	word0		31:0	// Part selects for words in a 128 bit mega word
`define	word1		63:32
`define	word2		95:64
`define	word3		127:96

`define	byte_size	8	// Number of bits in a byte
`define	word_size	32	// Number of bits in a word
`define	string_length	18	// Standard string length
`define	logic_zero	1'b0	// Logical zero value
`define	logic_one	1'b1
`define	true		1'b1	// Another way to say the same thing
`define	false		1'b0
`define	left		1'b0	// Shift or alignment direction
`define	right		1'b1

// Constants for fanning out single bit signals
// Example - (`fanout8 * signal) fans signal out by 8
`define	fanout32	32'hffffffff
`define	fanout16	16'hffff
`define	fanout14	14'h3fff
`define	fanout8		8'hff
`define	fanout4		4'hf

// A bunch of useful interactive verilog commands
`define sv		$showvars;
`define sc		$showscopes;
`define	scpu		$scope(`CPU);
`define d		$displayh(
`define go		`por `ss `entry .
`define gor		`cpuregs `por `ss `entry .
`define	sss		`ss `ss `ss `ss

// end globals -- global text macro definitions

