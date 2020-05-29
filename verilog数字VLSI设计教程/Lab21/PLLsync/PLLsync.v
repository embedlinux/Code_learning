// ===========================================================
// PLLsync: The PLL driver module from Lab08, which used
// the Lab06 PLL output to clock three counters.
// This design only includes the behavioral counter from Lab08.
// ------------------------------------------------------------
// 2005-09-02 jmw: v. 2.3 Renamed PLLSync to PLLsync.
// 2005-02-12 jmw: v. 2.2 Copied ClockedByPLL from Lab08 to Lab20.
// 2005-02-12 jmw: v. 2.1 Used `include for macro defines;
//            replaced old design with revised synthesis design.
// 2005-01-28 jmw: v. 2.0 Added Reset for redesigned 
//            ClockComparator.  Removed SyncPLL sampling oscillator
//            and replaced it by a clock-synchronized counter.
// 2004-12-20 jmw: v. 1.0 implemented.
// ============================================================
//
`include "PLL/PLLTop.inc"
//
module PLLsync (output[3:0] Behavioral, input ClockIn, ClearIn);
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
          SyncPLL = 1'b0;
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
  Counter4   Behaver( .CountOut(Behavioral), .ClockIn(PLLClockOut)
                    , .Clear(ClearIn) );
  //
endmodule // PLLsync.
//
// ----------------------------------------------------------------
// Simulation Testbench supplies PLL with exact clock
// frequency:
//
`ifdef DC
`else
module PLLsyncTst;
  //
  reg  ClockStimIn, ClearStim;
  wire[3:0] BehavioralWatch;
  //
  PLLsync Beh_U1
    ( .Behavioral(BehavioralWatch)
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
    #25000 $finish;
    end
  //
endmodule // PLLsyncTst.
`endif

