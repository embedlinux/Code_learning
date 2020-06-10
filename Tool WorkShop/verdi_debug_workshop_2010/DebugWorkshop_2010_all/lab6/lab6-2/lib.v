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

`celldefine
module AN2(Z, A, B);
input A, B;
output Z;
	and #1 ( Z, A, B);
endmodule 

module AN2P(Z, A, B);
input A, B;
output Z;
	and #1 ( Z, A, B);
endmodule 

module AN3(Z, A, B, C);
input A, B, C;
output Z;
	and #2 (Z, A, B, C);
endmodule 

module AN3P(Z, A, B, C);
input A, B, C;
output Z;
	and #1 (Z, A, B, C);
endmodule 

module AN4(Z, A, B, C, D);
input A, B, C, D;
output Z;
	and #3 (Z, A, B, C, D);
endmodule 

module AN4P(Z, A, B, C, D);
input A, B, C, D;
output Z;
	and #1 (Z, A, B, C, D);
endmodule 

module AO2(Z, A, B, C, D);
input A, B, C, D;
output Z;
	and (n1, A, B);
	and (n2, C, D);
	nor #2 (Z, n1, n2);
endmodule 

module AO6(Z, A, B, C);
input A, B, C;
output Z;
	and (n1, A, B);
	nor #2 (Z, n1, C);
endmodule 

module BTS4(Z, A, E);
input A, E;
output Z;
	assign Z = (E == 1'b1) ? A : 1'bz;
endmodule 

module FA1(S, CO, CI, A, B);
input A, B, CI;
output S, CO;
	assign #3 {CO, S} = A + B +CI;
endmodule 

module HA1(S, CO, A, B);
input A, B;
output S, CO;
	assign #2 {CO, S} = A + B;
endmodule 

module LD2(Q, QN, D, GN);
input D, GN;
output Q, QN;
reg Q;
assign QN = ~Q;
	always @(GN or D)
		if (!GN) #4 Q = D;
endmodule 

module FD1(Q, QN, D, CP);
input D, CP;
output Q, QN;
reg Q;
assign QN = ~Q;
	always @(posedge CP )
		#4 Q = D;
endmodule 

module FD2(Q, QN, D, CP, CD);
input D, CP, CD;
output Q, QN;
reg Q;
assign QN = ~Q;
	always @(posedge CP or negedge CD)
		begin
		if (!CD) Q = #3 1'b0;
		else Q = #5 D;
		end
endmodule 

module FD3(Q, QN, D, CP, CD, SD);
input D, CP, CD, SD;
output Q, QN;
reg Q;
assign QN = ~Q;
	always @(posedge CP or negedge CD or negedge SD)
		begin
		if (!CD) Q = #3 1'b0;
		else if (!SD) Q = #3 1'b1;
		else Q = #5 D;
		end
endmodule 

module IV(Z, A);
input A;
output Z;
	not #1 (Z, A);
endmodule 

module IVP(Z, A);
input A;
output Z;
	 not (Z, A);
endmodule 

module MUX21H(Z, A, B, S);
input A, B, S;
output Z;
	assign #3 Z = (S == 1'b0) ? A : B;
endmodule 

module ND2(Z, A, B);
input A, B;
output Z;
	nand #1 (Z, A, B);
endmodule 

module ND2P(Z, A, B);
input A, B;
output Z;
	nand #1 (Z, A, B);
endmodule 

module ND3(Z, A, B, C);
input A, B, C;
output Z;
	nand #2 (Z, A, B, C);
endmodule 

module ND3P(Z, A, B, C);
input A, B, C;
output Z;
	nand #1 (Z, A, B, C);
endmodule 

module ND4(Z, A, B, C, D);
input A, B, C, D;
output Z;
	nand #3 (Z, A, B, C, D);
endmodule 

module ND4P(Z, A, B, C, D);
input A, B, C, D;
output Z;
	nand #1 (Z, A, B, C, D);
endmodule 

module NR2(Z, A, B);
input A, B;
output Z;
	nor #1 (Z, A, B);
endmodule 

module NR2P(Z, A, B);
input A, B;
output Z;
	nor #1 (Z, A, B);
endmodule 

module NR3(Z, A, B, C);
input A, B, C;
output Z;
	nor #2 (Z, A, B, C);
endmodule 

module NR3P(Z, A, B, C);
input A, B, C;
output Z;
	nor #1 (Z, A, B, C);
endmodule 

module NR4(Z, A, B, C, D);
input A, B, C, D;
output Z;
	nor #3 (Z, A, B, C, D);
endmodule 

module NR4P(Z, A, B, C, D);
input A, B, C, D;
output Z;
	nor #1 (Z, A, B, C, D);
endmodule 

module OR2(Z, A, B);
input A, B;
output Z;
	nand #1 (Z, A, B);
endmodule 

module OR2P(Z, A, B);
input A, B;
output Z;
	or #1 (Z, A, B);
endmodule 

module OR3(Z, A, B, C);
input A, B, C;
output Z;
	or #2 (Z, A, B, C);
endmodule 

module OR3P(Z, A, B, C);
input A, B, C;
output Z;
	or #1 (Z, A, B, C);
endmodule 

module OR4(Z, A, B, C, D);
input A, B, C, D;
output Z;
	or #3 (Z, A, B, C, D);
endmodule 

module OR4P(Z, A, B, C, D);
input A, B, C, D;
output Z;
	or #1 (Z, A, B, C, D);
endmodule 

`endcelldefine
