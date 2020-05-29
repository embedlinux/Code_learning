// ===========================================================
// BothDelay:  Shows what happens with various delay statements.
//             Consists of just a testbench; no design.
//
//  Uses fork-join to change variable value concurrently.
//
// Answers are provided in comments in a file of the same name,
// in a subdirectory.
//
// ------------------------------------------------------------
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
                          // What appears?
    #1  Zero   = 1'b0;    // restore.
    //
    fork
    #9 Regular2 <= Zero;
    #0 Zero     <= One;   // invert.
    join
                          // What appears?
    #1  Zero   = 1'b0;    // restore.
    //
    //
    fork
    Scheduled1  = #9 One;
    #0 One      = Zero;   // invert.
    join
                          // What appears?
    #1 One     = 1'b1;    // restore.
    //
    fork
    Scheduled2 <= #9 One;
    #0 One     = Zero;    // invert.
    join
                          // What appears?
    #1 One     = 1'b1;    // restore.
    //
    //
    fork
    #9 Both1  = #9 Zero;
    #0 Zero   = One;
    join
                          // What appears?  And WHEN?
    #1  Zero   = 1'b0;    // restore.
    //
    fork
    #9 Both2  <= #9 Zero;
    #0 Zero   <= One;     // invert.
    join
                          // What appears?  And WHEN?
    //
    #20 $finish;
    end
  //
endmodule //BothDelay.
