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
   file name: pram.v
   description: This part modelize the program memory for the system operation

		clock: system clock
		VMA: valid memory address where read/write can be performed
		R_W: memory read or memory write
		addr: 8-bits address bus
		data: 8-bits data bus
*/

module pram(input clock,
	    input VMA,
	    input R_W,
	    input [7:0] addr,
	    inout [7:0] data);
ubyte       macroram [255:0];
ubyte       dataout;

assign data = R_W ? dataout : 8'hz;

//always @(posedge (clock & pram_intf.VMA))
//begin
//	$fsdbDumpMem(macroram, 0, 256);
//	if (pram_intf.R_W == 1) dataout=macroram[pram_intf.addr];
//	else macroram[pram_intf.addr]=pram_intf.data;
//end

endmodule
