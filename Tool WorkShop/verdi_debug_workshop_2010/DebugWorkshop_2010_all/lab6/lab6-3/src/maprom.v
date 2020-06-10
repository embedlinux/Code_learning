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
   file name: maprom.v
   description: This part modelize the mapping rom

		addr: 8-bits address bus
		data: 8-bits data bus
		addr_error: address out of range
*/


`timescale 1 ns / 1 ns

module maprom(addr, dout, addr_error);
input [5:0] addr;
output [7:0] dout;
output addr_error;
reg [7:0] maprom [63:0];

 assign dout = maprom[addr]; 
 assign addr_error = ((addr>63) || (addr<0)) ? 1 : 0; 

initial
begin
	$readmemh("./src/memory/maprom.dat",maprom,0,63);
end
endmodule
