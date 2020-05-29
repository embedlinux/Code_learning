//
// ===========================================================
// EventCtlTst: Testbench:
//              Shows what happens when sensitivity list omits
//              a RHS variable.
//
// ------------------------------------------------------------
// 2006-09-21 jmw: 1.1 Removed unused *Full* wires.
// 2005-04-21 jmw: 1.0 implemented.
// ============================================================
//
`timescale 1ns/100ps
//
`ifdef DC
`else
module EventCtlTst;
//
reg aStim, bStim, cStim;
wire xPartWatch, yPartWatch
   , xOnlyWatch, yOnlyWatch, xOnePortWatch
   , xLatchWatch, yLatchWatch; 
//
initial
  begin
  #0  aStim = 1'b0;
      bStim = 1'b0;
      cStim = 1'b0;
  #5  aStim = 1'b1;
  #5  bStim = 1'b1;
  #5  cStim = 1'b1;
  #5  aStim = 1'b0;
  #2  aStim = 1'b1;
  #3  aStim = 1'b0;
  #5  cStim = 1'b0;
  #5  bStim = 1'b0;
  #15 bStim = 1'b1;
  #5  aStim = 1'b1;
  #5  cStim = 1'b1;
  #5  bStim = 1'b0;
  #5  aStim = 1'b0;
  #5  cStim = 1'b0;
  #5  bStim = 1'b0;
  #5  $finish;
  end
//
EventCtl Test_U1( .a(aStim), .b(bStim), .c(cStim)
               , .xPart(xPartWatch), .yPart(yPartWatch)
               , .xOnly(xOnlyWatch), .yOnly(yOnlyWatch)
               , .xOnePort(xOnePortWatch)
               , .xLatch(xLatchWatch)
               , .yLatch(yLatchWatch)
               );
//
endmodule // EventCtlTst.
`endif
