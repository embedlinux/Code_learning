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
   File name: tb_CPUsystem.v
   Descriptions: This is the testbench generating the input stimuli. 
*/

`timescale 1 ns / 1ns

module tb_CPUsystem;

parameter CYCLE = 50;

reg CLOCK1, CLOCK2, CLOCK3, CLOCK4;
reg RESET;

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

CPUsystem i_CPUsystem(RESET,CLOCK1, CLOCK2, CLOCK3, CLOCK4);

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

// initialization and run
initial
   begin
        // Simulation dump
        $dumpfile("CPUsystem.dump");
        $dumpvars;
        #14000 $finish;
   end

// stimulus
// system RESET
initial
   begin
        CLOCK1 = 0;
        CLOCK2 = 0;
        CLOCK3 = 0;
        CLOCK4 = 0;
        RESET = 1;
        #(CYCLE/4) RESET = 0;
        #(CYCLE*4) RESET = 1;
    end

// CLOCK1
always
   begin
        CLOCK1 = 0;
        forever #CYCLE CLOCK1 = ~CLOCK1;
   end
    
// CLOCK2
always
   begin
        #(CYCLE/2) CLOCK2 = 0;
        forever #CYCLE CLOCK2 = ~CLOCK2;
   end

// CLOCK3
always
   begin
        #(CYCLE) CLOCK3 = 0;
        forever #CYCLE CLOCK3 = ~CLOCK3;
   end

// CLOCK4
always
   begin
        #(3*CYCLE/2) CLOCK4 = 0;
        forever #CYCLE CLOCK4 = ~CLOCK4;
   end

endmodule
