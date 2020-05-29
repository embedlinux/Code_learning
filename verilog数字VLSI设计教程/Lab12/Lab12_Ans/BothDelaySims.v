// ===========================================================
// BothDelay:  Shows what happens with various delay statements
//             and with fork-joins.
//             Consists of just a testbench; no design.
//
// ------------------------------------------------------------
// 2006-09-21 jmw: Added answers according to QuestaSim (QS).
// 2005-04-19 jmw: Added answers according to VCS.
// 2005-01-03 jmw: 1.0 of implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module BothDelay;
  //
  reg  Regular1, Regular2
     , Scheduled1, Scheduled2
     , Both1, Both2
     , One, Zero;
  //
  initial
    begin
    fork
    #0 Regular1   = 1'b0;
    #0 Regular2   = 1'b0;
    #0 Scheduled1 = 1'b0;
    #0 Scheduled2 = 1'b0;
    #0 Both1      = 1'b0;
    #0 Both2      = 1'b0;
    #0 One   = 1'b1;
    #0 Zero  = 1'b0;
    join
    // end init.
    //
    fork
    #9 Regular1 = Zero;
    #0 Zero     = One;    // invert.
    join
                          // t=9 '1' appears on Zero!
                          // VCS & QS:  Zero has been '1' always;
                          // Regular1 goes to '1'.
    #1  Zero   = 1'b0;    // restore Zero to '0'.
                          // VCS:  Zero stays '1'.
                          // QS:   Zero glitches '0' & back to '1'.
    //
    fork
    #9 Regular2 <= Zero;
    #0 Zero     <= One;   // invert.
    join
                          // t=19 One appears on Regular2.
                          // VCS & QS agree; Zero has been '1'
                          // until now.
    #1  Zero   = 1'b0;    // restore.
                          // t=20:  Silos, VCS, & QS agree:
                          // Zero and One go to '0'.
    //
    fork
    Scheduled1  = #9 One;
    #0 One      = Zero;   // invert.
                          // t=20:  VCS: One goes to '0'
                          // and stays.
    join
                          // t=29:  Silos, VCS, & QS agree:
                          // One appears on Scheduled1.
    #1 One     = 1'b1;    // restore.
                          // t=30:  QS: One glitches to '1' &
                          //       returns to '0'.
                          // t=31:  VCS and QS agree:
                          //        Zero and One go to '1'.
    //
    fork
    Scheduled2 <= #9 One;
    #0 One     = Zero;    // invert.
    join
                          // t=39:  Silos, VCS, & QS agree that
                          //        '1' appears on Scheduled2.
    #1 One     = 1'b1;    // restore. 
    //
    //
    fork
    #9 Both1  = #9 Zero;
    #0 Zero   = One;
    join
                          // t=49:  Silos, VCS, & QS agree:
                          //        '1' appears on Both1.
    #1  Zero   = 1'b0;    // restore.
                          // VCS: Zero stays '1' for
                          // rest of sim.
                          // t=50:  QS says Zero glitches low
                          // but returns to '1' for rest of sim.
    //
    fork
    #9 Both2  <= #9 Zero;
    #0 Zero   <= One;     // invert.
    join
                          // t=68: Silos, VCS, & QS agree that
                          //       '1' appears on Both2 after 18.
    //
    #20 $finish;
    end
  //
endmodule //BothDelay.
