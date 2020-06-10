// ************************************************************************
// *  NOVAS SOFTWARE CONFIDENTIAL PROPRIETARY NOTE                        *
// *                                                                      *
// *  This software contains information confidential and proprietary     *
// *  to Novas Software Inc. It shall not be reproduced in whole          *
// *  or in part or transferred to other documents, or disclosed          *
// *  to third parties, or used for any purpose other than that           *
// *  for which it was obtained, without the prior written consent        *
// *  of Novas Software Inc.                                              *
// *  (c) 1996, 1997, 1998 Novas Software Inc.                            *
// *  All rights reserved                                                 *
// *                                                                      *
// ************************************************************************

/* Verdi tutorial case: A simplified microprogramming-based CPU
   File name: CCU.v
   Descriptions:This module containing the main controller of CPU.

		MA: microcode address 
		CWR: control word address 
		mprom: a ROM which contains the microcode 
		maprom: a ROM which contains the starting address of individual
			microprograms 

*/

`timescale 1 ns / 1 ns

module CCU( RESET, CLOCK1, CLOCK2, CLOCK3, CLOCK4, IR, CF, ZF, 
		OpBusMode, CarryMode, AluMode, ResultBusMode, 
		IR_load, PC_load, ACC_load, IXR_load, TR_load, Flag_load, IDR_load,
		R_Wmode, VMAmode, WAIT );

input RESET;
input CLOCK1;
input CLOCK2;
input CLOCK3;
input CLOCK4;
input [7:0] IR;
input CF, ZF;

output [2:0] OpBusMode;
output CarryMode;
output [2:0] AluMode;
output [2:0] ResultBusMode;
output IR_load, PC_load, ACC_load, IXR_load, TR_load, Flag_load, IDR_load;
output R_Wmode, VMAmode;
input WAIT;

wire [5:0] opCode; 
wire JFselect, Jnegation;
wire [7:0] newMA; 
reg [7:0] MA, next_MA; 
wire [1:0] MAselect; 
wire [21:0] mprom_out;
reg [21:0] CWR;
wire Jflag;

assign opCode = IR[7:2];
assign Jnegation = IR[1];
assign JFselect = IR[0];

// mapping rom
 maprom i_maprom (.addr(opCode)
	, .dout(newMA)
	, .addr_error());

always @(MAselect or newMA or MA)
	case (MAselect)
		0: next_MA = 8'h00;
		1: next_MA = newMA;
		2: next_MA = MA;
	  default: next_MA = MA+1;
	endcase

always @(posedge CLOCK1 or negedge RESET)
begin
	if (!RESET)
		MA = 0;
	else 
		MA = #1 next_MA;
end

// microprogram rom
 mprom i_mprom (.addr(MA)
	, .dout(mprom_out)
	, .addr_error());

// control word register
always @(posedge CLOCK2 or negedge RESET)
begin
	if (!RESET)
		CWR = 0;
	else 
		CWR = #1 mprom_out;
end

assign MAselect = (CWR[21:20]==2'b10 && WAIT)?2'b00:CWR[21:20];
assign IR_load = ~CWR[19];
assign CarryMode = CWR[18];
assign OpBusMode = CWR[17:15];
assign AluMode = CWR[14:12];
assign ACC_load = ~CWR[11];
assign IXR_load = ~CWR[10];
assign Flag_load = ~CWR[9];

assign Jflag = (JFselect == 0) ? ZF : CF;
//assign Jflag = (JFselect == 0) ? ZF : SF;

//  PC_load: 	Enable signal of PC (program counter)
//		PC will be updated if and only if PC_load = 1.  		
//	1. PC needs to be increased by 1 at the same time when an instruction is loaded.  	
//	2. PC needs to be increased by 1 for instructions which need an operand. For   
//	   "Load-type" instructions (LDA, LDA_, ADDA, ADDA_, SUBA_, LDX), this will happen 
//	   2 clock cycles after the instruction is loaded. For "Store-type" instructions 
//	   (STA, STA_), this will happen 4 clock cycles after the instruction is loaded. 	
//	   e.g. ADDA #55  (PC needs to be increased by 1 after 55 is loaded)
//	3. PC needs to be updated with a new address for an branching instruction
//	   if the branching condition holds. The update should occur 2 clock cycles
//	   after the instruction is loaded.
//	   (JMP, BNZ)
//	   e.g. BNZ #30  (If zero flag is not equal to 0, PC should be updated with 30.)


// CWR[8] : 0-> Non-Conditional Jump
//        : 1-> Conditional Jump
// CWR[7] : 1-> disable loading PC

// Correct statement
assign PC_load = ~( CWR[7] | ( CWR[8] & (Jnegation ^ Jflag) ) );
//assign PC_load = ~( CWR[7] );

// Buggy statement
//assign PC_load = ~( CWR[7] | ( CWR[8] | (Jnegation ^ Jflag) ) );

assign TR_load = ~CWR[6];
assign IDR_load = ~CWR[5];

assign ResultBusMode = CWR[4:2];
assign R_Wmode = CWR[1];
assign VMAmode = CWR[0];

endmodule
