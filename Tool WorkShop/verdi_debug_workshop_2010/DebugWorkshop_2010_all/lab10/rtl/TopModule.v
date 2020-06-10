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
   file name: TopModule.v
   description: This part describes the top module of CPU including
		CCU, PCU, ALU three block and their connectivity.

		clock: system clock
		reset: system reset
		VMA: valid memory address where read/write can be performed
		R_W: memory read or memory write
		data: 8-bits data bus
		addr: 8-bits address bus
*/

`timescale 1 ns / 1 ns
`define TRUE 1
`define INCA 2

`define M_SEQ \
e_r; \
logic [7:0] ALU_prev; \
   @(negedge clock) (`TRUE, ALU_prev = ALU) ##[1:2] ((ALU == ALU_prev + 1)); \
endsequence



module CPU(input        clock,
           input        reset,
	   output VMA,
	   output R_W,
	   inout [7:0] data,
	   output [7:0] addr);

logic [4:0] CH;
ALU_OP      alu_mode;
logic [2:0] bus_mode;
logic       carry_mode;
logic       S1;
ubyte       ALU;
ubyte       IXR; 
ubyte       IDB;
ubyte       PC;
logic [1:0] IR;
ubyte       TDB;
logic       C0, C1, C5, C6;
logic [2:0] mux_sel;


assign addr = IDB;
assign VMA = C0;
assign R_W = C1;

// Program Control Unit block
 PCU i_PCU (.S1
	  , .ALU
	  , .IXR
	  , .clock
	  , .reset
	  , .data (data)
	  , .mux_sel
	  , .C6
	  , .C5
	  , .C1
	  , .PC
	  , .error_in(error)
	  , .IDB
	  , .TDB);

// Arithmatic and Logic Unit block
 ALUB i_ALUB (.IR
	    , .IDB
	    , .PC
	    , .CH
	    , .alu_mode
	    , .bus_mode
	    , .carry_mode
	    , .clock
	    , .error_out(error)
	    , .reset
	    , .S1
	    , .ALU
	    , .IXR);

// Computer Control Unit block
 CCU i_CCU (.TDB
  	  , .clock
	  , .reset
	  , .CH
	  , .alu_mode
	  , .bus_mode
	  , .carry_mode
	  , .mux_sel
	  , .C6
	  , .C5
	  , .C1
	  , .C0
	  , .IR);

// SVA
// If ALU mode is INCrement then
// AluBuf output register should follow sequence: 0,1,2,3,4,5

//logic [7:0] ALU_prev;
//always @(posedge clock) ALU_prev = ALU;
logic PC_load;
assign PC_load = C5;

`ifdef SVA_ENABLE

sequence e_l;
   @(negedge clock) (bus_mode == `INCA) && PC_load;
endsequence


sequence`M_SEQ

property e_INC;
   @(negedge clock) e_l |-> e_r;
endproperty

INCPC: assert property (e_INC);

`endif  

endmodule
