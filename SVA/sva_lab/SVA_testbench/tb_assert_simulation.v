//----------------------------------------------------------------------------
// Accellera Copyright (c) 2007. All rights reserved.
//----------------------------------------------------------------------------

//----------------------------------------------------------------------------
// CONTENTS (last updated: Wed Jul 11 13:46:29 BST 2007)
// ========
//  113.  Testbench
//  118.    - ToDo List (including 6 bugs)
//  129.  
//  130.  OVL Ports
//  134.    - global: clock & reset
//  139.    - assert_always
//  147.    - assert_always_on_edge
//  155.    - assert_change
//  162.    - assert_cycle_sequence
//  169.    - assert_decrement
//  175.    - assert_delta
//  180.    - assert_even_parity
//  185.    - assert_fifo_index
//  190.    - assert_frame
//  199.    - assert_handshake
//  204.    - assert_implication
//  209.    - assert_increment
//  215.    - assert_never
//  222.    - assert_never_unknown
//  227.    - assert_never_unknown_async
//  232.    - assert_next
//  239.    - assert_no_overflow
//  244.    - assert_no_transition
//  249.    - assert_no_underflow
//  254.    - assert_odd_parity
//  259.    - assert_one_cold
//  266.    - assert_one_hot
//  271.    - assert_proposition
//  276.    - assert_range
//  281.    - assert_quiescent_state
//  286.    - assert_time
//  293.    - assert_transition
//  298.    - assert_unchange
//  305.    - assert_width
//  313.    - assert_win_change
//  318.    - assert_window
//  323.    - assert_win_unchange
//  328.    - assert_zero_one_hot
//  334.  
//  335.  DUT: assert_every_config
//  415. 
//  416.  Support Stuff
//  420.    1) EOS signal: simulation_done
//  425.    2) New includes (ovl_count.h)
//  432.    3) Display Task (sim_info)
//  462. 
//  463.  Clock (period = 100ns)
//  477. 
//  478.  Main Stimulus
//  484.    1) Start Up
//  487.         - Reset On (all other signals X)
//  500.         - Reset Off (other signals set to avoid failures)
//  576.         - (REVISIT: check always_on_edge just after reset - should be ignored)
//  580.    2) Test Combinatorial OVLs
//  584.         - assert_never_unknown_async
//  596.         - assert_proposition
//  609.    3) Test Single-Cycle OVLs
//  613.         - assert_always (4 instances, to test property_type)
//  624.         - assert_even_parity
//  636.         - assert_implication
//  654.         - assert_never (3 instances, to test severity_level)
//  665.         - assert_never_unknown
//  679.         - assert_odd_parity
//  691.         - assert_one_cold
//  703.         - assert_one_hot
//  715.         - assert_range
//  731.         - assert_zero_one_hot
//  744.    4) Test 2-Cycle OVLs
//  748.         - assert_always_on_edge   (REVISIT: another X-check)
//  769.         - assert_decrement        (REVISIT: X-check)
//  780.         - assert_delta            (REVISIT: X-check)
//  803.         - assert_fifo_index       *TBD*
//  807.         - assert_increment        (REVISIT: X-check)
//  818.         - assert_no_overflow      (REVISIT: X-check)
//  831.         - assert_no_transition    (REVISIT: X-check)
//  841.         - assert_no_underflow     (REVISIT: X-check)
//  854.         - assert_quiescent_state  (REVISIT: EOS + X-check)
//  862.         - assert_transition       (REVISIT: X-check)
//  873.    5) Test n-Cycle OVLs
//  877.         - assert_change           (REVISIT: 2 more configs + X-check)
//  895.         - assert_cycle_sequence   (REVISIT: 2 more configs + X-check)
//  908.         - assert_frame            *TBD*
//  912.         - assert_handshake        *TBD*
//  916.         - assert_next             (REVISIT: 2 more configs + X-check)
//  926.         - assert_time             (REVISIT: 2 more configs + X-check)
//  936.         - assert_unchange         (REVISIT: 2 more configs + X-check)
//  944.         - assert_width            (REVISIT: 3 more configs + X-check)
//  953.    6) Test Event-Bound OVLs
//  957.         - assert_win_change       (REVISIT: X-check)
//  994.         - assert_window           (REVISIT: X-check)
// 1049.         - assert_win_unchange     (REVISIT: X-check)
// 1105.    7) Finish Stuff
// 1109.         - EOS checks
// 1115.         - Final OVL metrics (*** COMMENTED OUT FOR NOW ***)
// 1128. 
// 1129.  Stop via OVL_FATAL
//----------------------------------------------------------------------------


//`include "std_ovl_defines.h"
`include "assert_dut.v"
`include "assertion_checker.v"

`timescale 1ns / 1ns

module tb_assert_simulation  ;

   // INDEX: Testbench
   // =====
   // Stimulus to check every OVL (and every config).


   // INDEX:   - ToDo List (including 6 bugs)
   // =====
   // 1) Investigate the 6 *BUG* reports (test issue or OVL bug?)
   // 2) Write tests for assert_fifo_index, assert_frame, assert_handshake
   // 3) Finish tests for OVLs marked with "REVISIT" (X-checks & configs)
   // 4) Turn on OVL coverage, to ensure nothing is missed
   // 5) Review tests against coverage and timing diagrams
   // 6) Ensure "Major Changes" in timing diagrams are well tested


   // ----------------------------------------------------------------------
   // INDEX: 
   // INDEX: OVL Ports
   // ----------------------------------------------------------------------


   // INDEX:   - global: clock & reset
   // =====
   reg clk, clk2,reset_n;


   // INDEX:   - assert_always
   // =====
   reg alw_1_test_expr;
   reg alw_2_test_expr;
   reg alw_3_test_expr;
   reg alw_4_test_expr;


   // INDEX:   - assert_always_on_edge
   // =====
   reg aoe_1_sampling_event; reg aoe_1_test_expr;
   reg aoe_2_sampling_event; reg aoe_2_test_expr;
   reg aoe_3_sampling_event; reg aoe_3_test_expr;
   reg aoe_4_sampling_event; reg aoe_4_test_expr;


   // INDEX:   - assert_change
   // =====
   reg chg_1_start_event; reg [7:0] chg_1_test_expr;
   reg chg_2_start_event; reg [7:0] chg_2_test_expr;
   reg chg_3_start_event; reg [7:0] chg_3_test_expr;


   // INDEX:   - assert_cycle_sequence
   // =====
   reg [2:0] csq_1_event_sequence;
   reg [2:0] csq_2_event_sequence;
   reg [2:0] csq_3_event_sequence;


   // INDEX:   - assert_decrement
   // =====
   reg [3:0] dec_1_test_expr;
   reg [3:0] dec_2_test_expr;


   // INDEX:   - assert_delta
   // =====
   reg [3:0] dlt_1_test_expr;


   // INDEX:   - assert_even_parity
   // =====
   reg [7:0] evp_1_test_expr;


   // INDEX:   - assert_fifo_index
   // =====
   reg fix_1_push; reg fix_1_pop;


   // INDEX:   - assert_frame
   // =====
   reg frm_1_start_event; reg frm_1_test_expr;
   reg frm_2_start_event; reg frm_2_test_expr;
   reg frm_3_start_event; reg frm_3_test_expr;
   reg frm_4_start_event; reg frm_4_test_expr;
   reg frm_5_start_event; reg frm_5_test_expr;


   // INDEX:   - assert_handshake
   // =====
   reg hnd_1_req; reg hnd_1_ack;
   reg hnd_1_req_clk; reg hnd_1_ack_clk;


   // INDEX:   - assert_implication
   // =====
   reg imp_1_antecedent_expr; reg imp_1_consequent_expr;


   // INDEX:   - assert_increment
   // =====
   reg [3:0] inc_1_test_expr;
   reg [3:0] inc_2_test_expr;


   // INDEX:   - assert_never
   // =====
   reg nvr_1_test_expr;
   reg nvr_2_test_expr;
   reg nvr_3_test_expr;


   // INDEX:   - assert_never_unknown
   // =====
   reg nun_1_qualifier; reg [1:0] nun_1_test_expr;


   // INDEX:   - assert_never_unknown_async
   // =====
   reg [1:0] nua_1_test_expr;


   // INDEX:   - assert_next
   // =====
   reg nxt_1_start_event; reg nxt_1_test_expr;
   reg nxt_2_start_event; reg nxt_2_test_expr;
   reg nxt_3_start_event; reg nxt_3_test_expr;


   // INDEX:   - assert_no_overflow
   // =====
   reg [2:0] noo_1_test_expr;


   // INDEX:   - assert_no_transition
   // =====
   reg [2:0] not_1_test_expr;


   // INDEX:   - assert_no_underflow
   // =====
   reg [2:0] nou_1_test_expr;


   // INDEX:   - assert_odd_parity
   // =====
   reg [7:0] odp_1_test_expr;


   // INDEX:   - assert_one_cold
   // =====
   reg [7:0] ocd_1_test_expr;
   reg [7:0] ocd_2_test_expr;
   reg [7:0] ocd_3_test_expr;


   // INDEX:   - assert_one_hot
   // =====
   reg [7:0] oht_1_test_expr;


   // INDEX:   - assert_proposition
   // =====
   reg prp_1_test_expr;


   // INDEX:   - assert_range
   // =====
   reg [2:0] rng_1_test_expr;


   // INDEX:   - assert_quiescent_state
   // =====
   reg [2:0] qst_1_state_expr; reg qst_1_sample_event;


   // INDEX:   - assert_time
   // =====
   reg tim_1_start_event; reg tim_1_test_expr;
   reg tim_2_start_event; reg tim_2_test_expr;
   reg tim_3_start_event; reg tim_3_test_expr;


   // INDEX:   - assert_transition
   // =====
   reg [2:0] trn_1_test_expr;


   // INDEX:   - assert_unchange
   // =====
   reg unc_1_start_event; reg [7:0] unc_1_test_expr;
   reg unc_2_start_event; reg [7:0] unc_2_test_expr;
   reg unc_3_start_event; reg [7:0] unc_3_test_expr;


   // INDEX:   - assert_width
   // =====
   reg wid_1_test_expr;
   reg wid_2_test_expr;
   reg wid_3_test_expr;
   reg wid_4_test_expr;


   // INDEX:   - assert_win_change
   // =====
   reg wch_1_start_event; reg wch_1_end_event; reg [7:0] wch_1_test_expr;


   // INDEX:   - assert_window
   // =====
   reg win_1_start_event; reg win_1_end_event; reg win_1_test_expr;


   // INDEX:   - assert_win_unchange
   // =====
   reg wuc_1_start_event; reg wuc_1_end_event; reg [7:0] wuc_1_test_expr;


   // INDEX:   - assert_zero_one_hot
   // =====
   reg [7:0] zoh_1_test_expr;


   // ----------------------------------------------------------------------
   // INDEX: 
   // INDEX: DUT: assert_every_config
   // ----------------------------------------------------------------------
   assert_dut DUT
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


   // ----------------------------------------------------------------------
   // INDEX:
   // INDEX: Support Stuff
   // ----------------------------------------------------------------------


   // INDEX:   1) EOS signal: simulation_done
   // =====
   reg simulation_done;


   // INDEX:   2) New includes (ovl_count.h)
   // =====
   `ifdef OVL_INIT_COUNT
     `include "std_ovl_count.h"
   `endif


   // INDEX:   3) Display Task (sim_info)
   // =====
   `define NoFails "0 failures expected"
   `define Space   8'b0000_0000
   //
   task sim_info;
   `define CharCount 40 // 40-character strings
      input [`CharCount*8-1:0]     event_str,     fails_str; //
      reg   [`CharCount*8-1:0] new_event_str, new_fails_str; // Left-Justified versions
      begin
         // Left-Align the event string (remove leading spaces)
         new_event_str = event_str;
         while (new_event_str[`CharCount*8-1:`CharCount*8-8] == `Space)
           new_event_str = new_event_str << 8;
         //
         // Left-Align the expected-failures string (remove leading spaces)
         new_fails_str = fails_str;
         while (new_fails_str[`CharCount*8-1:`CharCount*8-8] == `Space)
           new_fails_str = new_fails_str << 8;
         //
         // Display message
         $display ("");
         $display ("       |----------|------------------------------------------|------------------------------------------|");
         $display ("INDEX: | %5d ns | %40s | %40s |",$time,new_event_str,new_fails_str);
         $display ("~~~~~  |----------|------------------------------------------|------------------------------------------|");
      end
   endtask // sim_info


   // ----------------------------------------------------------------------
   // INDEX:
   // INDEX: Clock (period = 100ns)
   // ----------------------------------------------------------------------
   initial
      begin
         repeat(2000)
            begin
                    clk=1'b1;
               #50  clk=1'b0;
               #50  ;
            end
      end

      task clk2_gen();
      begin
	      #30;
         repeat(6)
            begin
                    clk2=1'b1;
               #50  clk2=1'b0;
               #50  ;
            end
      end
      endtask

      task clk2_gen_s();
      begin
	     #20; 
         repeat(5)
            begin
                    clk2=1'b1;
               #50  clk2=1'b0;
               #50  ;
            end
      end
      endtask
   // ----------------------------------------------------------------------
   // INDEX:
   // INDEX: Main Stimulus
   // ----------------------------------------------------------------------
   initial
      begin
 clk2 = 0;
         //-------------------------------------------------------------------
         // INDEX:   1) Start Up
         //-------------------------------------------------------------------

         // INDEX:        - Reset On (all other signals X)
         // =====
         // Reset: Low until 3rd falling edge of clock
         #0
         $display ("");
         $display ("INDEX: |==========|==========================================|==========================================|");
         $display ("INDEX: |   TIME   |                   EVENT                  |                 FAILURES                 |");
         $display ("INDEX: |==========|==========================================|==========================================|");
         $display ("");
         sim_info ("Reset On (other signals X)", `NoFails);
         reset_n=1'b0; simulation_done=1'b0;
         #50

         // INDEX:        - Reset Off (other signals set to avoid failures)
         // =====
         #100 sim_info ("Reset Off (other signals set to pass)", `NoFails);
         nua_1_test_expr=1'b0;
         prp_1_test_expr=1'b1;
         //
         alw_1_test_expr=1'b1;
         alw_2_test_expr=1'b1;
         alw_3_test_expr=1'b1;
         alw_4_test_expr=1'b1;
         evp_1_test_expr=8'h00;
         imp_1_antecedent_expr=1'b0; imp_1_consequent_expr=1'b0;
         nvr_1_test_expr=1'b0;
         nvr_2_test_expr=1'b0;
         nvr_3_test_expr=1'b0;
         nun_1_qualifier=1'b0; nun_1_test_expr=1'b0;
         odp_1_test_expr=8'h01;
         ocd_1_test_expr=8'h7F;
         ocd_2_test_expr=8'h00;
         ocd_3_test_expr=8'hFF;
         oht_1_test_expr=8'h01;
         rng_1_test_expr=3'b101;
         zoh_1_test_expr=8'h00;
         //
         aoe_1_sampling_event=1'b0; aoe_1_test_expr=1'b0;
         aoe_2_sampling_event=1'b0; aoe_2_test_expr=1'b1;
         aoe_3_sampling_event=1'b0; aoe_3_test_expr=1'b1;
         aoe_4_sampling_event=1'b0; aoe_4_test_expr=1'b0;
         //
         dec_1_test_expr=4'b0000;
         dec_2_test_expr=4'b0000;
         dlt_1_test_expr=4'b0000;
         inc_1_test_expr=4'b0000;
         inc_2_test_expr=4'b0000;
         //
         fix_1_push=1'b0; fix_1_pop=1'b0;
         //
         noo_1_test_expr=3'b000;
         not_1_test_expr=3'b000;
         nou_1_test_expr=3'b000;
         trn_1_test_expr=3'b000;
         //
         qst_1_state_expr=3'b000; qst_1_sample_event=1'b0;
         //
         chg_1_start_event=1'b0;
         chg_2_start_event=1'b0;
         chg_3_start_event=1'b0;
         csq_1_event_sequence=3'b000;
         csq_2_event_sequence=3'b000;
         csq_3_event_sequence=3'b000;
         frm_1_start_event=1'b0;
         frm_2_start_event=1'b0;
         frm_3_start_event=1'b0;
         frm_4_start_event=1'b0;
         frm_5_start_event=1'b1;
	 frm_5_test_expr = 1;
         hnd_1_req=1'b0; hnd_1_ack=1'b0;
         hnd_1_req_clk=1'b0; hnd_1_ack_clk=1'b0;
         nxt_1_start_event=1'b0;
         nxt_2_start_event=1'b0;
         nxt_3_start_event=1'b0; nxt_3_test_expr=1'b0;
         tim_1_start_event=1'b0;
         tim_2_start_event=1'b0;
         tim_3_start_event=1'b0;
         unc_1_start_event=1'b0;
         unc_2_start_event=1'b0;
         unc_3_start_event=1'b0;
         wid_1_test_expr=1'b0;
         wid_2_test_expr=1'b0;
         wid_3_test_expr=1'b0;
         wid_4_test_expr=1'b0;
	 frm_3_test_expr = 0;
	 frm_4_test_expr = 0;
	 frm_4_start_event = 1;
         //
         wch_1_start_event=1'b0; wch_1_end_event=1'b0;
         win_1_start_event=1'b0; win_1_end_event=1'b0;
         wuc_1_start_event=1'b0; wuc_1_end_event=1'b0;
         //
         reset_n=1'b1;

         // INDEX:        - (REVISIT: check always_on_edge just after reset - should be ignored)


         //-------------------------------------------------------------------
         // INDEX:   2) Test Combinatorial OVLs
         //-------------------------------------------------------------------


         // INDEX:        - assert_never_unknown_async
         // =====
         #100 sim_info ("never_unknown_async X-check, te:0X", "1 X-fail: ERROR");
         nua_1_test_expr=1'bX;
         #100
         nua_1_test_expr=1'b0;
         #100
         nua_1_test_expr=1'b1;
         #100 sim_info ("never_unknown_async X-check, te:1X", "1 X-fail: ERROR");
         nua_1_test_expr=1'bX;


         // INDEX:        - assert_proposition
         // =====
         #100 sim_info ("proposition X-check", "1 X-fail: ERROR");
         prp_1_test_expr=1'bX;
         #100
         prp_1_test_expr=1'b1;
         #100 sim_info ("proposition 2-val check", "1 fail: ERROR");
         prp_1_test_expr=1'b0;
         #100
         prp_1_test_expr=1'b1;


         //-------------------------------------------------------------------
         // INDEX:   3) Test Single-Cycle OVLs
         //-------------------------------------------------------------------


         // INDEX:        - assert_always (4 instances, to test property_type)
         // =====
	 #100; sim_info ("assert_always 2-val check", "1 fail: ERROR");
         alw_1_test_expr=1'b0; 
	 #100; sim_info ("assert_always 2-val check", "1 fail: ERROR");
	 alw_2_test_expr=1'b0; alw_3_test_expr=1'b0; alw_4_test_expr=1'b0;
         #100
         alw_1_test_expr=1'b1; alw_2_test_expr=1'b1; alw_3_test_expr=1'b1; alw_4_test_expr=1'b1;


         // INDEX:        - assert_even_parity
         // =====
         #100 sim_info ("even_parity 1-check", "1 X-fail: ERROR");
         evp_1_test_expr=8'b0000_0100;
         #100 sim_info ("even_parity 2val-check", "1 Fail: ERROR");
         evp_1_test_expr=8'b1010_1011;
         #100
         evp_1_test_expr=8'b1010_1010;
         #100
         evp_1_test_expr=8'b0000_0000;


         // INDEX:        - assert_implication
         // =====
         #100 sim_info ("implication X-check (ante=X, cons=0)", "1 X-fail: ERROR");
         imp_1_antecedent_expr=1'bX; imp_1_consequent_expr=1'b0;
         #100 sim_info ("implication X-check (ante=X, cons=1)", "0 failures expected");
         imp_1_antecedent_expr=1'bX; imp_1_consequent_expr=1'b1;
         #100 sim_info ("implication X-check (ante=1,cons=X)", "1 X-fail: ERROR");
         imp_1_antecedent_expr=1'b1; imp_1_consequent_expr=1'bX;
         #100 sim_info ("implication X-check (ante=0, cons=X)", "0 failures expected");
         imp_1_antecedent_expr=1'b0; imp_1_consequent_expr=1'bX;
         #100 sim_info ("implication X-check (ante=X,cons=X)", "2 X-fail: ERROR *BUG* only 1 (Mantis 1803)");
         imp_1_antecedent_expr=1'bX; imp_1_consequent_expr=1'bX;
         #100 sim_info ("implication 2val-check", "1 Fail: ERROR");
         imp_1_antecedent_expr=1'b1; imp_1_consequent_expr=1'b0;
         #100
         imp_1_antecedent_expr=1'b1; imp_1_consequent_expr=1'b1;


         // INDEX:        - assert_never (3 instances, to test severity_level)
         // =====
         // 3 instances but only two failures (`OVL_FATAL tested elsewhere)
 //        #100 sim_info ("never X-check", "2 X-fail: WARN & INFO");
   //      nvr_1_test_expr=1'b0; nvr_2_test_expr=1'bX; nvr_3_test_expr=1'bX;
         #100 sim_info ("never 2val-check", "2 Fail: WARN & INFO");
         nvr_1_test_expr=1'b0; nvr_2_test_expr=1'b1; nvr_3_test_expr=1'b0;
         #100
 	 nvr_1_test_expr=1'b0; nvr_2_test_expr=1'b1; nvr_3_test_expr=1'b1;
         #100

         nvr_1_test_expr=1'b0; nvr_2_test_expr=1'b0; nvr_3_test_expr=1'b0;


         // INDEX:        - assert_never_unknown
         // =====
         #100 sim_info ("never_unknown X-check", "1 X-fail: ERROR");
         nun_1_qualifier=1'b1; nun_1_test_expr=1'bX;
         #100
         nun_1_qualifier=1'b0; nun_1_test_expr=1'bX;
         #100 sim_info ("never_unknown X-check (both X)", "*BUG*: should fire here!");
         nun_1_qualifier=1'bX; nun_1_test_expr=1'bX;
         #100
         nun_1_qualifier=1'bX; nun_1_test_expr=1'b0;
         #100
         nun_1_qualifier=1'bX; nun_1_test_expr=1'b1;


         // INDEX:        - assert_odd_parity
         // =====
         #100 sim_info ("odd_parity X-check", "1 X-fail: ERROR");
         odp_1_test_expr=8'b0X00_0000;
         #100 sim_info ("odd_parity 2val-check", "1 Fail: ERROR");
         odp_1_test_expr=8'b1010_1010;
         #100
         odp_1_test_expr=8'b1010_1011;
         #100
         odp_1_test_expr=8'b1000_0000;


         // INDEX:        - assert_one_cold
         // =====
         #100 sim_info ("one_cold X-check", "3 X-fail: ERROR");
         ocd_1_test_expr=8'b1X11_1111; ocd_2_test_expr=8'b0000_0X00; ocd_3_test_expr=8'b1X11_1111;
         #100 sim_info ("one_cold 2val-check", "3 Fail: ERROR");
         ocd_1_test_expr=8'h77; ocd_2_test_expr=8'h77; ocd_3_test_expr=8'h77;
         #100 sim_info ("one_cold max/zero-check", "3 Fail: ERROR");
         ocd_1_test_expr=8'hFF; ocd_2_test_expr=8'hFF; ocd_3_test_expr=8'h00;
         #100
         ocd_1_test_expr=8'hF7; ocd_2_test_expr=8'h00; ocd_3_test_expr=8'hFF;


         // INDEX:        - assert_one_hot
         // =====
         #100 sim_info ("one_hot X-check", "1 X-fail: ERROR");
         oht_1_test_expr=8'b0X00_0000;
         #100 sim_info ("one_hot 2val-check", "1 Fail: ERROR");
         oht_1_test_expr=8'b1010_1010;
         #100 sim_info ("one_hot zero-check", "1 Fail: ERROR");
         oht_1_test_expr=8'b0000_0000;
         #100
         oht_1_test_expr=8'b1000_0000;


         // INDEX:        - assert_range
         // =====
         #100 sim_info ("range X-check (can be 0)", "1 X-fail: ERROR");
         rng_1_test_expr=3'b0X0;
         #100 sim_info ("range X-check (can be 7)", "1 X-fail: ERROR");
         rng_1_test_expr=3'bXXX;
         #100 sim_info ("range X-check (OK, cannot be 0 or 7)", "*BUG*: should NOT fire here!");
         rng_1_test_expr=3'b1X0;
         #100 sim_info ("range min-check", "1 Fail: ERROR");
         rng_1_test_expr=3'b000;
         #100 sim_info ("range max-check", "1 Fail: ERROR");
         rng_1_test_expr=3'b111;
         #100
         rng_1_test_expr=3'b101;


         // INDEX:        - assert_zero_one_hot
         // =====
         #100 sim_info ("zero_one_hot X-check", "1 X-fail: ERROR");
         zoh_1_test_expr=8'b0X00_0000;
         #100 sim_info ("zero_one_hot 2val-check", "1 Fail: ERROR");
         zoh_1_test_expr=8'b1010_1010;
         #100
         zoh_1_test_expr=8'b0000_0000;
         #100
         zoh_1_test_expr=8'b0000_0001;


         //-------------------------------------------------------------------
         // INDEX:   4) Test 2-Cycle OVLs
         //-------------------------------------------------------------------


         // INDEX:        - assert_always_on_edge   (REVISIT: another X-check)
         // =====
         // REVISIT: what about an X on first cycle when 2nd cycle has test_expr low and a possible transition due to X on sampling event
//         #100 sim_info ("always_on_edge X-check, te:1X, se:-- (same)", "1 X-fail: ERROR (NOEDGE)");
//         aoe_1_test_expr=1'bX; aoe_2_test_expr=1'bX; aoe_3_test_expr=1'bX; aoe_4_test_expr=1'bX;
//         #100 sim_info ("always_on_edge X-check: te:XX, se=-E (edge)", "4 X-fail: ERROR");
//         aoe_1_sampling_event=1'b1; aoe_2_sampling_event=1'b1; aoe_3_sampling_event=1'b0; aoe_4_sampling_event=1'b1;
//         aoe_1_test_expr=1'bX;      aoe_2_test_expr=1'bX;      aoe_3_test_expr=1'bX;      aoe_4_test_expr=1'bX;
//         #100 sim_info ("always_on_edge X-check: te=X0, se=--", "1 Fail: ERROR (NOEDGE)");
//         aoe_1_test_expr=1'b0;      aoe_2_test_expr=1'b0;      aoe_3_test_expr=1'b0;      aoe_4_test_expr=1'b0;
//         #100
//         aoe_1_test_expr=1'b1;      aoe_2_test_expr=1'b1;      aoe_3_test_expr=1'b1;      aoe_4_test_expr=1'b1;
//         aoe_1_sampling_event=1'b1; aoe_2_sampling_event=1'b0; aoe_3_sampling_event=1'b1; aoe_4_sampling_event=1'b0;
//         #100 sim_info ("always_on_edge sampling_event X-check", "3 X-fail");
//         aoe_1_test_expr=1'b1;      aoe_2_test_expr=1'b0;      aoe_3_test_expr=1'b0;      aoe_4_test_expr=1'b0;
//         aoe_1_sampling_event=1'bX; aoe_2_sampling_event=1'bX; aoe_3_sampling_event=1'bX; aoe_4_sampling_event=1'bX;
//         #100 sim_info ("always_on_edge sampling_event X-check", "*BUG*: aoe_2/3/4 should NOT fire here!");
//         aoe_1_test_expr=1'b1;      aoe_2_test_expr=1'b1;      aoe_3_test_expr=1'b1;      aoe_4_test_expr=1'b1;
//         aoe_1_sampling_event=1'b1; aoe_2_sampling_event=1'b1; aoe_3_sampling_event=1'b0; aoe_4_sampling_event=1'b0;


         // INDEX:        - assert_decrement        (REVISIT: X-check)
         // =====
         // REVISIT: check X handling
         #100 sim_info ("decrement 2val-check", "2 Fail: ERROR");
         dec_1_test_expr=4'b0001; dec_2_test_expr=4'b0010;
         #100
         dec_1_test_expr=4'b0000; dec_2_test_expr=4'b0000;
         #100
         dec_1_test_expr=4'b1111; dec_2_test_expr=4'b1110; // Modulo decrement


         // INDEX:        - assert_delta            (REVISIT: X-check)
         // =====
         // REVISIT: check X handling
         #100 sim_info ("assert_frame -check", "1 Fail: ERROR");
	 frm_2_start_event = 0; frm_2_test_expr = 0;
         #100 frm_2_start_event = 1;
	 #100 frm_2_start_event = 0; frm_2_test_expr = 1;
	 #500 frm_2_test_expr = 0;
	 #1000 frm_2_start_event = 1; frm_2_test_expr = 1;
	 #100 frm_2_start_event = 0;
	 #600  frm_2_test_expr = 0;
         #100 sim_info ("assert_frame not 1 -check", "1 Fail: ERROR");
	 frm_3_start_event = 0; frm_3_test_expr = 0;
         #100 frm_3_start_event = 1;
	 #100 frm_3_start_event = 0; frm_3_test_expr = 1;
	 #500 frm_3_test_expr = 0; frm_3_start_event = 1;
	 #100 frm_3_start_event = 0; frm_3_test_expr = 0;
	 #100 frm_3_start_event = 0;
	 #600  frm_3_test_expr = 0;
         #100 sim_info ("assert_frame not 2 -check", "1 Fail: ERROR");
	 frm_4_start_event = 0; frm_4_test_expr = 0;
         #100 frm_4_start_event = 1;
	 #100 frm_4_start_event = 0; frm_4_test_expr = 1;
	 #500 frm_4_test_expr = 0; frm_4_start_event = 1;
	 #100 frm_4_start_event = 0; frm_4_test_expr = 0;
	 #100 frm_4_start_event = 0;
	 #400  frm_4_test_expr = 0;
    	 #100 frm_4_start_event = 1;
	 #100 frm_4_start_event = 0; frm_4_test_expr = 1;
	 #100 frm_4_start_event = 0; frm_4_test_expr = 0;
	 #300 frm_4_start_event = 1; frm_4_test_expr = 0;
	 #100 sim_info ("assert_frame not 3 -check", "1 Fail: ERROR");
	 frm_5_start_event = 0; frm_5_test_expr = 0;
         #100 frm_5_start_event = 1;
	 #100 frm_5_start_event = 0; frm_5_test_expr = 1;
	 #500 frm_5_test_expr = 0; frm_5_start_event = 1;
	 #100 frm_5_start_event = 0; frm_5_test_expr = 0;
	 #100 frm_5_start_event = 1;
	 #600  frm_5_test_expr = 1;
         #100 aoe_2_sampling_event =1;
	 #100 aoe_1_sampling_event = 1;
	 #300 aoe_1_test_expr = 1;
	 #100 aoe_1_sampling_event = 0;
	 #100 aoe_1_test_expr = 0;

	 #1000 aoe_1_sampling_event = 1; aoe_1_test_expr = 1;
	 #100 aoe_1_test_expr = 0; aoe_1_sampling_event = 0;
	 #100 aoe_1_test_expr = 0;
	 #100 aoe_1_sampling_event = 0;
	 #100 aoe_1_test_expr = 0;

	 #1000 aoe_1_sampling_event = 1; aoe_1_test_expr = 1;
	 #100 aoe_1_test_expr = 0;
	 #100 aoe_1_sampling_event = 0;
	 #100 aoe_1_test_expr = 0;

	 #1000 aoe_1_sampling_event = 1; aoe_1_test_expr = 1;
         #100 aoe_1_test_expr = 0;
	 #200 aoe_1_sampling_event = 0;
	 #100 aoe_1_test_expr = 0;
	 
	 #1000 aoe_1_sampling_event = 1;
	 #100 aoe_1_test_expr = 1; 
	 #100 aoe_1_sampling_event = 0; aoe_1_test_expr = 0;
	 #100 aoe_1_test_expr = 0;

	 #1000 aoe_1_sampling_event = 1;
	 #100 aoe_1_test_expr = 1; #100 aoe_1_test_expr = 0;
	 #100 aoe_1_sampling_event = 0;
	 #100 aoe_1_test_expr = 0;

	 #1000 aoe_1_sampling_event = 1;
	 #200 aoe_1_test_expr = 1;
	 #100 aoe_1_sampling_event = 0; aoe_1_test_expr = 0;
	 #100 aoe_1_test_expr = 0;

	 #1000 aoe_1_sampling_event = 1;
	 #200 aoe_1_test_expr = 1;
	 #100 aoe_1_test_expr = 0;
	 #100 aoe_1_sampling_event = 0;
	 #100 aoe_1_test_expr = 0;

	 #1000 aoe_3_sampling_event = 1;
         #200 aoe_3_sampling_event = 0;
	 #1000 aoe_3_sampling_event = 1;
         #300 aoe_3_sampling_event = 0;

	 #1000 aoe_4_sampling_event = 1;
         #200 aoe_4_sampling_event = 0;
	 #100 aoe_4_sampling_event = 1;
         #100 aoe_4_sampling_event = 0;
         #200 aoe_4_test_expr = 1;
         #100 aoe_4_test_expr = 0;


      fork
      clk2_gen();
      begin
         #0 hnd_1_req  = 1;
	 #100 hnd_1_ack =1; hnd_1_req = 0;
	 #100 hnd_1_req = 0; hnd_1_ack = 0;
	 #100 hnd_1_ack =0;

         #100 hnd_1_req  = 1;
	 #40 hnd_1_ack =1; 
	 #60 hnd_1_req = 0; 
	 #100 hnd_1_ack =0;       
      end
      join

#5000;

      fork
      clk2_gen_s();
      begin
         #0 hnd_1_req  = 1; hnd_1_ack = 1;

	 #100 hnd_1_ack =1; hnd_1_req = 0;
	 #100 hnd_1_req = 0; hnd_1_ack = 0;
	 #100 hnd_1_ack =0;

         #100 hnd_1_req  = 1;
	 #40 hnd_1_ack =1; 
	 #60 hnd_1_req = 0; 
	 #100 hnd_1_ack =0;       
      end
      join


         dlt_1_test_expr=4'b0010; // inc by 2
         #100
         dlt_1_test_expr=4'b0101; // inc by 3
         #100
         dlt_1_test_expr=4'b0001; // dec by 4
         #100 sim_info ("delta min 2valcheck", "1 Fail: ERROR");
         dlt_1_test_expr=4'b0010; // dec by 1 (less than min)
         #100 sim_info ("delta max 2valcheck", "1 Fail: ERROR");
         dlt_1_test_expr=4'b0111; // inc by 5 (more than max)
         #100
         dlt_1_test_expr=4'b0011; // dec by 4
         //
         // Modulo checks
         #100 sim_info ("delta max-modulo 2valcheck", "*BUG*: should NOT fire here!");
         dlt_1_test_expr=4'b1110; // dec by 4 (modulo)
         #100 sim_info ("delta min-modulo 2valcheck", "*BUG*: should NOT fire here!");
         dlt_1_test_expr=4'b0001; // inc by 2 (modulo)


         // INDEX:        - assert_fifo_index       *TBD*
         // =====


         // INDEX:        - assert_increment        (REVISIT: X-check)
         // =====
         // REVISIT: check X handling
         #100 sim_info ("increment 2val-check", "2 Fail: ERROR");
         inc_1_test_expr=4'b1110; inc_2_test_expr=4'b1101;
         #100
         inc_1_test_expr=4'b1111; inc_2_test_expr=4'b1111;
         #100
         inc_1_test_expr=4'b0000; inc_2_test_expr=4'b0001; // Modulo increment


         // INDEX:        - assert_no_overflow      (REVISIT: X-check)
         // =====
         // REVISIT: check X handling
         #100
         noo_1_test_expr=3'b110;
         #100 sim_info ("no_overflow min 2val-check", "1 Fail: ERROR");
         noo_1_test_expr=3'b000;
         #100
         noo_1_test_expr=3'b110;
         #100 sim_info ("no_overflow max 2val-check", "1 Fail: ERROR");
         noo_1_test_expr=3'b111;


         // INDEX:        - assert_no_transition    (REVISIT: X-check)
         // =====
         // REVISIT: check X handling
         #100
         not_1_test_expr=3'b100;
         #100
         #100 sim_info ("no_transition 2val-check", "1 Fail: ERROR");
         not_1_test_expr=3'b101;


         // INDEX:        - assert_no_underflow     (REVISIT: X-check)
         // =====
         // REVISIT: check X handling
         #100
         nou_1_test_expr=3'b001;
         #100 sim_info ("no_underflow min 2val-check", "1 Fail: ERROR");
         nou_1_test_expr=3'b000;
         #100
         nou_1_test_expr=3'b001;
         #100 sim_info ("no_underflow max 2val-check", "1 Fail: ERROR");
         nou_1_test_expr=3'b111;


         // INDEX:        - assert_quiescent_state  (REVISIT: EOS + X-check)
         // =====
         // REVISIT: check X handling
         // REVISIT: need EOS config in assert_every_config
         #100 sim_info ("quiescent_state 2val-check", "1 Fail: ERROR");
         qst_1_sample_event=1'b1;


         // INDEX:        - assert_transition       (REVISIT: X-check)
         // =====
         // REVISIT: check X handling
         #100
         trn_1_test_expr=3'b100;
         #100
         #100 sim_info ("transition 2val-check", "1 Fail: ERROR");
         trn_1_test_expr=3'b000;


         //-------------------------------------------------------------------
         // INDEX:   5) Test n-Cycle OVLs
         //-------------------------------------------------------------------


         // INDEX:        - assert_change           (REVISIT: 2 more configs + X-check)
         // =====
         // REVISIT: check other 2 configs
         // REVISIT: check X handling
         #100
         chg_1_start_event=1'b1; chg_1_test_expr=8'h5A;
         #300
         chg_1_test_expr=8'hA5;
         //
         // Change above happened on last cycle (just in time), but not
         // resampled then (resampled in next cycle).
         //
         #100
         chg_1_test_expr=8'h00;
         #400 sim_info ("change 2val-check", "1 Fail: ERROR");
         chg_1_start_event=1'b0;


         // INDEX:        - assert_cycle_sequence   (REVISIT: 2 more configs + X-check)
         // =====
         // REVISIT: check other 2 configs
         // REVISIT: check X handling
         #100
         csq_1_event_sequence[2]=1'b1;
         #100
         csq_1_event_sequence[1]=1'b1;
         #100 sim_info ("cycle_sequence 2val-check", "1 Fail: ERROR");
         #100
         csq_1_event_sequence=3'b001; // no fail on 2nd in pipeline


         // INDEX:        - assert_frame            *TBD*
         // =====


         // INDEX:        - assert_handshake        *TBD*
         // =====


         // INDEX:        - assert_next             (REVISIT: 2 more configs + X-check)
         // =====
         // REVISIT: check other 2 configs
         // REVISIT: check X handling
         #100
         nxt_1_start_event=1'b1;
         #100 sim_info ("next 2val-check", "1 Fail: ERROR");
         nxt_1_start_event=1'b0; nxt_1_test_expr=1'b0;


         // INDEX:        - assert_time             (REVISIT: 2 more configs + X-check)
         // =====
         #100
         tim_1_start_event=1'b1; tim_1_test_expr=1'b0;
         #100
         tim_1_test_expr=1'b1;
         #400 sim_info ("time 2val-check", "1 Fail: ERROR");
         tim_1_start_event=1'b0; tim_1_test_expr=1'b0;


         // INDEX:        - assert_unchange         (REVISIT: 2 more configs + X-check)
         // =====
         #100
         unc_1_start_event=1'b1; unc_1_test_expr=8'hA5;
         #400 sim_info ("unchange 2val-check", "1 Fail: ERROR");
         unc_1_start_event=1'b0; unc_1_test_expr=8'h5A;


         // INDEX:        - assert_width            (REVISIT: 3 more configs + X-check)
         // =====
         #100
         wid_1_test_expr=1'b1;
         #300 sim_info ("width 2val-check", "1 Fail: ERROR");
         wid_1_test_expr=1'b0;


         //-------------------------------------------------------------------
         // INDEX:   6) Test Event-Bound OVLs
         //-------------------------------------------------------------------


         // INDEX:        - assert_win_change       (REVISIT: X-check)
         // =====
         // REVISIT: check X handling
         //
         // 1) Before end_event
         #100
         wch_1_start_event=1'b1; wch_1_test_expr=8'hA5;
         #100
         wch_1_start_event=1'b0; wch_1_test_expr=8'h5A;
         #100
         wch_1_end_event=1'b1;
         #100
         wch_1_end_event=1'b0;
         //
         // 2) With end_event
         #100
         wch_1_start_event=1'b1;
         #100
         wch_1_start_event=1'b0;
         #100
         wch_1_end_event=1'b1; wch_1_test_expr=8'h00; wch_1_start_event=1'b1;
         //
         // 3) Overlap (should have ignored last start_event - no fail expected)
         #100
         wch_1_end_event=1'b1; wch_1_start_event=1'b0;
         #100
         wch_1_end_event=1'b0;
         //
         // 4) Failure
         #100
         wch_1_start_event=1'b1;
         #100
         wch_1_start_event=1'b0;
         #100 sim_info ("win_change 2val-check", "1 Fail: ERROR");
         wch_1_end_event=1'b1;
           

         // INDEX:        - assert_window           (REVISIT: X-check)
         // =====
         // REVISIT: check X handling
         //
         // 1) Deassert just after end_event (should pass)
         #100
         win_1_start_event=1'b1; win_1_test_expr=1'b0; // Does not have to be high here
         #100
         win_1_start_event=1'b0; win_1_test_expr=1'b1;
         #100
         win_1_end_event=1'b1;
         #100
         win_1_end_event=1'b0; win_1_test_expr=1'b0;
         //
         // 2) No change
         #100
         win_1_test_expr=1'b1;
         #100
         win_1_start_event=1'b1;
         #100
         win_1_start_event=1'b0;
         #100
         win_1_end_event=1'b1; win_1_start_event=1'b1;
         //
         // 3) Overlap (should have ignored last start_event - no fail expected)
         #100
         win_1_end_event=1'b1; win_1_test_expr=1'b0; win_1_start_event=1'b0;
         #100
         win_1_end_event=1'b0; win_1_start_event=1'b0;
         //
         // 4) Failure #1: change before end_event
         #100
         win_1_start_event=1'b1; win_1_test_expr=1'b0; // Does not have to be high here
         #100
         win_1_start_event=1'b0; win_1_test_expr=1'b1;
         #100 sim_info ("window before-end 2val-check", "3 Fail: ERROR");
         win_1_test_expr=1'b0;
         #100
         win_1_test_expr=1'b0;
         #100
         win_1_test_expr=1'b0; win_1_end_event=1'b1;
         #100
         win_1_end_event=1'b0; win_1_start_event=1'b0;
         //
         // 5) Failure #2: change at end_event
         #100
         win_1_start_event=1'b1; win_1_test_expr=1'b0; // Does not have to be high here
         #100
         win_1_start_event=1'b0; win_1_test_expr=1'b1;
         #100 sim_info ("window at-end 2val-check", "1 Fail: ERROR");
         win_1_end_event=1'b1; win_1_test_expr=1'b0;
         #100
         win_1_end_event=1'b0; win_1_start_event=1'b0;


         // INDEX:        - assert_win_unchange     (REVISIT: X-check)
         // =====
         // REVISIT: check X handling
         //
         // 1) Change just after end_event (should pass)
         #100
         wuc_1_start_event=1'b1; wuc_1_test_expr=8'hA5;
         #100
         wuc_1_start_event=1'b0;
         #100
         wuc_1_end_event=1'b1;
         #100
         wuc_1_end_event=1'b0; wuc_1_test_expr=8'h00;
         //
         // 2) No change
         #100
         wuc_1_test_expr=8'hFF;
         #100
         wuc_1_start_event=1'b1;
         #100
         wuc_1_start_event=1'b0;
         #100
         wuc_1_end_event=1'b1; wuc_1_start_event=1'b1;
         //
         // 3) Overlap (should have ignored last start_event - no fail expected)
         #100
         wuc_1_end_event=1'b1; wuc_1_test_expr=8'hA5; wuc_1_start_event=1'b0;
         #100
         wuc_1_end_event=1'b0; wuc_1_start_event=1'b0;
         //
         // 4) Failure #1: change before end_event
         #100
         wuc_1_start_event=1'b1;
         #100
         wuc_1_start_event=1'b0;
         #100 sim_info ("win_unchange before-end 2val-check", "3 Fail: ERROR");
         wuc_1_test_expr=8'h00;
         #100
         wuc_1_test_expr=8'h01;
         #100
         wuc_1_test_expr=8'h02; wuc_1_end_event=1'b1;
         #100
         wuc_1_end_event=1'b0; wuc_1_start_event=1'b0;
         //
         // 5) Failure #2: change at end_event
         #100
         wuc_1_start_event=1'b1;
         #100
         wuc_1_start_event=1'b0;
         #100 sim_info ("win_unchange at-end 2val-check", "1 Fail: ERROR");
         wuc_1_end_event=1'b1; wuc_1_test_expr=8'h5A;
         #100
         wuc_1_end_event=1'b0; wuc_1_start_event=1'b0;


         //-------------------------------------------------------------------
         // INDEX:   7) Finish Stuff
         //-------------------------------------------------------------------


         // INDEX:        - EOS checks
         // =====
         #10000 sim_info ("simulation_done=1'b1", "2 fail: ERROR (_EOS)");
         simulation_done=1'b1;
         #100

         // INDEX:        - Final OVL metrics (*** COMMENTED OUT FOR NOW ***)
         // =====
         `ifdef OVL_COUNTER
//           $display("# OVL_METRICS : %d OVL firings reported during completed simulation", `OVL_COUNTER);
         `endif

         $display ("");
         $display ("");
         $display ("INDEX: |==========|==========================================|==========================================|");
      end


   // ----------------------------------------------------------------------
   // INDEX:
   // INDEX: Stop via OVL_FATAL
   // ----------------------------------------------------------------------
   initial
     begin
        #199800 sim_info ("never 2val-check", "1 fail: FATAL");
        nvr_1_test_expr=1'b1;
        #100
        nvr_1_test_expr=1'b0;
        #1000 ;
       // #5000000;
	$finish;
     end


 initial 
 begin
  $shm_open("waves.shm") ;
  $shm_probe("AC")       ;
 end

bind DUT assertion_checker checker(  clk, clk2,reset_n,
   					nua_1_test_expr,
   					prp_1_test_expr,
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
                                        wuc_1_start_event, wuc_1_end_event, wuc_1_test_expr);
endmodule // tb_assert_simulation
