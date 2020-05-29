// ===========================================================
// PLLsync: The PLL driver module from Lab08, which used
// the Lab06 PLL output to clock three counters.
// This design only includes the behavioral counter from Lab08.
//
// This file contains various timing check solutions for Lab20.
// ------------------------------------------------------------
// 2005-09-02 jmw: v. 2.4 Renamed from PLLSync to PLLsync.
// 2005-02-24 jmw: v. 2.3 Declared SyncPLL a wire for tc's.
// 2005-02-12 jmw: v. 2.2 Copied ClockedByPLL from Lab08 to the
//            Lab20 directory.
// 2005-02-12 jmw: v. 2.1 Used `include for macro defines;
//            replaced old design with revised synthesis design.
// 2005-01-28 jmw: v. 2.0 Added Reset for redesigned 
//            ClockComparator.  Removed SyncPLL sampling oscillator
//            and replaced it by a clock-synchronized counter.
// 2004-12-20 jmw: v. 1.0 implemented.
// ============================================================
//
// Uncomment one at a time:
`define Step1 1
// `define Step2 1
// `define Step3 1
// `define Step4 1
// `define Step5 1
//
//
`include "PLL/PLLTop.inc"
//
module PLLsync (output[3:0] Behavioral, input ClockIn, ClearIn);
//
reg      SyncPLLReg;
wire PLLClockOut, SyncPLL;
//
assign SyncPLL = SyncPLLReg;
//
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
        SyncPLLReg = 1'b0;
   else begin
        #50  SyncPLLReg = 1'b1;
        #100 SyncPLLReg = 1'b0;
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
`ifdef Step1
`else
specify
`ifdef Step2
  specparam MinSample_SyncPLL  =   5;
  $setup(Behavioral, posedge SyncPLL, MinSample_SyncPLL);
`endif
`ifdef Step3
  specparam MinSample_SyncPLL  =   0;
  specparam MinSyncPLL_Sample  =   8;
  $setup(Behavioral, posedge SyncPLL, MinSample_SyncPLL);
  $hold (posedge SyncPLL, Behavioral, MinSyncPLL_Sample);
`endif
`ifdef Step4
  specparam MinSample_SyncPLL  =   0;
  specparam MinSyncPLL_Sample  =   0;
  specparam MinClearIn_ClockIn = 100;
  specparam MinClockIn_ClearIn = 100;
  //
  $setup(Behavioral, posedge SyncPLL, MinSample_SyncPLL);
  $hold (posedge SyncPLL, Behavioral, MinSyncPLL_Sample);
  $recovery(negedge ClearIn, posedge ClockIn, MinClearIn_ClockIn);
  $removal (posedge ClockIn, negedge ClearIn, MinClockIn_ClearIn);
`endif
`ifdef Step5
  specparam MinSample_SyncPLL  =   0;
  specparam MinSyncPLL_Sample  =   0;
  specparam MinClearIn_ClockIn = 100; // 100;
  specparam MinClockIn_ClearIn = 100; // 100;
  specparam MinClearInLo       = 100; // 100;
  specparam MinPLLClkPeriod    =  30; // 30;
  // specparam LeadSampleNoChange =  0;
  // specparam LagSampleNoChange  =  0;
  //
  $setup(Behavioral, posedge SyncPLL, MinSample_SyncPLL);
  $hold (posedge SyncPLL, Behavioral, MinSyncPLL_Sample);
  $recovery(negedge ClearIn, posedge ClockIn, MinClearIn_ClockIn);
  $removal (posedge ClockIn, negedge ClearIn, MinClockIn_ClearIn);
  $width(negedge ClearIn, MinClearInLo);
  $period(posedge PLLClockOut, MinPLLClkPeriod);
  // $nochange(posedge ClockIn, SyncPLL
  //          , LeadSampleNoChange, LagSampleNoChange); 
`endif
//
  //
endspecify
`endif // Step1.
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
    #465   ClearStim   = 1'b1;
    #500   ClearStim   = 1'b0;
    #50    ClearStim   = 1'b1;
    #500   ClearStim   = 1'b0;
    #25000 $finish;
    end
  //
endmodule // PLLsyncTst.
`endif // DC.

