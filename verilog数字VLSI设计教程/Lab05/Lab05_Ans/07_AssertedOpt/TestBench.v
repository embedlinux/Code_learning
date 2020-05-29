// ===========================================================
// TestBench:  Simulation driver module (stimulus block) 
// for the top-level block instance of Intro_Top.
//
// No module port declaration.
// ------------------------------------------------------------
// 2006-04-19 jmw: v. 1.3 Added assertion to catch excessive
//            scanning, which triggers during the long scan
//            interval.
// 2006-04-18 jmw: v. 1.2 Added ScanIn for new chain, and mode
//            reversal to test the scan.  The Scan input is
//            clocked to produce variety.   Attached a wire
//            to the now-functional ScanOut.
// 2006-04-18 jmw: v. 1.1 Added ScanMode for new muxes.
// 2004-12-08 jmw: v. 1.0 implemented by copying from Lab01;
//            added FF scan clock stimulus.
// ============================================================
//
`timescale 1 ns/100ps
//
module TestBench;    // Stimulus blocks have no port.
//
reg  Astim, Bstim, Cstim, Dstim;  // To accept initialization.
reg  ClockStim, ClearStim         // For scan FFs.
  ,  ScanModeStim                 // For muxes.
  ,  ScanInStim;                  // For chain.
wire Xwatch, Ywatch, Zwatch       // To connect to design instance.
   , ScanOutWatch ;               // To watch ScanOut.
//
always@(ClockStim) #25 ClockStim <= ~ClockStim;
// 
// Scan stimulus:
always@(ScanInStim) #33 ScanInStim <= ~ScanInStim;
//
initial
  begin
  #0  ClockStim = 1'b0;
  #0  ClearStim = 1'b0;
  #0  ScanModeStim = 1'b0;
  #0  ScanInStim = 1'b0;
  #1  Astim = 1'b0;   // For Astim, 1 bit, representing a binary 0.
  #1  Bstim = 1'b0;
  #1  Cstim = 1'b0;
  #1  Dstim = 1'b0;
  #100 Astim = 1'b1; // Increased all data delays from #50 to #100.
  #100 Bstim = 1'b1;
  #100 Cstim = 1'b1;
  #100 Dstim = 1'b1;
  #100 Bstim = 1'b0;
  #100 Dstim = 1'b0;
  #100 Dstim = 1'b1;
  #100 Astim = 1'b0;
  #100 Cstim = 1'b0;
  #100 Dstim = 1'b0;
  // Now go to scan mode and repeat all stimuli:
  #100 ScanModeStim = 1'b1;
  #100 Astim = 1'b1;
  #100 Bstim = 1'b1;
  #100 Cstim = 1'b1;
  #100 Dstim = 1'b1;
  #100 Bstim = 1'b0;
  #100 Dstim = 1'b0;
  #100 Dstim = 1'b1;
  #100 Astim = 1'b0;
  #100 Cstim = 1'b0;
  #100 Dstim = 1'b0;
  // Back to normal mode:
  #50  ScanModeStim = 1'b0;
  #100 Astim = 1'b1;
  #100 Bstim = 1'b1;
  #100 Cstim = 1'b1;
  #100 Dstim = 1'b1;
  #100 Bstim = 1'b0;
  #100 Dstim = 1'b0;
  #100 Dstim = 1'b1;
  #100 Astim = 1'b0;
  #100 Cstim = 1'b0;
  #100 Dstim = 1'b0;
  #100 $finish;
  end
//
// ----------------------------------------
// The assertion and its trigger:  Assertion
// occurs when more than 8 scan clocks in a row
// are delivered.   Note that a $stop also could
// be triggered.
// If ScanMode or ScanClr is changed, the
// scan clock counter is reset.
//
reg[3:0] ShiftCount;
//
always@(posedge ClockStim)
  begin // Blocking assignments don't matter here:
  if (ClearStim==1'b0 && ScanModeStim==1'b1)
       begin
       ShiftCount = ShiftCount + 1;
       // The assertion:
       if (ShiftCount > 4'd8)
         begin
         $display
           ("*** Warning:  time=[%04d] scan shifted n=[%01d] but length=7"
           , $time, ShiftCount
           );
         ShiftCount = 4'd0;
         end
       end
  else ShiftCount = 4'd0;
  end // always.
//
// End assertion code.
// ----------------------------------------
//
// The instance of the design is named Top1:
//
Intro_Top Top1( .X(Xwatch), .Y(Ywatch), .Z(Zwatch)
              , .A(Astim),  .B(Bstim),  .C(Cstim), .D(Dstim)
              , .ScanClk(ClockStim), .ScanClr(ClearStim)
              , .ScanMode(ScanModeStim)
              , .ScanIn(ScanInStim)
              , .ScanOut(ScanOutWatch)
              );
//
endmodule // TestBench.
