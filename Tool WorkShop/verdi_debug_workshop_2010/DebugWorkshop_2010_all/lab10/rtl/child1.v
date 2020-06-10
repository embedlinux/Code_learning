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
 
`timescale 1 ns / 1ns

typedef enum bit [1:0] {ST_A, ST_B, ST_C, ST_D} STATE;

module fsm_child1( 
	input  Clock, 
        input  Reset,
        input  ThreeOnly,
        input  StartFSM1,
	output logic En_A, 
        output logic En_B, 
        output logic En_C, 
        output logic En_D);

STATE CurrStateFSM1, NextStateFSM1;
	
   //------
   // FSM1
   //------
   always @(StartFSM1 or ThreeOnly or CurrStateFSM1)
     begin: FSM1_COMB
       En_A = 0;
       En_B = 0;
       En_C = 0;
       En_D = 0;
       case (CurrStateFSM1)
          ST_A :  if (StartFSM1)
                    begin
                      En_A = 1;
                      NextStateFSM1 = ST_B;
                    end
                  else 
                    NextStateFSM1 = ST_A;
          ST_B :  begin
                    En_B = 1;
                    NextStateFSM1 = ST_C;
                  end
          ST_C :  begin
                    En_C = 1;
                    if (ThreeOnly)
                      NextStateFSM1 = ST_A;
                    else 
                      NextStateFSM1 = ST_D;
                  end
          ST_D :  begin
                    En_D = 1;
                    NextStateFSM1 = ST_A;
                  end
          default :  NextStateFSM1 = ST_A;
       endcase
     end

   always @(posedge Clock)
     begin: FSM1_SEQ
       if (Reset)
         CurrStateFSM1 = ST_A;
       else
         CurrStateFSM1 = NextStateFSM1;
     end
endmodule
