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
 
/* Tutorial case for nState: A simplified FSM design which is emulated Blackjack game machine  
   file name: BJsource.v
   description: This part simulates the dealer's operation which is described
                in an behavious model
		
		NextCard: Ask the dealer for a new card
		OK: inform dealer we are in Hold state
		Fail: inform dealer we are in Bust state
 
                NewCard: Dealer send a new card in
                NewGame: Start a new session of game
                Card: Card with the value conform to the Blackjack rule
                clock: A synchronous FSM clock 
                reset: System initialiation

*/

`timescale 1 ns / 1 ns

module BJsource (NextCard, OK, Fail, NewCard, NewGame, Card, BJ_clock, reset);
    input NextCard;
    input OK;
    input Fail;
    output NewCard;
    output NewGame;
    output [3:0] Card;
    output BJ_clock;
    output reset;

    parameter CYCLE = 50;
    
    reg NewCard;
    reg NewGame;
    reg [3:0] Card;
    reg BJ_clock;
    reg reset;
    reg [3:0] Card_temp[0:3];
    integer Card_i;

    initial 
      begin
	Card_temp[0] = 4;	
	Card_temp[1] = 11;	
	Card_temp[2] = 7;	
	Card_temp[3] = 10;	
	Card_i = 0;
      end

    //system initialization
    initial
      begin
        NewCard = 0;
        NewGame = 0;
        Card = 0;
        BJ_clock = 0;
        reset = 1;
        #(CYCLE/2) reset = 0;
        #(CYCLE*4) reset = 1;
      end

    //BJ_clock generation
    always
      begin
        #(CYCLE*5) BJ_clock = 0;
        forever #CYCLE BJ_clock = ~BJ_clock;
      end
 
    //dealer restart a new game
    always @(posedge OK or posedge Fail)
      begin
	#(CYCLE/2) NewGame = 1;
 	#(CYCLE) NewGame = 0;
      end

//    //dealer give a new card out
//    always @(posedge NextCard) 
//      begin
//	#(CYCLE) NewCard = 1;
//        //use random number generator to have the card value (1, 2, ...10, 11)
//	Card_temp = {$random} % 11; //random no from 0 to 11
//        if (Card_temp != 0) 
//	  if (Card_temp == 1) Card = 11; //if ACE, set Card value to 11
//          else Card = Card_temp; //set Card value as Random No
//        #(CYCLE) NewCard = 0;
//      end

/*  
    //dealer give a new card out
    always @(posedge NextCard) 
      begin
	#(CYCLE) NewCard = 1;
  	Card = Card_temp[Card_i%4];
        Card_i = Card_i +1;
        #(CYCLE) NewCard = 0;
      end
*/

always @(negedge BJ_clock)
      begin
        if (NextCard == 1)
	begin
            NewCard = 1;
  	    Card = Card_temp[Card_i%4];
            Card_i = Card_i +1;
	end
        else
            NewCard = 0;
      end


endmodule
