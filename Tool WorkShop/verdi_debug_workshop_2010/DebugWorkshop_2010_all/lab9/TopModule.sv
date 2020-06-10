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

module CPU(input        clock,
           input        reset,
           pram_interface.master pram_intf);

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


assign pram_intf.addr = IDB;
assign pram_intf.VMA = C0;
assign pram_intf.R_W = C1;

// Program Control Unit block
 PCU i_PCU (.S1
          , .ALU
          , .IXR
          , .clock
          , .reset
          , .data (pram_intf.data)
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
// AlU buffer output register should follow sequence: 0,1,2,3,4,5

// Example of external modeling code ...
logic PC_load;
assign PC_load = C5;

// Example of $past system function
sequence e_l;
   @(posedge clock) (bus_mode == `INCA) && PC_load;
endsequence

sequence e_r;
   @(posedge clock) (`TRUE) ##[1:2] ((ALU == $past(ALU) + 1));
endsequence

property e_INC;
   @(posedge clock) e_l |-> e_r;
endproperty

INCPC: assert property (e_INC);

// Example of local var
sequence e_l2;
   @(posedge clock) (bus_mode == `INCA);
endsequence

sequence e_r2;
   logic [7:0] ALU_prev;
   @(posedge clock) (PC_load, ALU_prev = ALU) ##[1:2] (ALU == ALU_prev + 1);
endsequence

sequence e_r3;
   logic [7:0] ALU_prev; // init to X
   bit [7:0] flag;       // init to 0 for 2-state
   @(posedge clock) (PC_load, ALU_prev = ALU) ##[1:2] (ALU == ALU_prev + 1, flag = 1);
endsequence

COVER_e_r3: cover property (@(posedge clock) e_r3); 

property e_INC2;
   @(posedge clock) e_l2 |-> e_r2;
endproperty

INCPC2: assert property (e_INC2);

property e_PCLD;
   int cnt;
   @(posedge clock) (`TRUE, cnt = 0)
                    ##0 
                    (PC_load, cnt = cnt + 1)[*5]
                    ##1
                    (cnt == 5);
endproperty

LD: assert property (e_PCLD);

endmodule
