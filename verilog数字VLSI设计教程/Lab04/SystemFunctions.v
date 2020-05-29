// ===========================================================
// SystemFunctions:  Miscellaneous string and simulator
// console message operations.
//
// ------------------------------------------------------------
// 2005-11-02 jmw: v. 1.1 Minor comment change.
// 2004-12-02 jmw: v. 1.0 implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module SystemFunctions;
  //
  reg Clk, Sig;
  //
  always@(posedge Clk)
    begin
    if (Clk!==Sig) // "!==" sees x and z differences.
      $strobe("\n**** Simulation time=%04d.  Compare Clk=[%01b] and Sig=[%01b] failed.\n"
             , $time, Clk, Sig);
    //
    end
  //
  initial
    begin
       Clk = 1'b0;
       Sig = 1'bz;
    #2 Clk = 1'b1;
    #2 Clk = 1'b0;
    //
    #10 ;
    Sig = 1'b0;
    //
    #2 Clk = 1'b1;
    #2 Clk = 1'b0;
    #10 $finish;
    end
  //
endmodule // SystemFunctions.
