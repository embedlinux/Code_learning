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
   File name: PCU.v
   Descriptions:This module containing the I/O interface of CPU. 
		TDB: temporary data buffer
*/


`timescale 1 ns / 1 ns


module PCU ( RESET, CLOCK1, CLOCK2, CLOCK3, CLOCK4,  
		R_Wmode, VMAmode, WAIT, IntAddr, IntDataIn, IntDataOut, 
		R_W, VMA, BUSY, ExtAddr, ExtData  
		);
input RESET;
input CLOCK1;
input CLOCK2;
input CLOCK3;
input CLOCK4;
input R_Wmode;
input VMAmode;
output WAIT;
input [7:0] IntAddr;
output [7:0] IntDataIn;
input [7:0] IntDataOut;

output R_W;
output VMA;
input  BUSY;
output [7:0] ExtAddr;
inout [7:0] ExtData;

reg [7:0] TDB;
reg [7:0] AddrBuf;
reg WAIT;

always @(posedge CLOCK2 or negedge RESET)
begin
        if (!RESET)
                TDB = 0;
        else if(R_Wmode)
                TDB = #1 ExtData;
end

always @(posedge CLOCK4 or negedge RESET)
begin
        if (!RESET)
                AddrBuf = 0;
        else
                AddrBuf = #1 IntAddr;
end

always @(posedge CLOCK2 or negedge RESET)
begin
        if (!RESET)
                WAIT = 0;
        else if(!WAIT && BUSY)
                WAIT = #1 1;
        else if(WAIT && !BUSY)
                WAIT = #1 0;
end

assign IntDataIn = TDB;
assign ExtAddr = AddrBuf;
assign ExtData = (R_Wmode) ? 8'bzzzzzzzz: IntDataOut;
assign R_W = R_Wmode;
assign VMA = VMAmode;

endmodule
