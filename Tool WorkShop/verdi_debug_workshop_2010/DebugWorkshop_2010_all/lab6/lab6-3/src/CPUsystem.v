// ************************************************************************
// *  NOVAS SOFTWARE CONFIDENTIAL PROPRIETARY NOTE                        *
// *                                                                      *
// *  This software contains information confidential and proprietary     *
// *  to Novas Software Inc. It shall not be reproduced in whole          *
// *  or in part or transferred to other documents, or disclosed          *
// *  to third parties, or used for any purpose other than that           *
// *  for which it was obtained, without the prior written consent        *
// *  of Novas Software Inc.                                              *
// *  (c) 1996, 1997 Novas Software Inc.                                  *
// *  All rights reserved                                                 *
// *                                                                      *
// ************************************************************************

/* Verdi tutorial case: A simplified microprogramming-based CPU
   File name: CPUsystem.v
   Descriptions: The CPUsystem consists of a CPU and a program ram. 
*/

`timescale 1 ns / 1ns

module CPUsystem(RESET, CLOCK1, CLOCK2, CLOCK3, CLOCK4);

input CLOCK1, CLOCK2, CLOCK3, CLOCK4;
input RESET;

wire [7:0] addr;
wire [7:0] data; 
wire VMA,R_W;
wire BUSY;

wire [7:0] RAM20;
wire [7:0] RAM21;
wire [7:0] RAM22;
wire [7:0] RAM23;
wire [7:0] PC;
wire [7:0] IXR;
wire IR_load;

CPU i_CPU(CLOCK1,CLOCK2,CLOCK3,CLOCK4,RESET,VMA,R_W,BUSY,data,addr);
pram i_pram(CLOCK1,VMA,R_W,BUSY,addr,data);

endmodule
