// ===========================================================
// DFFC_Tst:  A Lab21 testbench for the Lab08 DFFC.
// The clock period gradually decreases from 10 ns to 10 ps.
//
// ------------------------------------------------------------
// 2007-11-05 jmw: v. 1.21 Minor comment change.
// 2005-09-12 jmw: v. 1.2 Simplified timescale `defines.
// 2005-05-12 jmw: v. 1.1 Added `defines.
// 2005-02-13 jmw: v. 1.0 Implemented.
// ============================================================
//
// Uncomment only 1 at at time:
// `define Step6 1
// `define Step7A 1
// `define Step7B 1
// `define Step7C 1
// `define Step8A 1
// `define Step8B 1
// `define Step8C 1
// `define Step9  1
// `define Step10A 1
// `define Step10B 1

//
`ifdef Step8C
 //`timescale 10ns/1ns
 //`timescale 10ns/100ps
`timescale 10ns/10ps
`else
`timescale 1ns/1ps
`endif
//
module DFFC_Tst;
//
wire QWatch, Qn_to_D;
reg ClkStim, ClrStim, tClkGen;
real tClk;
//
// The Clr generator:
always@(ClrStim) #25 ClrStim <= ~ClrStim;
//
// The Clk delay generator:  Runs at 10 ps period.
// Gradually decreases the clock period from
// 10 ns to 10 ps:
always@(tClkGen)
  begin
  #0.005 tClkGen <= ~tClkGen; // period = 10 ps.
  tClk <= tClk - tClk*0.00001; // shorten the clock period.
  if ( tClk < 0.005) $finish; // 5 ps.
  end
//
// The Clk generator:
always@(ClkStim) #tClk ClkStim <= ~ClkStim;
//
initial
  begin
  #0     tClk    = 5.000; // 5 ns initial delay.
         tClkGen = 1'b0;
  #1     ClrStim = 1'b0;  // Shift into the D level.
  #1     ClkStim = 1'b0;
  #4000  $finish;   // Just in case.
  end
//
DFFC U1 ( .Q(QWatch), .Qn(Qn_to_D)
        , .D(Qn_to_D), .Clk(ClkStim), .Clr(ClrStim) 
        );
//
endmodule // DFFC_Tst.
