//----------------------------------------------------------------------------
// Accellera Copyright (c) 2006-2007. All rights reserved.
//----------------------------------------------------------------------------

//----------------------------------------------------------------------------
// CONTENTS (last updated: Wed Jul 11 15:02:30 BST 2007)
// ========
//  59.  Formal Verification Testbench: tb_assert_formal_fail
// 144.    - ToDo List
// 151.    - Clock & Reset
// 157.  
// 158.  Test Logic
// 162.    1) Dummy Logic (so testbench isn't empty)
// 169.    2) OVL Tests (just driven by testbench inputs)
// 175.         - assert_always
// 183.         - assert_always_on_edge
// 191.         - assert_change
// 198.         - assert_cycle_sequence
// 205.         - assert_decrement
// 211.         - assert_delta
// 216.         - assert_even_parity
// 221.         - assert_fifo_index
// 226.         - assert_frame
// 235.         - assert_handshake
// 240.         - assert_implication
// 245.         - assert_increment
// 251.         - assert_never
// 258.         - assert_never_unknown
// 263.         - assert_never_unknown_async
// 268.         - assert_next
// 275.         - assert_no_overflow
// 280.         - assert_no_transition
// 285.         - assert_no_underflow
// 290.         - assert_odd_parity
// 295.         - assert_one_cold
// 302.         - assert_one_hot
// 307.         - assert_proposition
// 312.         - assert_range
// 317.         - assert_quiescent_state
// 322.         - assert_time
// 329.         - assert_transition
// 334.         - assert_unchange
// 341.         - assert_width
// 349.         - assert_win_change
// 354.         - assert_window
// 359.         - assert_win_unchange
// 364.         - assert_zero_one_hot
// 370.  
// 371.  DUT: assert_every_config
//----------------------------------------------------------------------------


`include "std_ovl_defines.h"

`timescale 1ns / 1ns


//----------------------------------------------------------------------------
// INDEX: Formal Verification Testbench: tb_assert_formal_fail
// =====
// This is a module to drive all 33 assert_ OVLs in the DUT with invalid input
// sequences, which a Formal Property Checker can fail from reset. OVLs are
// simply driven by primary inputs to the testbench.
//
// Expect all OVL assertions to fail from reset (within very few cycles).
//----------------------------------------------------------------------------
module tb_assert_formal_fail
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


   // INDEX:   - ToDo List
   // =====
   // 1) Consider multiple tests for onehot0, to check both zero and onehot.
   //    Might need multiple instances in DUT, to have a constant-zero check.
   // 2) Like (1), but for onecold+all_ones and onecold+all_zero


   // INDEX:   - Clock & Reset
   // =====
   input clk, reset_n;


   // ----------------------------------------------------------------------
   // INDEX: 
   // INDEX: Test Logic
   // ----------------------------------------------------------------------


   // INDEX:   1) Dummy Logic (so testbench isn't empty)
   // =====
   reg dummy_dff;
   always @ (posedge clk)
     dummy_dff <= 1'b0;


   // INDEX:   2) OVL Tests (just driven by testbench inputs)
   // =====
   // All OVL ports are driven by primary inputs to the testbench, allowing
   // a Formal Property Checker to chose any input sequence to fail the OVL.


   // INDEX:        - assert_always
   // =====
   input alw_1_test_expr;
   input alw_2_test_expr;
   input alw_3_test_expr;
   input alw_4_test_expr;


   // INDEX:        - assert_always_on_edge
   // =====
   input aoe_1_sampling_event; input aoe_1_test_expr;
   input aoe_2_sampling_event; input aoe_2_test_expr;
   input aoe_3_sampling_event; input aoe_3_test_expr;
   input aoe_4_sampling_event; input aoe_4_test_expr;


   // INDEX:        - assert_change
   // =====
   input chg_1_start_event; input [7:0] chg_1_test_expr;
   input chg_2_start_event; input [7:0] chg_2_test_expr;
   input chg_3_start_event; input [7:0] chg_3_test_expr;


   // INDEX:        - assert_cycle_sequence
   // =====
   input [2:0] csq_1_event_sequence;
   input [2:0] csq_2_event_sequence;
   input [2:0] csq_3_event_sequence;


   // INDEX:        - assert_decrement
   // =====
   input [3:0] dec_1_test_expr;
   input [3:0] dec_2_test_expr;


   // INDEX:        - assert_delta
   // =====
   input [3:0] dlt_1_test_expr;


   // INDEX:        - assert_even_parity
   // =====
   input [7:0] evp_1_test_expr;


   // INDEX:        - assert_fifo_index
   // =====
   input fix_1_push; input fix_1_pop;


   // INDEX:        - assert_frame
   // =====
   input frm_1_start_event; input frm_1_test_expr;
   input frm_2_start_event; input frm_2_test_expr;
   input frm_3_start_event; input frm_3_test_expr;
   input frm_4_start_event; input frm_4_test_expr;
   input frm_5_start_event; input frm_5_test_expr;


   // INDEX:        - assert_handshake
   // =====
   input hnd_1_req; input hnd_1_ack;


   // INDEX:        - assert_implication
   // =====
   input imp_1_antecedent_expr; input imp_1_consequent_expr;


   // INDEX:        - assert_increment
   // =====
   input [3:0] inc_1_test_expr;
   input [3:0] inc_2_test_expr;


   // INDEX:        - assert_never
   // =====
   input nvr_1_test_expr;
   input nvr_2_test_expr;
   input nvr_3_test_expr;


   // INDEX:        - assert_never_unknown
   // =====
   input nun_1_qualifier; input [1:0] nun_1_test_expr;


   // INDEX:        - assert_never_unknown_async
   // =====
   input [1:0] nua_1_test_expr;


   // INDEX:        - assert_next
   // =====
   input nxt_1_start_event; input nxt_1_test_expr;
   input nxt_2_start_event; input nxt_2_test_expr;
   input nxt_3_start_event; input nxt_3_test_expr;


   // INDEX:        - assert_no_overflow
   // =====
   input [2:0] noo_1_test_expr;


   // INDEX:        - assert_no_transition
   // =====
   input [2:0] not_1_test_expr;


   // INDEX:        - assert_no_underflow
   // =====
   input [2:0] nou_1_test_expr;


   // INDEX:        - assert_odd_parity
   // =====
   input [7:0] odp_1_test_expr;


   // INDEX:        - assert_one_cold
   // =====
   input [7:0] ocd_1_test_expr;
   input [7:0] ocd_2_test_expr;
   input [7:0] ocd_3_test_expr;


   // INDEX:        - assert_one_hot
   // =====
   input [7:0] oht_1_test_expr;


   // INDEX:        - assert_proposition
   // =====
   input prp_1_test_expr;


   // INDEX:        - assert_range
   // =====
   input [2:0] rng_1_test_expr;


   // INDEX:        - assert_quiescent_state
   // =====
   input [2:0] qst_1_state_expr; input qst_1_sample_event;


   // INDEX:        - assert_time
   // =====
   input tim_1_start_event; input tim_1_test_expr;
   input tim_2_start_event; input tim_2_test_expr;
   input tim_3_start_event; input tim_3_test_expr;


   // INDEX:        - assert_transition
   // =====
   input [2:0] trn_1_test_expr;


   // INDEX:        - assert_unchange
   // =====
   input unc_1_start_event; input [7:0] unc_1_test_expr;
   input unc_2_start_event; input [7:0] unc_2_test_expr;
   input unc_3_start_event; input [7:0] unc_3_test_expr;


   // INDEX:        - assert_width
   // =====
   input wid_1_test_expr;
   input wid_2_test_expr;
   input wid_3_test_expr;
   input wid_4_test_expr;


   // INDEX:        - assert_win_change
   // =====
   input wch_1_start_event; input wch_1_end_event; input [7:0] wch_1_test_expr;


   // INDEX:        - assert_window
   // =====
   input win_1_start_event; input win_1_end_event; input win_1_test_expr;


   // INDEX:        - assert_win_unchange
   // =====
   input wuc_1_start_event; input wuc_1_end_event; input [7:0] wuc_1_test_expr;


   // INDEX:        - assert_zero_one_hot
   // =====
   input [7:0] zoh_1_test_expr;


   // ----------------------------------------------------------------------
   // INDEX: 
   // INDEX: DUT: assert_every_config
   // ----------------------------------------------------------------------
   assert_every_config DUT
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

endmodule // tb_assert_formal_fail

