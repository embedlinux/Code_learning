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
   file name: system.v
   description: This file is used to initalize the target system 
                and set up the stimulus for the simulation
*/

`timescale 1 ns / 1ns

module system;

parameter CYCLE = 50;

reg        clock;
reg        reset_cpu;
reg        reset_fsm;
wire [7:0] addr;
wire [7:0] data; 
reg        ThreeOnly, FirstDataInRdy;
wire       En_A, En_B, En_C, En_D;
wire [1:0] Mux1_Sel, Mux2_Sel;
wire       En_AB,En_AC,En_AD,En_BC,En_BD,En_CD;
wire [1:0] Mux3_Sel;
wire       FirstDataOutRdy;
wire       StartFSM1, StartFSM2, StartFSM3;


// instantiation CPU and program rom 
CPU i_cpu(clock,reset_cpu,VMA,R_W,data,addr);

pram i_pram(clock,VMA,R_W,addr,data);

fsm_master MASTER(clock, 
                  reset_fsm, 
                  ThreeOnly, 
                  FirstDataInRdy,
                
                  StartFSM1, 
                  StartFSM2, 
                  StartFSM3,
                  FirstDataOutRdy);
 
fsm_child1 CHILD1(clock, 
                  reset_fsm, 
                  ThreeOnly,
                  StartFSM1,
                
                  En_A, 
                  En_B, 
                  En_C, 
                  En_D);
 
fsm_child2 CHILD2(clock, 
                  reset_fsm, 
                  ThreeOnly,
                  StartFSM2,
                 
                  Mux1_Sel, 
                  Mux2_Sel,
                 
                  En_AB,
                  En_AC,
                  En_AD,
                  En_BC,
                  En_BD,
                  En_CD);
 
fsm_child3 CHILD3(clock, 
                  reset_fsm, 
                  ThreeOnly,
                  StartFSM3,
                  Mux3_Sel);

// initialization and run
initial
   begin
        $dumpfile("rtl.vcd");
        $dumpvars;
        $dumpports(system.i_cpu, "rtl.evcd");
        $fsdbDumpfile("rtl.fsdb");
        $fsdbDumpvars;
        $fsdbDumpOVA;
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
