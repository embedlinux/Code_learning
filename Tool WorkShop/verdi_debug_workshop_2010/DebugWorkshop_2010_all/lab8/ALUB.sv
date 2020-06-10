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

/* Novas tutorial case: A simplified microprogramming-based CPU
   file name: ALUB.v
   description: this part performs the arithmetic and logic funtion
                on the operands of internal data bus(IDB)

                IR: instruction logicister (from CCU)
                IDB: internal data bus (from PCU)
                PC: program counter (from PCU)
                C: timing control (from CCU,12-bits)
                clock: system clock
                reset: system reset
                S1: program counter control (to PCU)
                ALU: ALU output logic data (to PCU)
                IXR: index logicister (to PCU)
*/

`timescale 1 ns / 1 ns

`define ADD     0
`define SUB     1
`define SUB1    2
`define AND_OP  3
`define OR_OP   4
`define XOR_OP  5
`define XOR1_OP 6

typedef struct {
   ubyte a;
   ubyte b;
   logic cin;
} OPERAND;

module ALUB(input  logic [1:0] IR, 
            input  ubyte       IDB,
            input  ubyte       PC, 
            input  logic [4:0] CH, 
            input  ALU_OP      alu_mode, 
            input  logic [2:0] bus_mode, 
            input  logic       carry_mode, 
            input  logic       clock, 
            input  logic       reset, 
            output logic       S1, 
            output ubyte       ALU, 
            output ubyte       IXR, 
            output logic       error_out);

ubyte   IXR_tmp;
ubyte   ACC_tmp;
ubyte   ACC;
logic   zero_flag;
logic   carry_flag;
ubyte   X0, Y0;

OPERAND alu_operand;
assign alu_operand = {X0, Y0, carry_mode};

//wire
logic net_1, net_2, net_3;
logic carry;
logic zero;
logic T4, T2, T3;

and (T4, clock, CH[4]);
and (T3, clock, CH[3]);
and (T2, clock, CH[2]);


assign net_2 = (ALU == 8'h30) & (~CH[1]);
assign net_3 = S1 & (~IR[0]);
assign error_out = net_2 & net_3
			& (~carry_flag) & zero_flag & net_1;

alu i_alu (.op(alu_operand),
           .select(alu_mode), 
           .out(ALU) , 
           .carry(carry) , 
           .zero(zero));

//SVA: Example of vacuous success
sequence e_SUB;
   @(posedge system.clock) alu_mode == `SUB1;
endsequence
property CHECK_SUB;
   @(posedge system.clock) e_SUB |-> (ALU==Y0-X0-1+carry_flag);
endproperty

ALU_SUB: assert property (CHECK_SUB);

property CHECK_ALU_ZERO;
   @(posedge T2) (ALU!=0);
endproperty

ALU_ZERO: assert property (CHECK_ALU_ZERO);

// SVA generate

genvar i;

generate

  for (i = 0; i < 8; i = i + 1)
  begin : genblk
      cv: cover property(@(posedge T2) (ALU[i] == 1) );
  end

endgenerate


always_comb begin
        case (bus_mode)
                0:      X0 = IXR_tmp;
                1:      X0 = ACC_tmp;
                2:      X0 = PC;
                3:      X0 = ACC_tmp;
          default:      X0 = IDB;
        endcase
end

always_comb
        case (bus_mode)
                0:      Y0 = 8'h00;
                1:      Y0 = PC;
                2:      Y0 = 8'h00;
                3:      Y0 = 8'h00;
                4:      Y0 = PC;
                5:      Y0 = IXR_tmp;
                6:      Y0 = ACC_tmp;
          default:      Y0 = 8'h00;
        endcase

assign net_1 = (IR[0] == 0) ? zero_flag : carry_flag;
assign S1 = ~CH[0] | (~CH[1] & (IR[1] ^ net_1));



always_ff @(negedge clock or negedge reset)
 begin
        if (!reset) IXR_tmp <= 8'h00;
        else IXR_tmp <= IXR;
 end

always_ff @(negedge clock or negedge reset)
 begin
        if (!reset) ACC_tmp <= 8'h00;
        else ACC_tmp <= ACC;
 end

always_ff @(posedge T3 or negedge reset)
 begin
        if (!reset) IXR <= 8'h00;
        else IXR <= ALU;
 end

always_ff @(posedge T4 or negedge reset)
 begin
        if (!reset) ACC <= 8'h00;
        else ACC <= ALU;
 end

always_ff @(posedge T2 or negedge reset)
 begin
        if (!reset) carry_flag <= 1'b0;
        else carry_flag <= carry;
 end

always_ff @(posedge T2 or negedge reset)
 begin
        if (!reset) zero_flag <= 1'b0;
        else zero_flag <= zero;
 end

//SVA: Example of cover 
property add_overflow;
   @(posedge clock) ((X0 == 8'h55) & (Y0 == 8'h56));
endproperty
   
OF_COVER: cover property (add_overflow);

endmodule

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

/* Novas tutorial case: A simplified microprogramming-based CPU
   file name: alu.v
   description: this parts perform the arithmetic and login funtion 
 	        which is defined by mode select

		a,b: operand data input  logics
		cin: carry input  logic
		select: alu function select
		dout: alu result data output logic
		carry: alu result carry output logic
		zero: alu result zero output logic
*/

`timescale 1 ns / 1 ns

module alu(input  OPERAND op,
           input  ALU_OP  select,
           output ubyte   out,
           output logic   carry,
           output         zero);

always_comb
   begin
      case (select)
         ADD:     {carry,out} = op.a + op.b + op.cin;
         SUB:     {carry,out} = op.a - op.b - 1 + op.cin;
         SUB1:    {carry,out} = op.b - op.a - 1 + op.cin;
         AND_OP:  {carry,out} = op.a & op.b;
         OR_OP:   {carry,out} = op.a | op.b;
         XOR_OP:  {carry,out} = op.a ^ op.b;
         XOR1_OP: {carry,out} = op.a ^~ op.b;
         default:  {carry,out} = 0;
      endcase
   end

// Generate for design
wire [7:0] sum;

Nbit_adder i_Nbit_adder (
             .co(co),
             .sum(sum),
             .a(op.a),
             .b(op.b),
             .ci(op.cin)
);

 assign zero = (out==0) ? 1 : 0;
endmodule
