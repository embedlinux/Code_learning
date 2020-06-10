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

parameter CYCLE = 40;

reg clock;
reg reset;
wire [7:0] addr;
wire [7:0] data; 

// instantiation CPU and program rom 
CPU i_cpu(clock,reset,VMA,R_W,data,addr);
pram i_pram(clock,VMA,R_W,addr,data);

// initialization and run
initial
   begin
        // $dumpfile("gate.vcd");
        // $dumpvars;
        // $dumpports(system.i_cpu, "gate.evcd");
        $fsdbDumpfile("gate.fsdb");
	$fsdbDumpvars;
        #12500 $finish;
   end

// stimulus
// system reset
initial
   begin
        clock = 0;
        reset = 1;
        #(CYCLE/2) reset = 0;
        #(CYCLE*4) reset = 1;
    end
// system clock
always
   begin
        #(CYCLE*5) clock = 0;
        forever #CYCLE clock = ~clock;
   end
    
endmodule
