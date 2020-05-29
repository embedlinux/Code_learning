// ===========================================================
// DFFGates:  A flip-flop with asynchronous clear, for
// use in shift register models of Lab 4.   Based on
// Palnitkar (2003) Fig. 6.4 (section 6.5.3).   Note that the
// Palnitkar implementation has inverted the Clr.
//
// This design groups pairs of nand gates into S-R latches,
// and then assembles the latches as follows, with 'x'
// representing the cross-connection between nand outputs
// and other-nand inputs:
//
//      +-----------------------+
//      |    +-------\          |
//  iS -+--S-+        \         |
//      |    x  NAND   Ox Q ----+- oS
//  is -+----+        /         |
//      |    +-------/          |
//      |                 S_R   |
//      |    +-------\          |
//  iR -+--R-+        \         |
//      |    x  NAND   Ox Qbar -+- oR
//  ir -+----+        /         |
//      |    +-------/          |
//      +-----------------------+
//
// This S-R latch model is in S_R.v.
//
// NOTE:  A file named "DFFGates.pdf" is in the Lab13_Ans
// directory with these two schematics drawn graphically;
// however, these character-based schematics still may be
// useful.
//
// 'i' is input (sometimes unused by being tied
// high in the instantiating module); 'o' is output.
//
/* Then, geometrically ordered as in the text,
  
              +--------+
        +-----+iS      |
        |     |      oS+---"sbar"
        |     |  S_R 1 |
ClrN  >---+---+iR    oR+-------+    +--------+
      +-------+ir      |   "s" +----+iS      |
      | | |   +--------+       |    |      oS+--> Q
      | | | +------------------+    |  S_R 3 |
      | | +-|-----------------------+iR      |
      | | | | +--------+        +---+ir    oR+--> Qn
      | | | +-+iS      |   "r"  |   +--------+
Clk >-+-------+is    oS+--------+   
        | |   |  S_R 2 |
        | +---+ir    oR+---+"rbar"
   D >--------+iR      |   |
        |     +--------+   |
        |                  |
        +------------------+
 */
// ------------------------------------------------------------
// 2005-12-20 jmw: v. 3.2 Comment ref to Palnitkar textbook.
// 2005-09-23 jmw: v. 3.1 Added ref to PDF schematic.
// 2005-09-07 jmw: v. 3.0 Added tb to fulfill assignment.
// 2005-01-06 jmw: v. 2.0 Renamed to DFFGates and reimplemented
//            at gate level for Lab12.   The S-R latch is
//            implemented in a different module.
// 2004-12-19 jmw: v. 1.1 Renamed to DFFC & timing for Lab08.
// 2004-12-04 jmw: v. 1.0  of ShiftFlop implemented.
// ============================================================
//
module DFFGates (output Q, Qn, input D, Clk, Clr);
//
wire Unused;
assign Unused = 1'b1;
//
wire from_oR1, from_oS2, from_oR2, Clrbar;
//
S_R SR1 ( .oS(/*unconn*/), .oR(from_oR1)
        , .iS(from_oR2), .is(Unused), .iR(Clrbar), .ir(Clk));
S_R SR2 ( .oS(from_oS2), .oR(from_oR2)
        , .iS(from_oR1), .is(Clk), .iR(D), .ir(Clrbar));
S_R SR3 ( .oS(Q), .oR(Qn)
        , .iS(from_oR1), .is(Unused), .iR(Clrbar), .ir(from_oS2));
//
not InvClr(Clrbar, Clr);
//
endmodule // DFFGates.
//
// Define next to test DFFGates alone:
`define DFF
//
`ifdef DFF
`ifdef DC
`else
module DffGatesTst;
  wire QWatch, QnWatch;
  reg  DStim, ClkStim, ClrStim;
  //
  always@(ClkStim) #10 ClkStim <= ~ClkStim;
  //
  initial
    begin
    #0   DStim   = 1'b0;
    #0   ClkStim = 1'b0;
    #0   ClrStim = 1'b0;
    #2   ClrStim = 1'b1;
    #10  ClrStim = 1'b0;
    #1   DStim   = 1'b1;
    #55  DStim   = 1'b0;
    #103 DStim   = 1'b1;
    #30  $finish;
    end
  //
  DFFGates U1 (.Q(QWatch), .Qn(QnWatch), .D(DStim), .Clk(ClkStim), .Clr(ClrStim));
  //
endmodule
`endif
`endif
//
