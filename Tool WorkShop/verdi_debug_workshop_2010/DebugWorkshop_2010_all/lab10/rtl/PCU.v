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

/* Debussy tutorial case: A simplified microprogramming-based CPU
   file name: PCU.v
   description: this part provides external memory read/write operations
 	        to perform macro-program sequence

		CL: timing control (from CCU,7-bits)
		ALU: ALU output data (from ALU)
		S1: program counter control (from ALU)
		IXR: index register (from ALU)
		reset: system reset
		data: 8-bits data bus
		PC: program counter (to ALU)
		IDB: internal data bus (to ALU)
		TDB: tri-state data buffer (to CCU)
*/

`define MACRO(clk) \
always_ff @(negedge clock) begin \
      reg_ALU <= ALU; \
end

`define MACRO1 \
  begin \
	if (~reset) reg_PC <= 8'h00; \
	else reg_PC <= next_reg_PC; \
  end


`timescale 1 ns / 1 ns

module PCU (input        error_in,
            input  [2:0] mux_sel,
            input        C6, C5, C1,
            input  ubyte ALU,
            input        S1,
            input  ubyte IXR,
	    input        clock,
            input        reset,
            inout  [7:0] data,
            output ubyte PC,
            output ubyte IDB,
            output ubyte TDB);

ubyte       TR;
ubyte       TDB0; 
ubyte       IDR;
logic       error_reset;

assign #1 error_reset = reset & error_in;

// data bus I/O

assign TDB0 = (C1 == 0) ? IDB : TDB;

always @(negedge C5 or negedge reset) begin
	if (~reset) IDR = 8'h00;
	else IDR = TDB0;
end

assign data = (~C1) ? IDR : 8'bzzzzzzzz;

//sv: fixed for timing
ubyte       reg_ALU;

`MACRO(clock) 
//always_ff @(negedge clock) begin
//	reg_ALU <= ALU;
//end

ubyte       reg_PC, next_reg_PC;
assign PC = (S1)? reg_PC : reg_ALU;
assign next_reg_PC = (S1) ? reg_PC : reg_ALU;

always @(negedge clock or negedge reset) 
`MACRO1
//  begin
//	if (~reset) reg_PC <= 8'h00;
//	else reg_PC <= next_reg_PC;
//  end

// Temporary Register
always @(negedge C6 or negedge reset)
begin
	if (~reset) TR = 8'h00;
	else TR = ALU;
end

// 8-to-1 multiplexer for IDB
always @(IDR or mux_sel or PC or TR or ALU or IXR)
	case (mux_sel)
		0:	IDB = IDR;
		1:	IDB = PC;
		2:	IDB = TR;
		3:	IDB = ALU;
		4:	IDB = IXR;
	  default:	IDB = 8'h00;
	endcase

always_latch
	if (error_reset)
		TDB = 8'h00;
	else if (C1) TDB = data;

endmodule
