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
   File name: CPU.v
   Descriptions: The CPU consists of three sub-modules and several program
		registers. 

		Sub-Modules:
			PCU: the I/O interface
			CCU: a microprogramming-based main controller
			ALUB: the datapath

		Program registers:
			IR: instruction register
			PC: program counter
			ACC: accumulator
			IXR: index register
			TR: temporary register
			CF, ZF: carry flag, zero flag
			IDR: intermediate data register

		Clock scheme: 
			4-phase clocks: CLOCK1, CLOCK2, CLOCK3, CLOCK4
			CLOCK1: for microcode address register (MA), and I/O 
			CLOCK2: for control word address (CWR)
			CLOCK3: for program registers
			CLOCK4: for internal buffers 
*/

`timescale 1 ns / 1 ns

module CPU(CLOCK1, CLOCK2, CLOCK3, CLOCK4, RESET, VMA, R_W, BUSY, data, addr);
input CLOCK1;
input CLOCK2;
input CLOCK3;
input CLOCK4;
input RESET;
output VMA;
output R_W;
input BUSY;
inout [7:0] data;
output [7:0] addr;

wire [7:0] IntDataIn;

wire [2:0] OpBusMode;
wire CarryMode;
wire [2:0] AluMode;
wire [2:0] ResultBusMode;
wire [7:0] AluOut;
wire [7:0] AluBuf;
wire [7:0] DataOut;
wire CFout, ZFout;

wire IR_load, PC_load, ACC_load, IXR_load, TR_load, Flag_load, IDR_load;
wire R_Wmode;
wire VMAmode;
wire WAIT;

wire [7:0] IDR_d;

reg [7:0] IR;
reg [7:0] PC;
reg [7:0] ACC;
reg [7:0] IXR;
reg [7:0] TR;
reg CF, ZF;
reg [7:0] IDR;

// Program Control Unit block
 PCU i_PCU (
	.RESET(RESET),
	.CLOCK1(CLOCK1), 
	.CLOCK2(CLOCK2),
	.CLOCK3(CLOCK3),
	.CLOCK4(CLOCK4),
	.R_Wmode(R_Wmode),
	.VMAmode(VMAmode),
	.WAIT(WAIT),
	.IntAddr(DataOut),
	.IntDataIn(IntDataIn),
	.IntDataOut(IDR),
	.R_W(R_W),
	.VMA(VMA), 
	.BUSY(BUSY), 
	.ExtAddr(addr), 
	.ExtData(data)
	);


// Arithmatic and Logic Unit block
 ALUB i_ALUB (
	.RESET(RESET),
	.CLOCK1(CLOCK1),
	.CLOCK2(CLOCK2),
	.CLOCK3(CLOCK3),
	.CLOCK4(CLOCK4),
	.OpBusMode(OpBusMode),
	.CarryMode(CarryMode),
	.AluMode(AluMode),
	.ResultBusMode(ResultBusMode),
	.DataIn(IDR),
	.PC(PC),
	.ACC(ACC),
	.IXR(IXR),
	.TR(TR),
	.AluOut(AluOut),
	.AluBuf(AluBuf),
	.DataOut(DataOut),
	.CFout(CFout),
	.ZFout(ZFout)
	);

// Computer Control Unit block
 CCU i_CCU (
	.RESET(RESET),
	.CLOCK1(CLOCK1),
	.CLOCK2(CLOCK2),
	.CLOCK3(CLOCK3),
	.CLOCK4(CLOCK4),
	.IR(IR),
	.CF(CF),
	.ZF(ZF),
	.OpBusMode(OpBusMode),
	.CarryMode(CarryMode),
	.AluMode(AluMode),
	.ResultBusMode(ResultBusMode),
	.IR_load(IR_load),
	.PC_load(PC_load),
	.ACC_load(ACC_load),
	.IXR_load(IXR_load),
	.TR_load(TR_load),
	.Flag_load(Flag_load),
	.IDR_load(IDR_load),
	.R_Wmode(R_Wmode),
	.VMAmode(VMAmode),
	.WAIT(WAIT)
	);

// Instruction Register
always @(posedge CLOCK3 or negedge RESET)
begin
        if (!RESET)
                IR = 0;
        else if(IR_load)
                IR = #1 IntDataIn;
end

// Program Counter
always @(posedge CLOCK3 or negedge RESET)
begin
        if (!RESET)
                PC = 0;
        else if(PC_load)
                PC= #1 AluBuf;
end

// Accumulator Register
always @(posedge CLOCK3 or negedge RESET)
begin
        if (!RESET)
                ACC = 0;
        else if(ACC_load)
                ACC = #1 AluOut;
end

// Index Register
always @(posedge CLOCK3 or negedge RESET)
begin
        if (!RESET)
                IXR = 0;
        else if(IXR_load)
                IXR = #1 AluOut;
end

// Temporary Register
always @(posedge CLOCK3 or negedge RESET)
begin
        if (!RESET)
                TR = 0;
        else if(TR_load)
                TR= #1 AluBuf;
end

// Carry Flag 
always @(posedge CLOCK3 or negedge RESET)
begin
        if (!RESET)
                CF = 0;
        else if(Flag_load)
                CF= #1 CFout;
end

// Zero Flag 
always @(posedge CLOCK3 or negedge RESET)
begin
        if (!RESET)
                ZF = 0;
        else if(Flag_load)
                ZF= #1 ZFout;
end

assign IDR_d = (R_Wmode) ? IntDataIn: DataOut;
// Intermediate Data Register 
always @(posedge CLOCK3 or negedge RESET)
begin
        if (!RESET)
                IDR = 0;
        else if(IDR_load)
                IDR = #1 IDR_d;
end

endmodule
