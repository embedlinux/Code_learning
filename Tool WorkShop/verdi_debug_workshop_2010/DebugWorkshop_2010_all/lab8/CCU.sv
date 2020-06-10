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
   file name: CCU.v
   description: this part generates the timing control signals to 
                the rest parts of process under the controlof OpCode 
                of macroinstruction and predefined microinstsruction.

                TDB: tri-state data buffer (from PCU)
                clock: system clock
                reset: system reset
                CH: timing control (higher 14 bits to ALU)
                CL: timing control (lower 7 bits to PCU)
                IR: instruction register (to ALU)
*/

`timescale 1 ns / 1 ns
module CCU(input  ubyte       TDB,
           input  logic       clock,
           input  logic       reset,
           output logic [4:0] CH,
           output ALU_OP      alu_mode,
           output logic [2:0] bus_mode,
           output logic       carry_mode,
           output logic [2:0] mux_sel,
           output logic       C6, 
           output logic       C5, 
           output logic       C1,       //enable pram read
           output logic       C0,
           output logic [1:0] IR);

logic [5:0]   IR7_IR2; 
ubyte         MAP;
ubyte         n_MA;
ubyte         MA;
ubyte         next_MA;
logic         MA_carry;
logic         n_C20;
logic         n_C21;
logic         C21;
logic         C20;
logic         C19;
MPROM_ENCODE  mprom_out;



// Instruction Register
always_ff @(negedge C19 or negedge reset)
 begin
        if (~reset)
                {IR7_IR2, IR} <= 0;
        else begin
                {IR7_IR2, IR} <= TDB;
        end
 end

// mapping rom
 maprom i_maprom (.addr(IR7_IR2)
                , .dout(MAP)
                , .addr_error());

// next address data selector
and (n_C20, reset, C20) ;
and (n_C21, reset, C21) ;

always_comb
        case ({n_C21, n_C20})
                0:      MA = 8'h00;
                1:      MA = MAP;
                2:      MA = 8'h00;
          default:      MA = next_MA;
        endcase

property fetch_opcode;
   @(posedge clock) (~n_C21 && ~n_C20);
endproperty

fetch: assert property (fetch_opcode);

// Incrementor for memory address
always_ff @(negedge clock or negedge reset)
 begin
        if (~reset)
                next_MA <= 0;
        else begin
                next_MA <= MA + 1'b1;
        end
 end

// microprogram rom
 mprom i_mprom (.addr(MA)
              , .dout(mprom_out)
              , .addr_error());

// timing control register
always_ff @(negedge clock or negedge reset)
 begin
        if (~reset) begin
                {C21, C20, C19, carry_mode, bus_mode, 
                alu_mode, CH, C6, C5, mux_sel, C1, C0} <= 22'h000000;
        end
        else begin
                C21 <= mprom_out.C21;
                C20 <= mprom_out.C20;
                C19 <= mprom_out.C19;
                carry_mode <= mprom_out.carry_mode;
                bus_mode <= mprom_out.bus_mode;
                alu_mode <= mprom_out.alu_mode;
                CH <= ~mprom_out.CH;
                C6 <= mprom_out.C6;
                C5 <= mprom_out.C5;
                mux_sel <= mprom_out.mux_sel;
                C1 <= mprom_out.C1;
                C0 <= mprom_out.C0;
        end
 end

endmodule
