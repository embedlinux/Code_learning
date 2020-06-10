// ************************************************************************
// *  NOVAS SOFTWARE CONFIDENTIAL PROPRIETARY NOTE                        *
// *                                                                      *
// *  This software contains information confidential and proprietary     *
// *  to Novas Software Inc. It shall not be reproduced in whole          *
// *  or in part or transferred to other documents, or disclosed          *
// *  to third parties, or used for any purpose other than that           *
// *  for which it was obtained, without the prior written consent        *
// *  of Novas Software Inc.                                              *
// *  (c) 1996, 1997, 1998 Novas Software Inc                             *
// *  All rights reserved                                                 *
// *                                                                      *
// ************************************************************************
 
/* Tutorial case for nState: A simplified FSM design which is emulated Blackjack game machine  
   file name: BJkernel.v
   description: This part simulates the player operation 
 
                NewCard: Dealer send a new card in
                NewGame: Start a new session of game
                Card: Card with the value conform to the Blackjack rule
                clock: A synchronous FSM clock 
                reset: System initialiation
		
		NextCard: Ask the dealer for a new card
		OK: inform dealer we are in Hold state
		Fail: inform dealer we are in Bust state
		Total: Card value in total
		Ace: Is there one or more Ace?

*/

`timescale 1 ns / 1 ns


module BJkernel (NewCard, NewGame, Card, BJ_clock, reset, NextCard, OK, Fail, Total, Ace);
    input NewCard;
    input NewGame;
    input [3:0] Card;
    input BJ_clock;
    input reset;
    output NextCard;
    output OK;
    output Fail;
    output [4:0] Total;
    output Ace;

    // Start body of module BJkernel0

    reg NextCard;
    reg OK;
    reg Fail;
    reg [4:0] Total, temp_total;
    reg Ace, temp_Ace;
    reg [2:0] state, next_state;

    parameter 
        Start=3'b000, MoreCard=3'b001, Evaluate=3'b010, Compare16=3'b011,
        Compare21=3'b100, Hold=3'b101, Minus10=3'b110, Bust=3'b111;

    // State transition
    always @(posedge BJ_clock or negedge reset) 
        if (!reset)
            state = Start;
        else begin
            state = next_state;
            Total = temp_total;
            Ace = temp_Ace;
            end

    // Output and next state logic generation
    always @(state or NewCard or NewGame or Card or Total or Ace) begin
        // Default assignments
        //next_state = state;

        temp_total = Total;
        temp_Ace = Ace;

        case (state)
        //state Start
        Start: begin
            NextCard = 1'b0;
	    OK = 1'b0;
	    Fail = 1'b0;
	    temp_total = 5'b00000;
	    temp_Ace = 1'b0;
	    //transition Start -> MoreCard
	    if (!NewGame)
	        next_state = MoreCard;
            else
                next_state = Start;
	end
        //state MoreCard
        MoreCard: begin
            NextCard = 1'b1;
            OK = 1'b0;
            Fail = 1'b0;
            temp_Ace = 1'b0;
            //transition MoreCard -> Evaluate
            if (NewCard)
                next_state = Evaluate;
            else
                next_state = MoreCard;
        end
        //state Evaluate
        Evaluate: begin
            NextCard = 1'b0;
            OK = 1'b0;
            Fail = 1'b0;
            temp_total = Total + Card;
            temp_Ace = (Card == 11) | Ace;
            //transition Evaluate -> Compare16
            if (!NewCard) 
                next_state = Compare16;
            else
                next_state = Evaluate;
        end
        //state Compare16
        Compare16: begin
            NextCard = 1'b0;
            OK = 1'b0;
            Fail = 1'b0;
            //transition Compare16 -> Compare21
            if (Total > 16) 
                next_state = Compare21;
            //transition Compare16 -> MoreCard
            else 
                next_state = MoreCard;
        end
        //state Compare21
        Compare21: begin
            NextCard = 1'b0;
            OK = 1'b0;
            Fail = 1'b0;
            //transition Compare21 -> Hold
            if (Total <= 21)
                next_state = Hold;
            //transition Compare21 -> Minus10
            else if (Ace)
                next_state = Minus10;
            //transition Compare21 -> Bust
            else
                next_state = Bust;
        end
        //state Hold
        Hold: begin
            NextCard = 1'b0;
            OK = 1'b1;
            Fail = 1'b0;
            //transition Hold -> Start
            if (NewGame)
                next_state = Start;
            else
                next_state = Hold;
        end
        //state Minus10
        Minus10: begin
            NextCard = 1'b0;
            OK = 1'b0;
            Fail = 1'b0;
            temp_total = Total - 10; 
            //transition Minus10 -> Start
            if (NewGame)
                next_state = Start;
	    else 
                next_state = Compare16;
        end
        //state Bust
        Bust: begin
            NextCard = 1'b0;
            OK = 1'b0;
            Fail = 1'b1;
            //transition Bust -> Start
            if (NewGame)
                next_state = Start;
            else
                next_state = Bust;
        end
        //default: next_state = state;
        endcase
    end

endmodule
