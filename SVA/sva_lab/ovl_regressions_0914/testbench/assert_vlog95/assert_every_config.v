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

`include "std_ovl_defines.h"
//`include "sva_checker_defines.h"

module assert_every_config
  (clk, reset_n,

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

   input clk, reset_n;


   //-------------------------------------------------------------------------
   // INDEX:
   // INDEX: Combinatorial OVLs
   //-------------------------------------------------------------------------


   // INDEX:   - assert_never_unknown_async  1 config
   // =====
   input [1:0] nua_1_test_expr;
`ifdef TEST_NUA
   assert_never_unknown_async #(`OVL_ERROR, 2, `OVL_ASSERT, "nua_1_test_expr should never be X or Z")
   u_nua_1
     (.reset_n   (reset_n),
      .test_expr (nua_1_test_expr)
      );
`endif

   // INDEX:   - assert_proposition          1 config
   // =====
   input prp_1_test_expr;
`ifdef TEST_PRP
   assert_proposition #(`OVL_ERROR, `OVL_ASSERT, "prp_1_test_expr should be high")
   u_prp_1
     (.reset_n   (reset_n),
      .test_expr (prp_1_test_expr)
      );
`endif

   
   //-------------------------------------------------------------------------
   // INDEX:
   // INDEX: Single-Cycle OVLs
   //-------------------------------------------------------------------------

   
   // INDEX:   - assert_always               4 configs (to test property_type) *REVISIT*: add OVL_ASSUME_2STATE
   // =====
   // OVL_ASSUME will fail in Verilog OVL, but no failure for SVA OVL
   // due to the SV semantics of assume.
   //
   input alw_1_test_expr;
`ifdef TEST_ALW
   assert_always #(`OVL_ERROR, `OVL_ASSERT, "alw_1_test_expr should be permanently high")
   u_alw_1
     (.clk       (clk),
      .reset_n   (reset_n),
      .test_expr (alw_1_test_expr)
      );
`endif
   //
   input alw_2_test_expr;
`ifdef TEST_ALW
   assert_always #(`OVL_ERROR, `OVL_ASSUME, "alw_2_test_expr should be permanently high")
   u_alw_2
     (.clk       (clk),
      .reset_n   (reset_n),
      .test_expr (alw_2_test_expr)
      );
`endif
   //
   input alw_3_test_expr;
`ifdef TEST_ALW
   assert_always #(`OVL_ERROR, `OVL_IGNORE, "alw_3_test_expr should be permanently high")
   u_alw_3
     (.clk       (clk),
      .reset_n   (reset_n),
      .test_expr (alw_3_test_expr)
      );
`endif
   //
   input alw_4_test_expr;
`ifdef TEST_ALW
   assert_always #(`OVL_ERROR, `OVL_ASSERT_2STATE, "alw_4_test_expr should be permanently high")
   u_alw_4
     (.clk       (clk),
      .reset_n   (reset_n),
      .test_expr (alw_4_test_expr)
      );
`endif

   
   // INDEX:   - assert_even_parity          1 config
   // =====
   input [7:0] evp_1_test_expr;
`ifdef TEST_EVP
   assert_even_parity #(`OVL_ERROR, 8, `OVL_ASSERT, "evp_1_test_expr should have an even number of bits asserted")
   u_evp_1
     (.clk       (clk),
      .reset_n   (reset_n),
      .test_expr (evp_1_test_expr)
      );
`endif

   
   // INDEX:   - assert_implication          1 config
   // =====
   input imp_1_antecedent_expr; input imp_1_consequent_expr;
`ifdef TEST_IMP
   assert_implication #(`OVL_ERROR, `OVL_ASSERT, "imp_1_consequent_expr should be high when imp_1_antecedent_expr is high")
   u_imp_1
     (.clk             (clk),
      .reset_n         (reset_n),
      .antecedent_expr (imp_1_antecedent_expr),
      .consequent_expr (imp_1_consequent_expr)
      );
`endif


   // INDEX:   - assert_never                3 configs (to test severity_level)
   // =====
   input nvr_1_test_expr;
`ifdef TEST_NVR
   assert_never #(`OVL_FATAL, `OVL_ASSERT, "nvr_1_test_expr should be permanently low")
   u_nvr_1
     (.clk       (clk),
      .reset_n   (reset_n),
      .test_expr (nvr_1_test_expr)
      );
`endif
   //
   // OVL_ERROR used everywhere else, so not tested here
   //
   input nvr_2_test_expr;
`ifdef TEST_NVR
   assert_never #(`OVL_WARNING, `OVL_ASSERT, "nvr_2_test_expr should be permanently low")
   u_nvr_2
     (.clk       (clk),
      .reset_n   (reset_n),
      .test_expr (nvr_2_test_expr)
      );
`endif
   //
   input nvr_3_test_expr;
`ifdef TEST_NVR
   assert_never #(`OVL_INFO, `OVL_ASSERT, "nvr_3_test_expr should be permanently low")
   u_nvr_3
     (.clk       (clk),
      .reset_n   (reset_n),
      .test_expr (nvr_3_test_expr)
      );
`endif


   // INDEX:   - assert_never_unknown        1 config
   // =====
   input nun_1_qualifier; input [1:0] nun_1_test_expr;
`ifdef TEST_NUN
   assert_never_unknown #(`OVL_ERROR, 2, `OVL_ASSERT, "nun_1_test_expr should never be X or Z")
   u_nun_1
     (.clk       (clk),
      .reset_n   (reset_n),
      .qualifier (nun_1_qualifier),
      .test_expr (nun_1_test_expr)
      );
`endif

   
   // INDEX:   - assert_odd_parity           1 config
   // =====
   input [7:0] odp_1_test_expr;
`ifdef TEST_ODP
   assert_odd_parity #(`OVL_ERROR, 8, `OVL_ASSERT, "odp_1_test_expr should have an odd number of bits asserted")
   u_odp_1
     (.clk       (clk),
      .reset_n   (reset_n),
      .test_expr (odp_1_test_expr)
      );
`endif

   
   // INDEX:   - assert_one_cold             3 configs (one_cold, one_cold/zero, one_cold/max)
   // =====
   input [7:0] ocd_1_test_expr;
`ifdef TEST_OCD
   assert_one_cold #(`OVL_ERROR, 8, `OVL_ONE_COLD, `OVL_ASSERT, "ocd_1_test_expr should be onecold")
   u_ocd_1
     (.clk       (clk),
      .reset_n   (reset_n),
      .test_expr (ocd_1_test_expr)
      );
`endif
   //
   input [7:0] ocd_2_test_expr;
`ifdef TEST_OCD
   assert_one_cold #(`OVL_ERROR, 8, `OVL_ALL_ZEROS, `OVL_ASSERT, "ocd_2_test_expr should be onecold or zero")
   u_ocd_2
     (.clk       (clk),
      .reset_n   (reset_n),
      .test_expr (ocd_2_test_expr)
      );
`endif
   //
   input [7:0] ocd_3_test_expr;
`ifdef TEST_OCD
   assert_one_cold #(`OVL_ERROR, 8, `OVL_ALL_ONES, `OVL_ASSERT, "ocd_3_test_expr should be onecold or all-ones")
   u_ocd_3
     (.clk       (clk),
      .reset_n   (reset_n),
      .test_expr (ocd_3_test_expr)
      );
`endif

   
   // INDEX:   - assert_one_hot              1 config
   // =====
   input [7:0] oht_1_test_expr;
`ifdef TEST_OHT
   assert_one_hot #(`OVL_ERROR, 8, `OVL_ASSERT, "oht_1_test_expr should be onehot")
   u_oht_1
     (.clk       (clk),
      .reset_n   (reset_n),
      .test_expr (oht_1_test_expr)
      );
`endif

   
   // INDEX:   - assert_range                1 config
   // =====
   input [2:0] rng_1_test_expr;
`ifdef TEST_RNG
   assert_range #(`OVL_ERROR, 3, 1, 6, `OVL_ASSERT, "rng_1_test_expr should be between 1 and 6")
   u_rng_1
     (.clk       (clk),
      .reset_n   (reset_n),
      .test_expr (rng_1_test_expr)
      );
`endif

   
   // INDEX:   - assert_zero_one_hot         1 config
   // =====
   input [7:0] zoh_1_test_expr;
`ifdef TEST_ZOH
   assert_zero_one_hot #(`OVL_ERROR, 8, `OVL_ASSERT, "zoh_1_test_expr should be onehot or zero")
   u_zoh_1
     (.clk       (clk),
      .reset_n   (reset_n),
      .test_expr (zoh_1_test_expr)
      );
`endif


   //-------------------------------------------------------------------------
   // INDEX:
   // INDEX: 2-Cycle OVLs
   //-------------------------------------------------------------------------

 
   // INDEX:   - assert_always_on_edge       4 configs (to test edge_type)
   // =====
   input aoe_1_sampling_event; input aoe_1_test_expr; 
`ifdef TEST_AOE
   assert_always_on_edge #(`OVL_ERROR, `OVL_NOEDGE, `OVL_ASSERT, "aoe_1_test_expr should be permanently high")
   u_aoe_1
     (.clk            (clk),
      .reset_n        (reset_n),
      .sampling_event (aoe_1_sampling_event), // Should be ignored for OVL_NOEDGE
      .test_expr      (aoe_1_test_expr)
      );
`endif
   //
   input aoe_2_sampling_event; input aoe_2_test_expr; 
`ifdef TEST_AOE
   assert_always_on_edge #(`OVL_ERROR, `OVL_POSEDGE, `OVL_ASSERT, "aoe_2_test_expr should be high on posedge")
   u_aoe_2
     (.clk            (clk),
      .reset_n        (reset_n),
      .sampling_event (aoe_2_sampling_event),
      .test_expr      (aoe_2_test_expr)
      );
`endif
   //
   input aoe_3_sampling_event; input aoe_3_test_expr; 
`ifdef TEST_AOE
   assert_always_on_edge #(`OVL_ERROR, `OVL_NEGEDGE, `OVL_ASSERT, "aoe_3_test_expr should be high on negedge")
   u_aoe_3
     (.clk            (clk),
      .reset_n        (reset_n),
      .sampling_event (aoe_3_sampling_event),
      .test_expr      (aoe_3_test_expr)
      );
`endif
   //
   input aoe_4_sampling_event; input aoe_4_test_expr;
`ifdef TEST_AOE
   assert_always_on_edge #(`OVL_ERROR, `OVL_ANYEDGE, `OVL_ASSERT, "aoe_4_test_expr should be high on any edge")
   u_aoe_4
     (.clk            (clk),
      .reset_n        (reset_n),
      .sampling_event (aoe_4_sampling_event),
      .test_expr      (aoe_4_test_expr)
      );
`endif

 
   // INDEX:   - assert_decrement            2 configs (dec-by-1 & dec-by-2)     
   // =====
   input [3:0] dec_1_test_expr; 
`ifdef TEST_DEC
   assert_decrement #(`OVL_ERROR, 4, 1, `OVL_ASSERT, "dec_1_test_expr should decrement by 1")
   u_dec_1
     (.clk            (clk),
      .reset_n        (reset_n),
      .test_expr      (dec_1_test_expr)
      );
`endif
   //
   input [3:0] dec_2_test_expr; 
`ifdef TEST_DEC
   assert_decrement #(`OVL_ERROR, 4, 2, `OVL_ASSERT, "dec_2_test_expr should decrement by 2")
   u_dec_2
     (.clk            (clk),
      .reset_n        (reset_n),
      .test_expr      (dec_2_test_expr)
      );
`endif

 
   // INDEX:   - assert_delta                1 config
   // =====
   input [3:0] dlt_1_test_expr; 
`ifdef TEST_DLT
   assert_delta #(`OVL_ERROR, 4, 2,4, `OVL_ASSERT, "dlt_1_test_expr should change by 2 to 4")
   u_dlt_1
     (.clk            (clk),
      .reset_n        (reset_n),
      .test_expr      (dlt_1_test_expr)
      );
`endif

 
   // INDEX:   - assert_fifo_index           1 config
   // =====
   input fix_1_push; input fix_1_pop; 
`ifdef TEST_FIX
   assert_fifo_index #(`OVL_ERROR, 4, 1,1, `OVL_ASSERT, "fix_1_test_expr should never underflow or overflow")
   u_fix_1
     (.clk     (clk),
      .reset_n (reset_n),
      .push     (fix_1_push),
      .pop      (fix_1_pop)
      );
`endif

 
   // INDEX:   - assert_increment            2 configs (inc-by-1 & inc-by-2)     
   // =====
   input [3:0] inc_1_test_expr; 
`ifdef TEST_INC
   assert_increment #(`OVL_ERROR, 4, 1, `OVL_ASSERT, "inc_1_test_expr should increment by 1")
   u_inc_1
     (.clk            (clk),
      .reset_n        (reset_n),
      .test_expr      (inc_1_test_expr)
      );
`endif
   //
   input [3:0] inc_2_test_expr; 
`ifdef TEST_INC
   assert_increment #(`OVL_ERROR, 4, 2, `OVL_ASSERT, "inc_2_test_expr should increment by 2")
   u_inc_2
     (.clk            (clk),
      .reset_n        (reset_n),
      .test_expr      (inc_2_test_expr)
      );
`endif

 
   // INDEX:   - assert_no_overflow          1 config
   // =====
   input [2:0] noo_1_test_expr; 
`ifdef TEST_NOO
   assert_no_overflow#(`OVL_ERROR, 3, 0,6, `OVL_ASSERT, "noo_1_test_expr should not overflow")
   u_noo_1
     (.clk            (clk),
      .reset_n        (reset_n),
      .test_expr      (noo_1_test_expr)
      );
`endif

 
   // INDEX:   - assert_no_transition        1 config
   // =====
   input [2:0] not_1_test_expr; 
`ifdef TEST_NOT
   assert_no_transition #(`OVL_ERROR, 3, `OVL_ASSERT, "not_1_test_expr should not change from start_state to next_state")
   u_not_1
     (.clk            (clk),
      .reset_n        (reset_n),
      .test_expr      (not_1_test_expr),
      .start_state    (3'b100),
      .next_state     (3'b101)
      );
`endif

 
   // INDEX:   - assert_no_underflow         1 config
   // =====
   input [2:0] nou_1_test_expr; 
`ifdef TEST_NOU
   assert_no_underflow#(`OVL_ERROR, 3, 1,7, `OVL_ASSERT, "nou_1_test_expr should not underflow")
   u_nou_1
     (.clk            (clk),
      .reset_n        (reset_n),
      .test_expr      (nou_1_test_expr)
      );
`endif

 
   // INDEX:   - assert_quiescent_state      1 config *REVISIT*: add EOS config
   // =====
   input [2:0] qst_1_state_expr; input qst_1_sample_event;  
`ifdef TEST_QST
   assert_quiescent_state #(`OVL_ERROR, 3, `OVL_ASSERT, "qst_1_state_expr should equal check_value on a rising-edge of sample_event")
   u_qst_1
     (.clk            (clk),
      .reset_n        (reset_n),
      .state_expr     (qst_1_state_expr),
      .check_value    (3'b100),
      .sample_event   (qst_1_sample_event)
      );
`endif

 
   // INDEX:   - assert_transition           1 config
   // =====
   input [2:0] trn_1_test_expr; 
`ifdef TEST_TRN
   assert_transition #(`OVL_ERROR, 3, `OVL_ASSERT, "trn_1_test_expr should change from start_state to next_state")
   u_trn_1
     (.clk            (clk),
      .reset_n        (reset_n),
      .test_expr      (trn_1_test_expr),
      .start_state    (3'b100),
      .next_state     (3'b101)
      );
`endif

   
   //-------------------------------------------------------------------------
   // INDEX:
   // INDEX: n-Cycle OVLs
   //-------------------------------------------------------------------------

 
   // INDEX:   - assert_change               3 configs
   // =====
   input chg_1_start_event; input [7:0] chg_1_test_expr; 
`ifdef TEST_CHG
   assert_change #(`OVL_ERROR, 8, 4, `OVL_IGNORE_NEW_START, `OVL_ASSERT, "chg_1_test_expr should change within num_cks of start_event")
   u_chg_1
     (.clk         (clk),
      .reset_n     (reset_n),
      .start_event (chg_1_start_event),
      .test_expr   (chg_1_test_expr)
      );
`endif
   //
   input chg_2_start_event; input [7:0] chg_2_test_expr; 
`ifdef TEST_CHG
   assert_change #(`OVL_ERROR, 8, 4, `OVL_RESET_ON_NEW_START, `OVL_ASSERT, "chg_2_test_expr should change within num_cks of start_event")
   u_chg_2
     (.clk         (clk),
      .reset_n     (reset_n),
      .start_event (chg_2_start_event),
      .test_expr   (chg_2_test_expr)
      );
`endif
   //
   input chg_3_start_event; input [7:0] chg_3_test_expr; 
`ifdef TEST_CHG
   assert_change #(`OVL_ERROR, 8, 4, `OVL_ERROR_ON_NEW_START, `OVL_ASSERT, "chg_3_test_expr should change within num_cks of start_event")
   u_chg_3
     (.clk         (clk),
      .reset_n     (reset_n),
      .start_event (chg_3_start_event),
      .test_expr   (chg_3_test_expr)
      );
`endif

 
   // INDEX:   - assert_cycle_sequence       3 configs
   // =====
   input [2:0] csq_1_event_sequence;
`ifdef TEST_CSQ
   assert_cycle_sequence #(`OVL_ERROR, 3, `OVL_TRIGGER_ON_MOST_PIPE, `OVL_ASSERT, "csq_1_event_sequence[0] should be high at end of sequence")
   u_csq_1
     (.clk            (clk),
      .reset_n        (reset_n),
      .event_sequence (csq_1_event_sequence)
      );
`endif
   //
   input [2:0] csq_2_event_sequence;
`ifdef TEST_CSQ
   assert_cycle_sequence #(`OVL_ERROR, 3, `OVL_TRIGGER_ON_FIRST_PIPE, `OVL_ASSERT, "csq_2_event_sequence[1:0] should be high at end of sequence")
   u_csq_2
     (.clk            (clk),
      .reset_n        (reset_n),
      .event_sequence (csq_2_event_sequence)
      );
`endif
   //
   input [2:0] csq_3_event_sequence;
`ifdef TEST_CSQ
   assert_cycle_sequence #(`OVL_ERROR, 3, `OVL_TRIGGER_ON_FIRST_NOPIPE, `OVL_ASSERT, "csq_3_event_sequence[1:0] should be high at end of sequence (non-pipelined)")
   u_csq_3
     (.clk            (clk),
      .reset_n        (reset_n),
      .event_sequence (csq_3_event_sequence)
      );
`endif


   // INDEX:   - assert_frame                5 configs
   // =====
   input frm_1_start_event; input frm_1_test_expr; 
`ifdef TEST_FRM
   assert_frame #(`OVL_ERROR, 3,0, `OVL_IGNORE_NEW_START, `OVL_ASSERT, "frm_1_test_expr must not hold before 3 cycles after frm_1_start_event (max_cks=0)")
   u_frm_1
     (.clk         (clk),
      .reset_n     (reset_n),
      .start_event (frm_1_start_event),
      .test_expr   (frm_1_test_expr)
      );
`endif
   //
   input frm_2_start_event; input frm_2_test_expr; 
`ifdef TEST_FRM
   assert_frame #(`OVL_ERROR, 0,7, `OVL_IGNORE_NEW_START, `OVL_ASSERT, "frm_2_test_expr must hold within 7 cycles after frm_2_start_event (min_cks=0)")
   u_frm_2
     (.clk         (clk),
      .reset_n     (reset_n),
      .start_event (frm_2_start_event),
      .test_expr   (frm_2_test_expr)
      );
`endif
   //
   input frm_3_start_event; input frm_3_test_expr; 
`ifdef TEST_FRM
   assert_frame #(`OVL_ERROR, 3,7, `OVL_IGNORE_NEW_START, `OVL_ASSERT, "frm_3_test_expr must not hold before 3 cycles but must hold within 7 cycles after frm_3_start_event (ignore new start)")
   u_frm_3
     (.clk         (clk),
      .reset_n     (reset_n),
      .start_event (frm_3_start_event),
      .test_expr   (frm_3_test_expr)
      );
`endif
   //
   input frm_4_start_event; input frm_4_test_expr; 
`ifdef TEST_FRM
   assert_frame #(`OVL_ERROR, 3,7, `OVL_RESET_ON_NEW_START, `OVL_ASSERT, "frm_4_test_expr must not hold before 3 cycles but must hold within 7 cycles after frm_4_start_event (reset on new start)")
   u_frm_4
     (.clk         (clk),
      .reset_n     (reset_n),
      .start_event (frm_4_start_event),
      .test_expr   (frm_4_test_expr)
      );
`endif
   //
   input frm_5_start_event; input frm_5_test_expr; 
`ifdef TEST_FRM
   assert_frame #(`OVL_ERROR, 3,7, `OVL_ERROR_ON_NEW_START, `OVL_ASSERT, "frm_5_test_expr must not hold before 3 cycles but must hold within 7 cycles after frm_5_start_event (error on new start)")
   u_frm_5
     (.clk         (clk),
      .reset_n     (reset_n),
      .start_event (frm_5_start_event),
      .test_expr   (frm_5_test_expr)
      );
`endif


   // INDEX:   - assert_handshake            1 config (same as timing diagram) *REVISIT*: add more configs
   // =====
   input hnd_1_req; input hnd_1_ack; 
`ifdef TEST_HND
   assert_handshake #(`OVL_ERROR, 0,3, 1,1,1, `OVL_ASSERT, "hnd_1_req/ack should obey protocol")
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
   assert_next #(`OVL_ERROR, 1,1,0, `OVL_ASSERT, "nxt_1_test_expr should occur num_cks after start_event")
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
   assert_next #(`OVL_ERROR, 2,0,0, `OVL_ASSERT, "nxt_2_test_expr should occur num_cks after start_event")
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
   assert_next #(`OVL_ERROR, 2,1,1, `OVL_ASSERT, "nxt_3_test_expr should occur num_cks after start_event")
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
   assert_time #(`OVL_ERROR, 5, `OVL_IGNORE_NEW_START, `OVL_ASSERT, "tim_1_test_expr must hold for 5 cycles after tim_1_start_event (ignore new start)")
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
   assert_time #(`OVL_ERROR, 5, `OVL_RESET_ON_NEW_START, `OVL_ASSERT, "tim_2_test_expr must hold for 5 cycles after tim_2_start_event (reset on new start)")
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
   assert_time #(`OVL_ERROR, 5, `OVL_ERROR_ON_NEW_START, `OVL_ASSERT, "tim_3_test_expr must hold for 5 cycles after tim_3_start_event (error on new start)")
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
   assert_unchange #(`OVL_ERROR, 8, 4, `OVL_IGNORE_NEW_START, `OVL_ASSERT, "unc_1_test_expr should be stable during num_cks of start_event")
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
   assert_unchange #(`OVL_ERROR, 8, 4, `OVL_RESET_ON_NEW_START, `OVL_ASSERT, "unc_2_test_expr should be stable during num_cks of start_event")
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
   assert_unchange #(`OVL_ERROR, 8, 4, `OVL_ERROR_ON_NEW_START, `OVL_ASSERT, "unc_3_test_expr should be stable during num_cks of start_event")
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
   assert_width #(`OVL_ERROR, 4,0, `OVL_ASSERT, "wid_1_test_expr should hold between min and max cycles")
   u_wid_1
     (.clk         (clk),
      .reset_n     (reset_n),
      .test_expr   (wid_1_test_expr)
      );
`endif
   //
   input wid_2_test_expr; 
`ifdef TEST_WID
   assert_width #(`OVL_ERROR, 0,6, `OVL_ASSERT, "wid_2_test_expr should hold between min and max cycles")
   u_wid_2
     (.clk         (clk),
      .reset_n     (reset_n),
      .test_expr   (wid_2_test_expr)
      );
`endif
   //
   input wid_3_test_expr; 
`ifdef TEST_WID
   assert_width #(`OVL_ERROR, 4,4, `OVL_ASSERT, "wid_3_test_expr should hold between min and max cycles")
   u_wid_3
     (.clk         (clk),
      .reset_n     (reset_n),
      .test_expr   (wid_3_test_expr)
      );
`endif
   //
   input wid_4_test_expr; 
`ifdef TEST_WID
   assert_width #(`OVL_ERROR, 4,6, `OVL_ASSERT, "wid_4_test_expr should hold between min and max cycles")
   u_wid_4
     (.clk         (clk),
      .reset_n     (reset_n),
      .test_expr   (wid_4_test_expr)
      );
`endif


   //-------------------------------------------------------------------------
   // INDEX:
   // INDEX: Event-Bound OVLs
   //-------------------------------------------------------------------------

 
   // INDEX:   - assert_win_change           1 config
   // =====
   input wch_1_start_event; input wch_1_end_event; input [7:0] wch_1_test_expr; 
`ifdef TEST_WCH
   assert_win_change #(`OVL_ERROR, 8, `OVL_ASSERT, "wch_1_test_expr should change between start_event & end_event")
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
   assert_window #(`OVL_ERROR, `OVL_ASSERT, "win_1_test_expr should hold between start_event & end_event")
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
   assert_win_unchange #(`OVL_ERROR, 8, `OVL_ASSERT, "wuc_1_test_expr should be stable between start_event & end_event")
   u_wuc_1
     (.clk         (clk),
      .reset_n     (reset_n),
      .start_event (wuc_1_start_event),
      .end_event   (wuc_1_end_event),
      .test_expr   (wuc_1_test_expr)
      );
`endif

endmodule // assert_every_config

