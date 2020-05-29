// ===========================================================
// PLLTopTst: Testbench for the synthesizable PLL of Lab22.
// ------------------------------------------------------------
// 2005-05-17 jmw: v. 1.0 Copied from Lab21; removed everything
//      from old PLLsync module; moved Sample generator into
//      tb; changed dut name to PLLTop and named .Behavioral
//      pin to .ClockOut.  Named ClearIn pin to Reset; and,
//      added .Sample pin.
//      
// ============================================================
//
`include "Deserial.inc"
//
// ----------------------------------------------------------------
// Simulation Testbench supplies PLL with exact clock
// frequency:
//
module PLLTopTst;
//
reg  ClockStimIn, ClearStim, SamplePLLr;
wire PLLClockWatch;
//
always@(ClockStimIn)
   #`HalfPeriod32BitBus ClockStimIn <= ~ClockStimIn;
//
always@(posedge ClockStimIn, posedge ClearStim)
  begin : Sampler
  if (ClearStim==1'b1)
        SamplePLLr = 1'b0;
   else begin
        #50  SamplePLLr = 1'b1;
        #100 SamplePLLr = 1'b0;
        end
  end
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
PLLTop PLL_U1( .ClockOut(PLLClockOut), .ClockIn(ClockStimIn)
             , .Sample(SamplePLLr), .Reset(ClearStim) );
//
endmodule // PLLTopTst.

