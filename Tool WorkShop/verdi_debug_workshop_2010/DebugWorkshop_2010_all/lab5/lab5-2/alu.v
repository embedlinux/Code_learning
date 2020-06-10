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
   File name: alu.v
   Descriptions:This module defines the arithmetic and login unit,
		which is used as a component in ALUB.

		a,b: operand data inputs
		cin: carry input
		select: alu function select
		out: alu result data output
		carry: alu result carry output
		zero: alu result zero output
*/

`timescale 1 ns / 1 ns
`include "alu.h"

module alu(a, b, cin, select, out, carry, zero);
input [7:0] a, b;
input cin;
input [2:0] select;
output [7:0] out;
output carry, zero;
reg [7:0] out;
reg carry;


always @(select or a or b or cin)
	begin
	#1 case (select)
	   `ADD:	{carry,out} = a + b + cin;
	   `SUB:	{carry,out} = a - b - 8'b1 + cin;
	   `SUB1:	{carry,out} = b - a - 8'b1 + cin;
	   `AND_OP:	{carry,out} = a & b;
	   `OR_OP:	{carry,out} = a | b;
	   `XOR_OP:	{carry,out} = a ^ b;
	   `XOR1_OP:	{carry,out} = a ^~ b;
	   default:	{carry,out} = 0;
	endcase
	end

assign zero = (out==0) ? 1 : 0;
endmodule
