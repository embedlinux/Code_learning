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

/* Debussy tutorial case: A simplified microprogramming-based CPU
   file name: system.v
   description: This file is used to initalize the target system 
		and set up the stimulus for the simulation
*/

`timescale 1 ns / 1ns

module system;

parameter CYCLE = 50;

reg clock;
reg reset;
wire [7:0] addr;
wire [7:0] data; 

wire NextCard;
wire OK;
wire Fail; 
wire [4:0] Total; 
wire NewCard; 
wire NewGame; 
wire [3:0] Card; 
wire BJ_clock; 
wire BJ_reset;
wire Ace; 

BJsource i_BJsource (.NextCard(NextCard)
	, .OK(OK)
	, .Fail(Fail)
	, .NewCard(NewCard)
	, .NewGame(NewGame)
	, .Card(Card)
	, .BJ_clock(BJ_clock)
	, .reset(BJ_reset));

BJkernel i_BJkernel (.NewCard(NewCard)
	, .NewGame(NewGame)
	, .Card(Card)
	, .BJ_clock(BJ_clock)
	, .reset(BJ_reset)
	, .NextCard(NextCard)
	, .OK(OK)
	, .Fail(Fail)
	, .Total(Total)
	, .Ace(Ace));
// instantiation CPU and program rom 
CPU i_cpu(clock,reset,VMA,R_W,data,addr);
pram i_pram(clock,VMA,R_W,addr,data);

// initialization and run
initial
   begin
   // test for Split mode of Virtual File Editor
    //$fsdbDumpvarsToFile("cpu.lst","cpu.fsdb");
    //$fsdbDumpvarsToFile("pram.lst","pram.fsdb");
   // test for Switch mode of Virtual File Editor
    $fsdbDumpfile("time1.fsdb");
    $fsdbDumpvars;
    #5000 
    //#5000 $fsdbDumpflush;
    $fsdbSwitchDumpfile("time2.fsdb");
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
