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
   File name: ALUB.v
   Descriptions:This module containing the datapath of CPU, which 
		performs arithmetic and logic funtions on the operands of 
		DataIn and internal registers. 	

		According to ResultBusMode, DataOut is sent with the values
		of DataIn or internal registers. 
*/

`timescale 1 ns / 1 ns

module ALUB( RESET, CLOCK1, CLOCK2, CLOCK3, CLOCK4, 
		OpBusMode, AluMode, CarryMode, ResultBusMode, 
		DataIn, PC, ACC, IXR, TR, 
		AluOut, AluBuf, DataOut, CFout, ZFout );

input CLOCK1;
input CLOCK2;
input CLOCK3;
input CLOCK4;
input RESET;

input [2:0] OpBusMode;
input [2:0] AluMode;
input CarryMode;
input [2:0] ResultBusMode;
input [7:0] DataIn;
input [7:0] PC;
input [7:0] ACC;
input [7:0] IXR;
input [7:0] TR;
output [7:0] AluOut;
output [7:0] AluBuf;
output [7:0] DataOut;
output CFout, ZFout;

reg [7:0] aluInA, aluInB;
reg [7:0] AluBuf;
reg [7:0] DataOut;
wire carryOut;
wire isZero;

always @(OpBusMode or DataIn or PC or ACC or IXR )
        case (OpBusMode)
                0:      aluInA = IXR;
                1:      aluInA = ACC;
                2:      aluInA = PC;
                3:      aluInA = ACC;
          default:      aluInA = DataIn;
        endcase

always @(OpBusMode or PC or ACC or IXR )
        case (OpBusMode)
                0:      aluInB = 8'h00;
                1:      aluInB = PC;
                2:      aluInB = 8'h00;
                3:      aluInB = 8'h00;
                4:      aluInB = PC;
                5:      aluInB = IXR;
                6:      aluInB = ACC;
          default:      aluInB = 8'h00;
        endcase


alu i_alu (.a(aluInA) , .b(aluInB) , .cin(CarryMode) , .select(AluMode)
        , .out(AluOut) , .carry(carryOut) , .zero(isZero));

always @(posedge CLOCK4 or negedge RESET)
begin
	if (!RESET)
		AluBuf = 0;
	else 
		AluBuf = #1 AluOut;
end


// 8-to-1 multiplexer for DataOut
always @(ResultBusMode or DataIn or PC or TR or AluBuf or IXR)
	case (ResultBusMode)
		0: DataOut=DataIn;
		1: DataOut=PC;
		2: DataOut=TR;
		3: DataOut=AluBuf;
		4: DataOut=IXR;
		default: DataOut=8'h00;
	endcase

assign CFout = carryOut;
assign ZFout = isZero;

endmodule
