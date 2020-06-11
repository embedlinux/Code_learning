//----------------------------------------------------------------------------
// Accellera Copyright (c) 2007. All rights reserved.
//----------------------------------------------------------------------------

//----------------------------------------------------------------------------
// CONTENTS (last updated: Sun Sep 16 17:09:33 BST 2007)
// ========
//  59.  Formal Verification Testbench: tb_assert_formal_pass
//  70.    - ToDo List
//  77.    - Clock & Reset
//  83.  
//  84.  Test Logic
//  88.    1) Simple counters
// 119.    2) OVL Tests
// 125.         - assert_always
// 137.         - assert_always_on_edge
// 157.         - assert_change
// 173.         - assert_cycle_sequence
// 194.         - assert_decrement
// 203.         - assert_delta
// 210.         - assert_even_parity
// 217.         - assert_fifo_index
// 225.         - assert_frame
// 249.         - assert_handshake
// 257.         - assert_implication
// 265.         - assert_increment
// 274.         - assert_never
// 285.         - assert_never_unknown       (ignored by Formal)
// 293.         - assert_never_unknown_async (ignored by Formal)
// 300.         - assert_next
// 316.         - assert_no_overflow
// 324.         - assert_no_transition
// 331.         - assert_no_underflow
// 339.         - assert_odd_parity
// 346.         - assert_one_cold
// 357.         - assert_one_hot
// 364.         - assert_proposition
// 371.         - assert_range
// 381.         - assert_quiescent_state
// 389.         - assert_time
// 405.         - assert_transition
// 412.         - assert_unchange
// 428.         - assert_width
// 441.         - assert_win_change
// 450.         - assert_window
// 459.         - assert_win_unchange
// 468.         - assert_zero_one_hot
// 476.  
// 477.  DUT: assert_every_config
//----------------------------------------------------------------------------


`include "std_ovl_defines.h"

`timescale 1ns / 1ns


//----------------------------------------------------------------------------
// INDEX: Formal Verification Testbench: tb_assert_formal_pass
// =====
// This is a module to drive all 33 assert_ OVLs in the DUT with valid input
// sequences that Formal Property Checker can exhaustively prove. Tests are
// based on three simple counters.
//
// Expect all OVL assertions to be exhaustively proven.
//----------------------------------------------------------------------------
module tb_assert_formal_pass (clk, reset_n, alw_2_test_expr);


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


    // INDEX:   1) Simple counters
    // =====
    reg [7:0] free_ctr;
    reg [7:0] safe_ctr;
    reg [7:0] hot_ctr;
    always @ (posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            free_ctr <= 8'b00000000;
            safe_ctr <= 8'b00000001;
            hot_ctr  <= 8'b00000001;
        end else begin
            // Free counter counts forever, rolling over at max
            free_ctr <= free_ctr + 8'h01;

            // Safe counter stops at 8'hFF
            if (safe_ctr != 8'hFF) begin
                safe_ctr <= safe_ctr + 8'h01;
            end else begin
                safe_ctr <= safe_ctr;
            end

            // Hot counter has rotating 1 that visits each bit
            if (hot_ctr[7] == 1'b0) begin 
                hot_ctr <= hot_ctr << 1;
            end else begin
                hot_ctr <= 8'b00000001;
            end
        end
    end


    // INDEX:   2) OVL Tests
    // =====
    // Now give assignments to the submodule inputs that will cause all
    // asserts to pass.


    // INDEX:        - assert_always
    // =====
    wire  alw_1_test_expr;
    input alw_2_test_expr; // Input, which should be forced high by OVL_ASSUME
    wire  alw_3_test_expr;
    wire  alw_4_test_expr;
    //
    assign alw_1_test_expr = alw_2_test_expr;
    assign alw_3_test_expr = alw_2_test_expr;
    assign alw_4_test_expr = alw_2_test_expr;


    // INDEX:        - assert_always_on_edge
    // =====
    wire aoe_1_sampling_event; wire aoe_1_test_expr;
    wire aoe_2_sampling_event; wire aoe_2_test_expr;
    wire aoe_3_sampling_event; wire aoe_3_test_expr;
    wire aoe_4_sampling_event; wire aoe_4_test_expr;
    //
    assign aoe_1_sampling_event = hot_ctr[0];
    assign aoe_1_test_expr      = hot_ctr != 8'h00;
    //
    assign aoe_2_sampling_event = hot_ctr[0];
    assign aoe_2_test_expr      = !hot_ctr[1];
    //
    assign aoe_3_sampling_event = hot_ctr[0];
    assign aoe_3_test_expr      = hot_ctr[1];
    //
    assign aoe_4_sampling_event = hot_ctr[0];
    assign aoe_4_test_expr      = (hot_ctr[0] | hot_ctr[1]);


    // INDEX:        - assert_change
    // =====
    wire chg_1_start_event; wire [7:0] chg_1_test_expr;
    wire chg_2_start_event; wire [7:0] chg_2_test_expr;
    wire chg_3_start_event; wire [7:0] chg_3_test_expr;
    //
    assign chg_1_start_event = (free_ctr[0] == 1'b0);
    assign chg_1_test_expr   = {7'b0,(free_ctr[1:0] != 2'b11)};
    //
    assign chg_2_start_event = (free_ctr[0] == 1'b0);
    assign chg_2_test_expr   = {6'b0,(free_ctr[1:0] != 2'b11),1'b0};
    //
    assign chg_3_start_event = (free_ctr[2:0] == 3'b000);
    assign chg_3_test_expr   = {5'b0,(free_ctr[2:0] != 3'b011),2'b0};


    // INDEX:        - assert_cycle_sequence
    // =====
    wire [2:0] csq_1_event_sequence;
    wire [2:0] csq_2_event_sequence;
    wire [2:0] csq_3_event_sequence;
    //
    // NOTE: bits reversed below
    //
    assign csq_1_event_sequence[2] = hot_ctr[0];
    assign csq_1_event_sequence[1] = hot_ctr[1];
    assign csq_1_event_sequence[0] = hot_ctr[2];
    //
    assign csq_2_event_sequence[2] = hot_ctr[3];
    assign csq_2_event_sequence[1] = hot_ctr[4];
    assign csq_2_event_sequence[0] = hot_ctr[5];
    //
    assign csq_3_event_sequence[2] = hot_ctr[6];
    assign csq_3_event_sequence[1] = hot_ctr[7];
    assign csq_3_event_sequence[0] = hot_ctr[0];


    // INDEX:        - assert_decrement
    // =====
    wire [3:0] dec_1_test_expr;
    wire [3:0] dec_2_test_expr;
    //
    assign dec_1_test_expr = (4'hF - safe_ctr[3:0]);
    assign dec_2_test_expr = {(3'b111 - safe_ctr[2:0]),1'b0};


    // INDEX:        - assert_delta
    // =====
    wire [3:0] dlt_1_test_expr;
    //
    assign dlt_1_test_expr = {1'b0,hot_ctr[2:1],1'b0};


    // INDEX:        - assert_even_parity
    // =====
    wire [7:0] evp_1_test_expr;
    //
    assign evp_1_test_expr = {safe_ctr[3:0],safe_ctr[3:0]};


    // INDEX:        - assert_fifo_index
    // =====
    wire fix_1_push; wire fix_1_pop;
    //
    assign fix_1_push = |(hot_ctr[3:1]);
    assign fix_1_pop =  |(hot_ctr[6:4]);


    // INDEX:        - assert_frame
    // =====
    wire frm_1_start_event; wire frm_1_test_expr;
    wire frm_2_start_event; wire frm_2_test_expr;
    wire frm_3_start_event; wire frm_3_test_expr;
    wire frm_4_start_event; wire frm_4_test_expr;
    wire frm_5_start_event; wire frm_5_test_expr;
    //
    assign frm_1_start_event = hot_ctr[4] | hot_ctr[6]; // rising edge on hot_ctr[6] should be ignored
    assign frm_1_test_expr   = hot_ctr[7];
    //
    assign frm_2_start_event = hot_ctr[0];
    assign frm_2_test_expr   = hot_ctr[7];
    //
    assign frm_3_start_event = hot_ctr[1] | hot_ctr[6]; // rising edge on hot_ctr[6] should be ignored
    assign frm_3_test_expr   = hot_ctr[7];
    //
    assign frm_4_start_event = hot_ctr[0] | hot_ctr[2]; // rising edge on hot_ctr[2] should reset the checker
    assign frm_4_test_expr   = |(hot_ctr[7:5]);
    //
    assign frm_5_start_event = |(hot_ctr[6:0]); // rising edge only on hot_ctr[0]
    assign frm_5_test_expr   = hot_ctr[7];


    // INDEX:        - assert_handshake
    // =====
    wire hnd_1_req; wire hnd_1_ack;
    //
    assign hnd_1_req = |hot_ctr[3:1];
    assign hnd_1_ack = hot_ctr[3];


    // INDEX:        - assert_implication
    // =====
    wire imp_1_antecedent_expr; wire imp_1_consequent_expr;
    //
    assign imp_1_antecedent_expr = (free_ctr == 8'hFF);
    assign imp_1_consequent_expr = (safe_ctr == 8'hFF);


    // INDEX:        - assert_increment
    // =====
    wire [3:0] inc_1_test_expr;
    wire [3:0] inc_2_test_expr;
    //
    assign inc_1_test_expr = (safe_ctr[7:4]);
    assign inc_2_test_expr = {safe_ctr[7:5],1'b0};


    // INDEX:        - assert_never
    // =====
    wire nvr_1_test_expr;
    wire nvr_2_test_expr;
    wire nvr_3_test_expr;
    //
    assign nvr_1_test_expr = (safe_ctr == 0);
    assign nvr_2_test_expr = (safe_ctr == 0);
    assign nvr_3_test_expr = (safe_ctr == 0);


    // INDEX:        - assert_never_unknown       (ignored by Formal)
    // =====
    wire nun_1_qualifier; wire [1:0] nun_1_test_expr;
    //
    assign nun_1_qualifier = 1'b0;
    assign nun_1_test_expr = 2'b00;


    // INDEX:        - assert_never_unknown_async (ignored by Formal)
    // =====
    wire [1:0] nua_1_test_expr;
    //
    assign nua_1_test_expr = 2'b00;


    // INDEX:        - assert_next
    // =====
    wire nxt_1_start_event; wire nxt_1_test_expr;
    wire nxt_2_start_event; wire nxt_2_test_expr;
    wire nxt_3_start_event; wire nxt_3_test_expr;
    //
    assign nxt_1_start_event = hot_ctr[4];
    assign nxt_1_test_expr   = hot_ctr[5];
    //
    assign nxt_2_start_event = hot_ctr[6];
    assign nxt_2_test_expr   = hot_ctr[0];
    //
    assign nxt_3_start_event = (hot_ctr[1] | hot_ctr[2]);
    assign nxt_3_test_expr   = (hot_ctr[3] | hot_ctr[4]);


    // INDEX:        - assert_no_overflow
    // =====
    // Will go: 6 -> 5 -> 0, which is not classed as an overflow (for max=6, min=0)
    wire [2:0] noo_1_test_expr;
    //
    assign noo_1_test_expr = (free_ctr[2:0] > 3'h6) ? 3'h5 : free_ctr[2:0];


    // INDEX:        - assert_no_transition
    // =====
    wire [2:0] not_1_test_expr;
    //
    assign not_1_test_expr = ~free_ctr[2:0];


    // INDEX:        - assert_no_underflow
    // =====
    // Will go: 1 -> 2 -> 7, which is not classed as an underflow (for max=6, min=1)
    wire [2:0] nou_1_test_expr;
    //
    assign nou_1_test_expr = (~free_ctr[2:0] < 3'h1) ? 3'h2 : ~free_ctr[2:0];


    // INDEX:        - assert_odd_parity
    // =====
    wire [7:0] odp_1_test_expr;
    //
    assign odp_1_test_expr = {safe_ctr[2:0],safe_ctr[2:0],1'b1,1'b0};


    // INDEX:        - assert_one_cold
    // =====
    wire [7:0] ocd_1_test_expr;
    wire [7:0] ocd_2_test_expr;
    wire [7:0] ocd_3_test_expr;
    //
    assign ocd_1_test_expr = ~hot_ctr;
    assign ocd_2_test_expr = (~hot_ctr) & {8{free_ctr != 8'hFF}};
    assign ocd_3_test_expr = (~hot_ctr) | {8{free_ctr == 8'hFF}};


    // INDEX:        - assert_one_hot
    // =====
    wire [7:0] oht_1_test_expr;
    //
    assign oht_1_test_expr = hot_ctr;


    // INDEX:        - assert_proposition
    // =====
    wire prp_1_test_expr;
    //
    assign prp_1_test_expr = (safe_ctr != 8'h00);


    // INDEX:        - assert_range
    // =====
    wire [2:0] rng_1_test_expr;
    //
    assign rng_1_test_expr = 
           (free_ctr[2:0] <= 3'h6)  ? ((free_ctr[2:0] >= 3'h1) ? free_ctr[2:0] 
                                                               : 3'h1)
                                    : 3'h6;


    // INDEX:        - assert_quiescent_state
    // =====
    wire [2:0] qst_1_state_expr; wire qst_1_sample_event;
    //
    assign qst_1_state_expr = free_ctr[2:0];
    assign qst_1_sample_event = (safe_ctr[2:0] == 3'b101);


    // INDEX:        - assert_time
    // =====
    wire tim_1_start_event; wire tim_1_test_expr;
    wire tim_2_start_event; wire tim_2_test_expr;
    wire tim_3_start_event; wire tim_3_test_expr;
    //
    assign tim_1_start_event = hot_ctr[0];
    assign tim_1_test_expr   = |hot_ctr[5:0];
    //
    assign tim_2_start_event = hot_ctr[1] | hot_ctr[2];
    assign tim_2_test_expr   = |hot_ctr[7:1];
    //
    assign tim_3_start_event = hot_ctr[3];
    assign tim_3_test_expr   = !(|hot_ctr[2:1]);


    // INDEX:        - assert_transition
    // =====
    wire [2:0] trn_1_test_expr;
    //
    assign trn_1_test_expr = free_ctr[2:0];


    // INDEX:        - assert_unchange
    // =====
    wire unc_1_start_event; wire [7:0] unc_1_test_expr;
    wire unc_2_start_event; wire [7:0] unc_2_test_expr;
    wire unc_3_start_event; wire [7:0] unc_3_test_expr;
    //
    assign unc_1_start_event = hot_ctr[6];
    assign unc_1_test_expr   = {8{hot_ctr[5]}};
    //
    assign unc_2_start_event = (hot_ctr[6] | hot_ctr[7]);
    assign unc_2_test_expr   = {8{hot_ctr[6]}};
    //
    assign unc_3_start_event = hot_ctr[7];
    assign unc_3_test_expr   = {8{hot_ctr[6]}};


    // INDEX:        - assert_width
    // =====
    wire wid_1_test_expr;
    wire wid_2_test_expr;
    wire wid_3_test_expr;
    wire wid_4_test_expr;
    //
    assign wid_1_test_expr = |hot_ctr[3:0];
    assign wid_2_test_expr = |hot_ctr[5:0];
    assign wid_3_test_expr = |hot_ctr[3:0];
    assign wid_4_test_expr = |hot_ctr[4:0];


    // INDEX:        - assert_win_change
    // =====
    wire wch_1_start_event; wire wch_1_end_event; wire [7:0] wch_1_test_expr;
    //
    assign wch_1_start_event = hot_ctr[0];
    assign wch_1_test_expr   = {hot_ctr[7:6], 5'b1_1001, hot_ctr[3]};
    assign wch_1_end_event   = hot_ctr[5];


    // INDEX:        - assert_window
    // =====
    wire win_1_start_event; wire win_1_end_event; wire win_1_test_expr;
    //
    assign win_1_start_event =  hot_ctr[1];
    assign win_1_test_expr   = |hot_ctr[6:1];
    assign win_1_end_event   =  hot_ctr[6];


    // INDEX:        - assert_win_unchange
    // =====
    wire wuc_1_start_event; wire wuc_1_end_event; wire [7:0] wuc_1_test_expr;
    //
    assign wuc_1_start_event = hot_ctr[1];
    assign wuc_1_test_expr   = {hot_ctr[7], 6'b01_1001, hot_ctr[0]};
    assign wuc_1_end_event   = hot_ctr[6];


    // INDEX:        - assert_zero_one_hot
    // =====
    wire [7:0] zoh_1_test_expr;
    //
    assign zoh_1_test_expr = (hot_ctr) & {8{free_ctr != 8'hFF}};


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

endmodule // tb_assert_formal_pass



