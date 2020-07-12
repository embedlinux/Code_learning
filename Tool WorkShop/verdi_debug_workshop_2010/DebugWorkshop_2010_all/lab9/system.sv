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
   file name: system.v
   description: This file is used to initalize the target system 
                and set up the stimulus for the simulation
*/

`timescale 1 ns / 1ns
typedef logic [7:0] ubyte;

interface pram_interface;
   logic       VMA;
   logic       R_W;
   ubyte       addr;
   wire  [7:0] data;
   
   modport master(output VMA, R_W, addr, inout data);
   modport slave (input  VMA, R_W, addr, inout data);
endinterface

typedef enum bit[2:0] {ADD, SUB, SUB1, AND_OP, OR_OP, XOR_OP, XOR1_OP} ALU_OP;

typedef struct packed {
	logic 	C21;
	logic 	C20;
	logic 	C19;
	logic 	carry_mode;
	logic  	[2:0] bus_mode;
	ALU_OP 	alu_mode;
	logic 	[4:0] CH;
	logic 	C6;
	logic 	C5;
	logic 	[2:0] mux_sel;
	logic 	C1;
	logic 	C0;
} MPROM_ENCODE;


module system;

parameter CYCLE = 50;

logic        clock;
logic        reset_cpu;
logic        reset_fsm;
logic        ThreeOnly, FirstDataInRdy;
wire       En_A, En_B, En_C, En_D;
wire [1:0] Mux1_Sel, Mux2_Sel;
wire       En_AB,En_AC,En_AD,En_BC,En_BD,En_CD;
wire [1:0] Mux3_Sel;
wire       FirstDataOutRdy;
wire       StartFSM1, StartFSM2, StartFSM3;

pram_interface pram_intf();

// instantiation CPU and program rom 
CPU i_cpu(.clock,
          .reset(reset_cpu),
          .pram_intf(pram_intf.master));

pram i_pram(.clock,
            .pram_intf(pram_intf.slave));

fsm_master MASTER(clock, 
                  reset_fsm, 
                  ThreeOnly, 
                  FirstDataInRdy,
                
                  StartFSM1, 
                  StartFSM2, 
                  StartFSM3,
                  FirstDataOutRdy);
 
fsm_child1 CHILD1(.Clock(clock), 
                  .Reset(reset_fsm), 
                  .ThreeOnly,
                  .StartFSM1,
                
                  .En_A, 
                  .En_B, 
                  .En_C, 
                  .En_D);
 
fsm_child2 CHILD2(.Clock(clock),
                  .Reset(reset_fsm),
                  .*);
 
fsm_child3 CHILD3(clock, 
                  reset_fsm, 
                  ThreeOnly,
                  StartFSM3,
                  Mux3_Sel);

// initialization and run
initial
   begin
//        $fsdbDumpfile("sv.fsdb");
        $fsdbDumpfile("rtl.fsdb");
//        $fsdbDumpSVA;
        $fsdbDumpvars(0, system, "+all");
        #12500 $finish;
   end

// stimulus
// system reset
initial
   begin

        reset_fsm = 0;
        FirstDataInRdy = 0;
        ThreeOnly = 0;
        #(5 * CYCLE)  FirstDataInRdy = 1;
   end

 initial
   begin
        clock = 0;
        reset_cpu = 1;
        #(CYCLE/2) reset_cpu = 0;
        #(CYCLE*4) reset_cpu = 1;
    end
// system clock

always
   begin
        #(CYCLE*5) clock = 0;
        forever #CYCLE clock = ~clock;
   end
    
endmodule