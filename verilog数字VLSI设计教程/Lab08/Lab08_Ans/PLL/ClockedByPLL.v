// ===========================================================
// ClockedByPLL: Combined counter models, all clocked by the
// Lab06 PLL output.
// ------------------------------------------------------------
// 2005-02-12 jmw: v. 2.1 Used `include for macro defines;
//            replaced old design with revised synthesis design.
// 2005-01-28 jmw: v. 2.0 Added Reset for redesigned 
//            ClockComparator.  Removed SyncPLL sampling oscillator
//            and replaced it by a clock-synchronized counter.
// 2004-12-20 jmw: v. 1.0 implemented.
// ============================================================
//
`include "PLLTop.inc"
//
module ClockedByPLL (output[3:0] Ripple, Synchronous, Behavioral
                    , input ClockIn, ClearIn);
  //
  reg      SyncPLL;
  wire PLLClockOut;
  // -------------------------------------------------
  // PLL instance stuff:
  //
  // Generate occasional sample pulse for PLL instance
  // This could be in the testbench, of course.   Putting
  // an oscillator in a design module can be dangerous,
  // because the synthesizer might do anything with it;
  // however, it doesn't matter for simulation:
  always@(posedge ClockIn, posedge ClearIn)
    begin : Sampler
    if (ClearIn==1'b1)
          begin
          SyncPLL = 1'b0;
          end
     else begin
          #50  SyncPLL = 1'b1;
          #100 SyncPLL = 1'b0;
          end
    end
  //
  PLLTop PLLClocker( .ClockOut(PLLClockOut), .ClockIn(ClockIn)
                   , .Sample(SyncPLL), .Reset(ClearIn) );
  // -------------------------------------------------
  // Counter instances:
  //
  Ripple4DFF Rippler( .CountOut(Ripple), .ClockIn(PLLClockOut)
                    , .ClearIn(ClearIn) );
  Synch4DFF  Syncher( .CountOut(Synchronous), .ClockIn(PLLClockOut)
                    , .ClearIn(ClearIn) );
  Counter4   Behaver( .CountOut(Behavioral), .ClockIn(PLLClockOut)
                    , .Clear(ClearIn) );
  //
endmodule // ClockedByPLL.
//
// ----------------------------------------------------------------
// Simulation Testbench supplies PLL with exact clock
// frequency:
//
`ifdef DC
`else
module ClockedByPLLTst;
  //
  reg  ClockStimIn, ClearStim;
  wire[3:0] RippleWatch, SynchronousWatch, BehavioralWatch;
  //
  ClockedByPLL 
  AllCounterInst
    ( .Ripple(RippleWatch), .Synchronous(SynchronousWatch)
    , .Behavioral(BehavioralWatch)
    , .ClockIn(ClockStimIn), .ClearIn(ClearStim)
    );
  //
  always@(ClockStimIn)
     #`HalfPeriod32BitBus ClockStimIn <= ~ClockStimIn;
  //
  initial
    begin
    #0     ClearStim   = 1'b0;
    #0     ClockStimIn = 1'b0;
    #1     ClearStim   = 1'b1;
    #9     ClearStim   = 1'b0;
           ClockStimIn = 1'b1;
    #700   ClearStim   = 1'b1;
    #10    ClearStim   = 1'b0;
    #5500 $finish;
    end
  //
endmodule // ClockedByPLLTst.
`endif

