//----------------------------------------------------------------------------
// Accellera Copyright (c) 2007. All rights reserved.
//----------------------------------------------------------------------------

//----------------------------------------------------------------------------
// CONTENTS (last updated: Mon Sep 10 12:33:03 BST 2007)
// ========
//  56.  About this module (all 33 assert_ s, with an instance for one or more configs)
//  63.    - Naming convention (e.g. alw_1 for config 1 of assert_always)
// 185. 
// 186.  Combinatorial s
// 190.    - assert_never_unknown_async  1 config
// 201.    - assert_proposition          1 config
// 214. 
// 215.  Single-Cycle s
// 219.    - assert_always               4 configs (to test property_type) *REVISIT*: add _ASSUME_2STATE
// 265.    - assert_even_parity          1 config
// 278.    - assert_implication          1 config
// 292.    - assert_never                3 configs (to test severity_level)
// 327.    - assert_never_unknown        1 config
// 341.    - assert_odd_parity           1 config
// 354.    - assert_one_cold             3 configs (one_cold, one_cold/zero, one_cold/max)
// 387.    - assert_one_hot              1 config
// 400.    - assert_range                1 config
// 413.    - assert_zero_one_hot         1 config
// 427. 
// 428.  2-Cycle s
// 432.    - assert_always_on_edge       4 configs (to test edge_type)
// 479.    - assert_decrement            2 configs (dec-by-1 & dec-by-2)     
// 502.    - assert_delta                1 config
// 515.    - assert_fifo_index           1 config
// 529.    - assert_increment            2 configs (inc-by-1 & inc-by-2)     
// 552.    - assert_no_overflow          1 config
// 565.    - assert_no_transition        1 config
// 580.    - assert_no_underflow         1 config
// 593.    - assert_quiescent_state      1 config *REVISIT*: add EOS config
// 608.    - assert_transition           1 config
// 624. 
// 625.  n-Cycle s
// 629.    - assert_change               3 configs
// 665.    - assert_cycle_sequence       3 configs
// 698.    - assert_frame                5 configs
// 756.    - assert_handshake            1 config (same as timing diagram) *REVISIT*: add more configs
// 770.    - assert_next                 3 configs
// 806.    - assert_time                 3 configs
// 842.    - assert_unchange             3 configs
// 878.    - assert_width                4 configs (min/max at 0/>1) *REVISIT* configs with min=1, max=1
// 927. 
// 928.  Event-Bound s
// 932.    - assert_win_change           1 config
// 947.    - assert_window               1 config
// 962.    - assert_win_unchange         1 config
//----------------------------------------------------------------------------


// INDEX: About this module (all 33 assert_ s, with an instance for one or more configs)
// =====
// This module instances every , with many s instanced multiple times
// for the different configs. The configs were initially developed from the
//  timing diagrams, so parameters settings will often match.


// INDEX:   - Naming convention (e.g. alw_1 for config 1 of assert_always)
// =====
// Each assertion type has a unique 3-letter id, as listed below. In addition,
// each config has a number to uniquify it. Instance names and ports use the
// id and config number, so it's easy to keep track of.
// 
// alw assert_always
// aoe assert_always_on_edge
// chg assert_change
// csq assert_cycle_sequence
// dec assert_decrement
// dlt assert_delta
// evp assert_even_parity
// fix assert_fifo_index
// frm assert_frame
// hnd assert_handshake
// imp assert_implication
// inc assert_increment
// nvr assert_never
// nun assert_never_unknown
// nua assert_never_unknown_async
// nxt assert_next
// noo assert_no_overflow
// not assert_no_transition
// nou assert_no_underflow
// odp assert_odd_parity
// ocd assert_one_cold
// oht assert_one_hot
// prp assert_proposition
// qst assert_quiescent_state
// rng assert_range
// tim assert_time
// trn assert_transition
// unc assert_unchange
// wid assert_width
// wch assert_win_change
// win assert_window
// wuc assert_win_unchange
// zoh assert_zero_one_hot

//`include "std_ovl_defines.h"
`timescale 1ns / 1ns

module assertion_checker
  (clk, clk2,reset_n,

   // Combinatorial s
   nua_1_test_expr,
   prp_1_test_expr,
   
   // Single-Cycle s
   alw_1_test_expr,
   alw_2_test_expr,
   alw_3_test_expr,
   alw_4_test_expr,
   evp_1_test_expr,
   imp_1_antecedent_expr, imp_1_consequent_expr,
   nvr_1_test_expr,
   nvr_2_test_expr,
   nvr_3_test_expr,
   nun_1_qualifier, nun_1_test_expr,
   odp_1_test_expr,
   ocd_1_test_expr,
   ocd_2_test_expr,
   ocd_3_test_expr,
   oht_1_test_expr,
   rng_1_test_expr,
   zoh_1_test_expr,

   // 2-Cycle s
   aoe_1_sampling_event, aoe_1_test_expr,
   aoe_2_sampling_event, aoe_2_test_expr,
   aoe_3_sampling_event, aoe_3_test_expr,
   aoe_4_sampling_event, aoe_4_test_expr,
   dec_1_test_expr,
   dec_2_test_expr,
   dlt_1_test_expr,
   fix_1_push, fix_1_pop,
   inc_1_test_expr,
   inc_2_test_expr,
   noo_1_test_expr,
   not_1_test_expr,
   nou_1_test_expr,
   qst_1_state_expr, qst_1_sample_event,
   trn_1_test_expr,
   
   // n-Cycle s
   chg_1_start_event, chg_1_test_expr,
   chg_2_start_event, chg_2_test_expr,
   chg_3_start_event, chg_3_test_expr,   
   csq_1_event_sequence,
   csq_2_event_sequence,
   csq_3_event_sequence,
   frm_1_start_event, frm_1_test_expr,
   frm_2_start_event, frm_2_test_expr,
   frm_3_start_event, frm_3_test_expr,
   frm_4_start_event, frm_4_test_expr,
   frm_5_start_event, frm_5_test_expr,
   hnd_1_req, hnd_1_ack,
   hnd_1_req_clk, hnd_1_ack_clk,
   nxt_1_start_event, nxt_1_test_expr, 
   nxt_2_start_event, nxt_2_test_expr, 
   nxt_3_start_event, nxt_3_test_expr,
   tim_1_start_event, tim_1_test_expr,
   tim_2_start_event, tim_2_test_expr,
   tim_3_start_event, tim_3_test_expr,
   unc_1_start_event, unc_1_test_expr,
   unc_2_start_event, unc_2_test_expr,
   unc_3_start_event, unc_3_test_expr,
   wid_1_test_expr,
   wid_2_test_expr,
   wid_3_test_expr,
   wid_4_test_expr,
   
   // Event-Bound s
   wch_1_start_event, wch_1_end_event, wch_1_test_expr,
   win_1_start_event, win_1_end_event, win_1_test_expr,
   wuc_1_start_event, wuc_1_end_event, wuc_1_test_expr
   );

   input clk, clk2,reset_n;
   input nun_1_qualifier; input [1:0] nun_1_test_expr;
   input rng_1_test_expr;
   input [7:0] odp_1_test_expr;
   input [7:0] ocd_1_test_expr;
   input [7:0] ocd_2_test_expr;
   input [7:0] ocd_3_test_expr;
   input [7:0] zoh_1_test_expr;
   input [3:0] dlt_1_test_expr; 
   input fix_1_push; input fix_1_pop; 



   input [3:0] inc_1_test_expr; 
   input [3:0] inc_2_test_expr; 
   input [2:0] noo_1_test_expr; 
   input [2:0] not_1_test_expr; 
   input [2:0] nou_1_test_expr; 


   input [2:0] qst_1_state_expr; input qst_1_sample_event;  


 
   input [2:0] trn_1_test_expr;
//1.0 async logic
//Combinatorial 
   // =====
   input [1:0] nua_1_test_expr;

`ifdef TEST_NUA
    always @(reset_n or nua_1_test_expr) begin
      if (reset_n != 1'b0) begin

       A_ASSERT_ASYNC_NEVER_UNKNOWN_P:
       assert #0 (!($isunknown(nua_1_test_expr)))
       else $display("ASSERT ERROR : nua_1_test_expr should never be X or Z");
     end
    end
`endif



   // =====
   input prp_1_test_expr;
`ifdef TEST_PRP
    always @(reset_n or prp_1_test_expr) begin
      if (reset_n != 1'b0) begin
      A_ASSERT_PROPOSITION_P:
        assert #0 (prp_1_test_expr != 1'b0)
        else $display("ASSERT ERROR : prp_1_test_expr should be high");
      end
    end // always  
`endif

   
   //-------------------------------------------------------------------------
   // INDEX:
   // INDEX: Single-Cycle s
   //-------------------------------------------------------------------------
//2.0 cycle logic

   
   // INDEX:   - assert_always            
   // =====
   //
   input alw_1_test_expr,alw_2_test_expr,alw_3_test_expr,alw_4_test_expr;

   property ASSERT_ALWAYS_P(test_expr);
     @(posedge clk)   disable iff (!reset_n)
     test_expr;
  endproperty


`ifdef TEST_ALW

    a_always_on_alw_1_test_expr: assert property(ASSERT_ALWAYS_P(alw_1_test_expr))
     else $display("ASSERT ERROR : alw_1_test_expr should be permanently high");
    a_always_on_alw_2_test_expr: assert property(ASSERT_ALWAYS_P(alw_2_test_expr))
     else $display("ASSERT ERROR : alw_2_test_expr should be permanently high");
`endif



//3.0 expression logic

   // INDEX:   - assert_even_parity    
   // =====
   input [7:0] evp_1_test_expr;
`ifdef TEST_EVP
    property ASSERT_EVEN_PARITY_P(test_expr);
      @(posedge clk)   disable iff (!reset_n)
      (!(^(test_expr)));
    endproperty     
  
    a_even_parity_evp_1_test_expr: assert property(ASSERT_EVEN_PARITY_P(evp_1_test_expr))
      else $display("ASSERT ERROR : evp_1_test_expr should have an even number of bits asserted");
`endif

   
   // INDEX:   - assert_implication          |->
   // =====
   input imp_1_antecedent_expr; input imp_1_consequent_expr;
`ifdef TEST_IMP
    property ASSERT_IMPLICATION_P(antecedent_expr,consequent_expr);
      @(posedge clk)   disable iff (!reset_n)
      antecedent_expr |-> consequent_expr;
    endproperty

    a_implication_imp_1_antecedent_expr_to_imp_1_consequent_expr: assert property(ASSERT_IMPLICATION_P(imp_1_antecedent_expr,imp_1_consequent_expr))
      else $display("ASSERT ERROR : imp_1_consequent_expr should be high when imp_1_antecedent_expr is high");
`endif


   // INDEX:   - assert_never                3 configs (to test severity_level)
   // =====
   input nvr_1_test_expr,nvr_2_test_expr,nvr_3_test_expr;
`ifdef TEST_NVR
     a_always_on_nvr_1_test_expr: assert property(ASSERT_ALWAYS_P(!nvr_1_test_expr))
       else $display("ASSERT ERROR : nvr_1_test_expr should be permanently low");
     a_always_on_nvr_2_test_expr: assert property(ASSERT_ALWAYS_P(!nvr_2_test_expr))
       else $display("ASSERT ERROR : nvr_2_test_expr should be permanently low");       
     a_always_on_nvr_3_test_expr: assert property(ASSERT_ALWAYS_P(!nvr_3_test_expr))
       else $display("ASSERT ERROR : nvr_3_test_expr should be permanently low");
`endif

   
   // INDEX:   - assert_one_hot              
   // =====
   input [7:0] oht_1_test_expr;
`ifdef TEST_OHT
    property ASSERT_ONE_HOT_P(test_expr);
      @(posedge clk)  disable iff (!reset_n)
      $onehot(test_expr);
    endproperty

    a_one_hot_oht_1_test_expr: assert property(ASSERT_ONE_HOT_P(oht_1_test_expr))
       else $display("ASSERT ERROR : oht_1_test_expr should be onehot");
`endif

   



   //-------------------------------------------------------------------------
   // INDEX:
   // INDEX: 2-Cycle 
   //-------------------------------------------------------------------------

 
   // INDEX:   - assert_always_on_edge       4 configs (to test edge_type)
   // =====
   input aoe_1_sampling_event; input aoe_1_test_expr; 
   input aoe_2_sampling_event; input aoe_2_test_expr; 
   input aoe_3_sampling_event; input aoe_3_test_expr; 
   input aoe_4_sampling_event; input aoe_4_test_expr; 
`ifdef TEST_AOE
    property ASSERT_ALWAYS_ON_EDGE_POSEDGE_P(sampling_event,test_expr);
    @(posedge clk)   disable iff (!reset_n)
    ( (!sampling_event ##1 sampling_event)
      |-> test_expr );
    endproperty
    a_always_on_edge_aoe_2_test_expr: assert property(ASSERT_ALWAYS_ON_EDGE_POSEDGE_P(aoe_2_sampling_event,aoe_2_test_expr))
       else $display("ASSERT ERROR : aoe_2_test_expr should be high on posedge");



    property ASSERT_ALWAYS_ON_EDGE_NEGEDGE_P(sampling_event,test_expr);
    @(posedge clk)   disable iff (!reset_n)
    ( (sampling_event ##1 !sampling_event)
      |-> test_expr );
    endproperty
    a_always_on_edge_aoe_3_test_expr: assert property(ASSERT_ALWAYS_ON_EDGE_NEGEDGE_P(aoe_3_sampling_event,aoe_3_test_expr))
       else $display("ASSERT ERROR : aoe_3_test_expr should be high on negedge");


    property ASSERT_ALWAYS_ON_EDGE_ANYEDGE_P(sampling_event,test_expr);
    @(posedge clk)   disable iff (!reset_n)
    ( ( (!sampling_event ##1 sampling_event) or
        (sampling_event ##1 !sampling_event) )
        |-> test_expr );
    endproperty
    a_always_on_edge_aoe_4_test_expr: assert property(ASSERT_ALWAYS_ON_EDGE_ANYEDGE_P(aoe_4_sampling_event,aoe_4_test_expr))
       else $display("ASSERT ERROR : aoe_4_test_expr should be high on any edge");


`endif






//past  p13


   // INDEX:   - assert_decrement              
   // =====
   input [3:0] dec_1_test_expr; 
   input [3:0] dec_2_test_expr; 
`ifdef TEST_DEC
  property ASSERT_DECREMENT_P(test_expr,value);
  @(posedge clk)   disable iff (!reset_n)
  (!($stable(test_expr)) && $past(reset_n) ) |-> ( (test_expr < $past(test_expr)) ?
                                                               ($past(test_expr) - test_expr == value) :
                                                               ($past(test_expr) + ({4{1'b1}} - test_expr) + 1'b1 == value)
                                                           );
  endproperty

    a_decrement_dec_1_test_expr: assert property(ASSERT_DECREMENT_P(dec_1_test_expr,1))
       else $display("ASSERT ERROR : dec_1_test_expr should decrement by 1");
  
    a_decrement_dec_2_test_expr: assert property(ASSERT_DECREMENT_P(dec_2_test_expr,2))
       else $display("ASSERT ERROR : dec_2_test_expr should decrement by 2");


`endif





   
   //-------------------------------------------------------------------------
   // INDEX:
   // INDEX: n-Cycle s
   //-------------------------------------------------------------------------


   input chg_1_start_event; input [7:0] chg_1_test_expr; 

   input chg_2_start_event; input [7:0] chg_2_test_expr; 

   input chg_3_start_event; input [7:0] chg_3_test_expr; 


   input [2:0] csq_1_event_sequence;

   input [2:0] csq_2_event_sequence;

   input [2:0] csq_3_event_sequence;



   // INDEX:   - assert_frame                   // =====
   input frm_1_start_event; input frm_1_test_expr; 

   input frm_2_start_event; input frm_2_test_expr; 
`ifdef TEST_FRM
    property ASSERT_FRAME_MIN_CHECK_P(start_event,test_expr,min_cks);
      @(posedge clk)       disable iff (!reset_n)
      $rose(start_event) |-> $rose(test_expr) ##0 ((test_expr[*min_cks])) ##1 !test_expr;
    endproperty

    a_frame_frm_2_test_expr: assert property(ASSERT_FRAME_MIN_CHECK_P(frm_2_start_event,frm_2_test_expr,7))
       else $display("ASSERT ERROR : frm_2_test_expr must hold within 7 cycles after frm_2_start_event");

   //
   property ASSERT_FRAME_MT_CHECK_P(start_event,test_expr,min_cks);
      @(posedge clk)       disable iff (!reset_n)
      $rose(start_event) |-> $rose(test_expr) |-> ((test_expr[*min_cks])) ##1 !test_expr;
   endproperty

    a_frame_mt_frm_2_test_expr: assert property(ASSERT_FRAME_MT_CHECK_P(frm_2_start_event,frm_2_test_expr,7))
       else $display("ASSERT ERROR : frm_2_test_expr must hold within 7 cycles after frm_2_start_event and frm_2_test_expr");


`endif


//p19 Quiz 1,2,3
   input frm_3_start_event; input frm_3_test_expr;
   input frm_4_start_event; input frm_4_test_expr; 

   input frm_5_start_event; input frm_5_test_expr;

   property ASSERT_NOTS_CHECK_P(start_event,test_expr);
      @(posedge clk)       disable iff (!reset_n)
      $rose(start_event) |-> not (##[1:3]test_expr);
   endproperty
   a_nots_frm_3_test_expr: assert property(ASSERT_NOTS_CHECK_P(frm_3_start_event,frm_3_test_expr))
       else $display("ASSERT ERROR : frm_3_test_expr must not hold within 3 cycles after frm_3_start_event");
   property ASSERT_NOTA_CHECK_P(start_event,test_expr);
      @(posedge clk)       disable iff (!reset_n)
      not ((start_event) |-> ##1 test_expr);
   endproperty
   a_nota_frm_4_test_expr: assert property(ASSERT_NOTA_CHECK_P(frm_4_start_event,frm_4_test_expr))
       else $display("ASSERT ERROR : frm_4_test_expr must not hold within 3 cycles after frm_4_start_event");

   property ASSERT_NOTAS_CHECK_P(start_event,test_expr);
      @(posedge clk)       disable iff (!reset_n)
      not ((start_event) |-> not (##1 test_expr));
   endproperty
   a_notas_frm_5_test_expr: assert property(ASSERT_NOTAS_CHECK_P(frm_5_start_event,frm_5_test_expr))
       else $display("ASSERT ERROR : frm_5_test_expr must not hold within 1 cycles after frm_5_start_event");



//p47 intersect
sequence wb_access(stb,ack);
	stb[*1:$] ##0 ack ##[1:$] !stb;
endsequence

property p_bus_length;
	@(posedge clk) $rose(aoe_1_sampling_event) |-> 1[*3:4]
	intersect wb_access(aoe_1_sampling_event,aoe_1_test_expr);
endproperty

   a_bus_length_aoe_1_test_expr: assert property(p_bus_length)
       else $display("ASSERT ERROR : a_bus_length_aoe_1_test_expr must hold within 3 or 4 cycles after aoe_1_sampling_event");

property p_valid_transfer;
	@(posedge clk) $rose(aoe_1_sampling_event) |-> wb_access(aoe_1_sampling_event,aoe_1_test_expr)
	within aoe_2_sampling_event[*4];
endproperty
   a_valid_transfer_aoe_1_test_expr: assert property(p_valid_transfer)
       else $display("ASSERT ERROR : a_valid_transfer_aoe_1_test_expr must hold within 3 or 4 cycles after aoe_1_sampling_event");


//p64 exercise 2
property ast;
	@(posedge clk) disable iff (!reset_n)
        not aoe_3_sampling_event[->3] within 1[*10];
endproperty
   a_ast_aoe_3_sampling_event: assert property(ast)
       else $display("ASSERT ERROR : a_ast_aoe_3_sampling_event must hold within 2 cycles");

property ast_intersect;
	@(posedge clk) disable iff (!reset_n)
        1[*10] intersect (aoe_3_sampling_event[=0:2]);
endproperty
property ast_intersect2;
	@(posedge clk) disable iff (!reset_n)
        (aoe_3_sampling_event[=0:2]) intersect 1[*10];
endproperty

   a_ast_intersect_aoe_3_sampling_event: assert property(ast_intersect)
       else $display("ASSERT ERROR : a_ast_intersect_aoe_3_sampling_event must hold within 2 cycles");

   a_ast_intersect2_aoe_3_sampling_event: assert property(ast_intersect2)
       else $display("ASSERT ERROR : a_ast_intersect2_aoe_3_sampling_event must hold within 2 cycles");


//p68 exercise 4
property ast_exercise4;
	@(posedge clk) disable iff (!reset_n)
        aoe_4_sampling_event[->3] |-> ##3 aoe_4_test_expr;
endproperty

   a_ast_exercise4_aoe_4_sampling_event: assert property(ast_exercise4)
       else $display("ASSERT ERROR : a_ast_exercise4_aoe_4_sampling_event must hold within 2 cycles");       


property ast_exercise4_2;
	@(posedge clk) disable iff (!reset_n)
        aoe_4_sampling_event[->3] |-> ##[0:3] $rose(aoe_4_test_expr);
endproperty

   a_ast_exercise4_2_aoe_4_sampling_event: assert property(ast_exercise4_2)
       else $display("ASSERT ERROR : a_ast_exercise4_2_aoe_4_sampling_event must hold within 2 cycles");   


//multiple clock 
   input hnd_1_req; input hnd_1_ack; 
   input hnd_1_req_clk; input hnd_1_ack_clk; 

property multiple_clk;
	@(posedge clk2) disable iff (!reset_n)
        hnd_1_req ##1 @(posedge clk) hnd_1_ack;
endproperty
      a_multiple_clk_hnd_1_ack: assert property(multiple_clk)
       else $display("ASSERT ERROR : a_multiple_clk_hnd_1_ack failed");    


       property multiple_clk_2;
	@(posedge clk2) disable iff (!reset_n)
        hnd_1_req and @(posedge clk) hnd_1_ack;
      endproperty

      a_multiple_clk_2_hnd_1_ack: assert property(multiple_clk_2)
       else $display("ASSERT ERROR : a_multiple2_clk_hnd_1_ack failed");

       property multiple_clk_3;
	@(posedge clk2) disable iff (!reset_n)
        hnd_1_req |=> @(posedge clk) hnd_1_ack;
      endproperty

      a_multiple_clk_3_hnd_1_ack: assert property(multiple_clk_3)
       else $display("ASSERT ERROR : a_multiple3_clk_hnd_1_ack failed");


 
//clock checker   p80
       property p_clock_period(period);
	        time curr_time;
		@(posedge clk2) disable iff (!reset_n)
        		(1,curr_time=$time) |=> ($time-curr_time==period);
      endproperty

      a_p_clock_period_10MHz: assert property(p_clock_period(100))
       else $display("ASSERT ERROR : a_p_clock_period_10MHz failed");



   // INDEX:   - sert_handshake            1 config (same as timing diagram) *REVISIT*: add more configs
   // =====
`ifdef TEST_HND
   assert_handshake #(`_ERROR, 0,3, 1,1,1, `_ASSERT, "hnd_1_req/ack should obey protocol")
   u_hnd_1
     (.clk     (clk),
      .reset_n (reset_n),
      .req     (hnd_1_req),
      .ack     (hnd_1_ack)
      );
`endif

 
   // INDEX:   - assert_next                 3 configs
   // =====
   input nxt_1_start_event; input nxt_1_test_expr; 
`ifdef TEST_NXT
   assert_next #(`_ERROR, 1,1,0, `_ASSERT, "nxt_1_test_expr should occur num_cks after start_event")
   u_nxt_1
     (.clk         (clk),
      .reset_n     (reset_n),
      .start_event (nxt_1_start_event),
      .test_expr   (nxt_1_test_expr)
      );
`endif
   //
   input nxt_2_start_event; input nxt_2_test_expr; 
`ifdef TEST_NXT
   assert_next #(`_ERROR, 2,0,0, `_ASSERT, "nxt_2_test_expr should occur num_cks after start_event")
   u_nxt_2
     (.clk         (clk),
      .reset_n     (reset_n),
      .start_event (nxt_2_start_event),
      .test_expr   (nxt_2_test_expr)
      );
`endif
   //
   input nxt_3_start_event; input nxt_3_test_expr; 
`ifdef TEST_NXT
   assert_next #(`_ERROR, 2,1,1, `_ASSERT, "nxt_3_test_expr should occur num_cks after start_event")
   u_nxt_3
     (.clk         (clk),
      .reset_n     (reset_n),
      .start_event (nxt_3_start_event),
      .test_expr   (nxt_3_test_expr)
      );
`endif

 
   // INDEX:   - assert_time                 3 configs
   // =====
   input tim_1_start_event; input tim_1_test_expr; 
`ifdef TEST_TIM
   assert_time #(`_ERROR, 5, `_IGNORE_NEW_START, `OVL_ASSERT, "tim_1_test_expr must hold for 5 cycles after tim_1_start_event (ignore new start)")
   u_tim_1
     (.clk         (clk),
      .reset_n     (reset_n),
      .start_event (tim_1_start_event),
      .test_expr   (tim_1_test_expr)
      );
`endif
   //
   input tim_2_start_event; input tim_2_test_expr; 
`ifdef TEST_TIM
   assert_time #(`_ERROR, 5, `_RESET_ON_NEW_START, `OVL_ASSERT, "tim_2_test_expr must hold for 5 cycles after tim_2_start_event (reset on new start)")
   u_tim_2
     (.clk         (clk),
      .reset_n     (reset_n),
      .start_event (tim_2_start_event),
      .test_expr   (tim_2_test_expr)
      );
`endif
   //
   input tim_3_start_event; input tim_3_test_expr; 
`ifdef TEST_TIM
   assert_time #(`_ERROR, 5, `_ERROR_ON_NEW_START, `OVL_ASSERT, "tim_3_test_expr must hold for 5 cycles after tim_3_start_event (error on new start)")
   u_tim_3
     (.clk         (clk),
      .reset_n     (reset_n),
      .start_event (tim_3_start_event),
      .test_expr   (tim_3_test_expr)
      );
`endif

 
   // INDEX:   - assert_unchange             3 configs
   // =====
   input unc_1_start_event; input [7:0] unc_1_test_expr; 
`ifdef TEST_UNC
   assert_unchange #(`_ERROR, 8, 4, `_IGNORE_NEW_START, `OVL_ASSERT, "unc_1_test_expr should be stable during num_cks of start_event")
   u_unc_1
     (.clk         (clk),
      .reset_n     (reset_n),
      .start_event (unc_1_start_event),
      .test_expr   (unc_1_test_expr)
      );
`endif
   //
   input unc_2_start_event; input [7:0] unc_2_test_expr; 
`ifdef TEST_UNC
   assert_unchange #(`_ERROR, 8, 4, `_RESET_ON_NEW_START, `OVL_ASSERT, "unc_2_test_expr should be stable during num_cks of start_event")
   u_unc_2
     (.clk         (clk),
      .reset_n     (reset_n),
      .start_event (unc_2_start_event),
      .test_expr   (unc_2_test_expr)
      );
`endif
   //
   input unc_3_start_event; input [7:0] unc_3_test_expr; 
`ifdef TEST_UNC
   assert_unchange #(`_ERROR, 8, 4, `_ERROR_ON_NEW_START, `OVL_ASSERT, "unc_3_test_expr should be stable during num_cks of start_event")
   u_unc_3
     (.clk         (clk),
      .reset_n     (reset_n),
      .start_event (unc_3_start_event),
      .test_expr   (unc_3_test_expr)
      );
`endif

 
   // INDEX:   - assert_width                4 configs (min/max at 0/>1) *REVISIT* configs with min=1, max=1
   // =====
   // Four configs as per the timing diagrams, expect for the 2nd config which uses
   // min=0 below (rather than min=1 in the timing diagrams).
   //
   // *REVISIT*: have min=1 and max=1 configs too.
   //
   input wid_1_test_expr; 
`ifdef TEST_WID
   assert_width #(`_ERROR, 4,0, `_ASSERT, "wid_1_test_expr should hold between min and max cycles")
   u_wid_1
     (.clk         (clk),
      .reset_n     (reset_n),
      .test_expr   (wid_1_test_expr)
      );
`endif
   //
   input wid_2_test_expr; 
`ifdef TEST_WID
   assert_width #(`_ERROR, 0,6, `_ASSERT, "wid_2_test_expr should hold between min and max cycles")
   u_wid_2
     (.clk         (clk),
      .reset_n     (reset_n),
      .test_expr   (wid_2_test_expr)
      );
`endif
   //
   input wid_3_test_expr; 
`ifdef TEST_WID
   assert_width #(`_ERROR, 4,4, `_ASSERT, "wid_3_test_expr should hold between min and max cycles")
   u_wid_3
     (.clk         (clk),
      .reset_n     (reset_n),
      .test_expr   (wid_3_test_expr)
      );
`endif
   //
   input wid_4_test_expr; 
`ifdef TEST_WID
   assert_width #(`_ERROR, 4,6, `_ASSERT, "wid_4_test_expr should hold between min and max cycles")
   u_wid_4
     (.clk         (clk),
      .reset_n     (reset_n),
      .test_expr   (wid_4_test_expr)
      );
`endif


   //-------------------------------------------------------------------------
   // INDEX:
   // INDEX: Event-Bound s
   //-------------------------------------------------------------------------

 
   // INDEX:   - assert_win_change           1 config
   // =====
   input wch_1_start_event; input wch_1_end_event; input [7:0] wch_1_test_expr; 
`ifdef TEST_WCH
   assert_win_change #(`_ERROR, 8, `_ASSERT, "wch_1_test_expr should change between start_event & end_event")
   u_wch_1
     (.clk         (clk),
      .reset_n     (reset_n),
      .start_event (wch_1_start_event),
      .end_event   (wch_1_end_event),
      .test_expr   (wch_1_test_expr)
      );
`endif

 
   // INDEX:   - assert_window               1 config
   // =====
   input win_1_start_event; input win_1_end_event; input win_1_test_expr;
`ifdef TEST_WIN
   assert_window #(`_ERROR, `_ASSERT, "win_1_test_expr should hold between start_event & end_event")
   u_win_1
     (.clk         (clk),
      .reset_n     (reset_n),
      .start_event (win_1_start_event),
      .end_event   (win_1_end_event),
      .test_expr   (win_1_test_expr)
      );
`endif

 
   // INDEX:   - assert_win_unchange         1 config
   // =====
   input wuc_1_start_event; input wuc_1_end_event; input [7:0] wuc_1_test_expr; 
`ifdef TEST_WUC
   assert_win_unchange #(`_ERROR, 8, `_ASSERT, "wuc_1_test_expr should be stable between start_event & end_event")
   u_wuc_1
     (.clk         (clk),
      .reset_n     (reset_n),
      .start_event (wuc_1_start_event),
      .end_event   (wuc_1_end_event),
      .test_expr   (wuc_1_test_expr)
      );
`endif

endmodule // assert_every_config

