//----------------------------------------------------------------------------
// Accellera Copyright (c) 2007. All rights reserved.
//----------------------------------------------------------------------------

//----------------------------------------------------------------------------
// CONTENTS (last updated: Mon Sep 10 12:33:03 BST 2007)
// ========
//  56.  About this module (all 33 assert_ OVLs, with an instance for one or more configs)
//  63.    - Naming convention (e.g. alw_1 for config 1 of assert_always)
// 185. 
// 186.  Combinatorial OVLs
// 190.    - assert_never_unknown_async  1 config
// 201.    - assert_proposition          1 config
// 214. 
// 215.  Single-Cycle OVLs
// 219.    - assert_always               4 configs (to test property_type) *REVISIT*: add OVL_ASSUME_2STATE
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
// 428.  2-Cycle OVLs
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
// 625.  n-Cycle OVLs
// 629.    - assert_change               3 configs
// 665.    - assert_cycle_sequence       3 configs
// 698.    - assert_frame                5 configs
// 756.    - assert_handshake            1 config (same as timing diagram) *REVISIT*: add more configs
// 770.    - assert_next                 3 configs
// 806.    - assert_time                 3 configs
// 842.    - assert_unchange             3 configs
// 878.    - assert_width                4 configs (min/max at 0/>1) *REVISIT* configs with min=1, max=1
// 927. 
// 928.  Event-Bound OVLs
// 932.    - assert_win_change           1 config
// 947.    - assert_window               1 config
// 962.    - assert_win_unchange         1 config
//----------------------------------------------------------------------------


// INDEX: About this module (all 33 assert_ OVLs, with an instance for one or more configs)
// =====
// This module instances every OVL, with many OVLs instanced multiple times
// for the different configs. The configs were initially developed from the
// OVL timing diagrams, so parameters settings will often match.


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

module assert_dut
  (clk, clk2,reset_n,

   // Combinatorial OVLs
   nua_1_test_expr,
   prp_1_test_expr,
   
   // Single-Cycle OVLs
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

   // 2-Cycle OVLs
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
   
   // n-Cycle OVLs
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
   
   // Event-Bound OVLs
   wch_1_start_event, wch_1_end_event, wch_1_test_expr,
   win_1_start_event, win_1_end_event, win_1_test_expr,
   wuc_1_start_event, wuc_1_end_event, wuc_1_test_expr
   );

   input clk, clk2, reset_n;

   reg [31:0] out;
   // =====
   input [1:0] nua_1_test_expr;
   input prp_1_test_expr;
   input alw_1_test_expr;
   input alw_2_test_expr;
   input alw_3_test_expr;
   input alw_4_test_expr;
   input [7:0] evp_1_test_expr;
   input imp_1_antecedent_expr; input imp_1_consequent_expr;
   input nvr_1_test_expr;
   input nvr_2_test_expr;
   input nvr_3_test_expr;
   input nun_1_qualifier; input [1:0] nun_1_test_expr;
   input [7:0] odp_1_test_expr;
   input [7:0] ocd_1_test_expr;
   input [7:0] ocd_2_test_expr;
   input [7:0] ocd_3_test_expr;
   input [7:0] oht_1_test_expr;
   input [2:0] rng_1_test_expr;
   input [7:0] zoh_1_test_expr;
   input aoe_1_sampling_event; input aoe_1_test_expr; 
   input aoe_2_sampling_event; input aoe_2_test_expr; 
   input aoe_3_sampling_event; input aoe_3_test_expr; 
   input aoe_4_sampling_event; input aoe_4_test_expr;
   input [3:0] dec_1_test_expr; 
   input [3:0] dec_2_test_expr; 
   input [3:0] dlt_1_test_expr; 
   input fix_1_push; input fix_1_pop; 
   input [3:0] inc_1_test_expr; 
   input [3:0] inc_2_test_expr; 
   input [2:0] noo_1_test_expr; 
   input [2:0] not_1_test_expr; 
   input [2:0] nou_1_test_expr; 
   input [2:0] qst_1_state_expr; input qst_1_sample_event;  
   input [2:0] trn_1_test_expr; 
   input chg_1_start_event; input [7:0] chg_1_test_expr; 
   input chg_2_start_event; input [7:0] chg_2_test_expr; 
   input chg_3_start_event; input [7:0] chg_3_test_expr; 
   input [2:0] csq_1_event_sequence;
   input [2:0] csq_2_event_sequence;
   input [2:0] csq_3_event_sequence;
   input frm_1_start_event; input frm_1_test_expr; 
   input frm_2_start_event; input frm_2_test_expr; 
   input frm_3_start_event; input frm_3_test_expr; 
   input frm_4_start_event; input frm_4_test_expr; 
   input frm_5_start_event; input frm_5_test_expr; 
   input hnd_1_req; input hnd_1_ack; 
   input hnd_1_req_clk; input hnd_1_ack_clk; 
   input nxt_1_start_event; input nxt_1_test_expr; 
   input nxt_2_start_event; input nxt_2_test_expr; 
   input nxt_3_start_event; input nxt_3_test_expr; 
   input tim_1_start_event; input tim_1_test_expr; 
   input tim_2_start_event; input tim_2_test_expr; 
   input tim_3_start_event; input tim_3_test_expr; 
   input unc_1_start_event; input [7:0] unc_1_test_expr; 
   input unc_2_start_event; input [7:0] unc_2_test_expr; 
   input unc_3_start_event; input [7:0] unc_3_test_expr; 
   input wid_1_test_expr; 
   input wid_2_test_expr; 
   input wid_3_test_expr; 
   input wid_4_test_expr; 
   input wch_1_start_event; input wch_1_end_event; input [7:0] wch_1_test_expr; 
   input win_1_start_event; input win_1_end_event; input win_1_test_expr;
   input wuc_1_start_event; input wuc_1_end_event; input [7:0] wuc_1_test_expr; 
     // Counter counts half period
  always @(posedge clk or posedge reset_n)
  begin
    if(!reset_n)
      out <= 0;
    else
      out <= dlt_1_test_expr +  wid_1_test_expr + wch_1_test_expr + nua_1_test_expr; 
  end
endmodule // assert_every_config

