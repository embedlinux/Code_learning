// ===========================================================
// FullDupTst: Testbench for the fully assembled FullDup.
// ------------------------------------------------------------
// 2006-07-28 jmw: v. 1.0 of FullDupTst created for Lab26.
// ============================================================
//
`include "FullDup.inc"  // timescale & period delays.
//
module FullDupTst;
localparam DWid = 32; // Other params set in FD_U1
//
wire RxOK_AWatch, RxOK_BWatch;
wire[DWid-1:0] OutParDataAWatch, OutParDataBWatch;
//
reg[DWid-1:0]   InParDataAStim,   InParDataBStim;
//
reg ParValidAStim, ParValidBStim, ClockAStim
  , ClockBStim, ResetStim;
//
// Random number seeds:
integer SeedA, SeedB;
//
// --------- Clock frequency drifters: --------------------
//
// Can't use localparam; need fractions:
//
`define ParHalfT `HalfPeriod32BitBus
`define LimitT   1.0   // Max excursion will be 2 ns in period.
`define DeltaT   2.0
//
real ClkADelay, ClkBDelay             // tb current value.
   , MaxDelay = `ParHalfT + `LimitT   // Upper limit.
   , MinDelay = `ParHalfT - `LimitT;  // Lower limit
reg DirectionA, DirectionB;       // Latches direction of Incr.
//
// Update the stimulus delay occasionally:
//
// ClockA:
initial ClkADelay = `ParHalfT;
reg[2:0] CounterA;
always@(posedge ClockAStim, posedge ResetStim)
  begin : ClockADelayGen
  if (ResetStim==1'b1)
       begin
       CounterA   <= 3'b0;
       DirectionA <= 1'b1; // 1 is up, 0 is down.
       end
  else begin : ParDelayCalc
       CounterA <= CounterA + 3'b001;
       if (CounterA==3'b010)
         case (DirectionA)
          1'b0  : begin
                  ClkADelay <= ClkADelay - `DeltaT;
                  if (ClkADelay<MinDelay)
                    DirectionA <= 1'b1;
                  end
         default: begin
                  ClkADelay <= ClkADelay + `DeltaT;
                  if (ClkADelay>MaxDelay)
                    DirectionA <= 1'b0;
                  end
         endcase
       end
  end
//
// ClockB:
initial ClkBDelay = `ParHalfT - `DeltaT*4.0;  // Some A-B freq diff.
reg[2:0] CounterB;
always@(posedge ClockBStim, posedge ResetStim)
  begin : ClockBDelayGen
  if (ResetStim==1'b1)
       begin
       CounterB   <= 3'b0;
       DirectionB <= 1'b1; // 1 is up, 0 is down.
       end
  else begin : ParDelayCalc
       CounterB <= CounterB + 3'b001;
       if (CounterB==3'b010)
         case (DirectionB)
          1'b0  : begin
                  ClkBDelay <= ClkBDelay - `DeltaT;
                  if (ClkBDelay<MinDelay)
                    DirectionB <= 1'b1;
                  end
         default: begin
                  ClkBDelay <= ClkBDelay + `DeltaT;
                  if (ClkBDelay>MaxDelay)
                    DirectionB <= 1'b0;
                  end
         endcase
       end
  end
//
// --------- End Clock frequency drifters: ----------------

// --------- Clock and data generators: -------------------
// Generate the A clock:
always@(ClockAStim)
  begin : ClockAGen
  #(ClkADelay) ClockAStim <= ~ClockAStim;
  end
//
// Clock in some A data.   Each data word takes
// 2 clocks to transmit, so ToggleA divides by 2:
//
initial SeedA = 0;
always@(posedge ClockAStim, posedge ResetStim)
  begin : ParDataGenA
  reg ToggleA;
  if (ResetStim==1'b1)
       begin
       InParDataAStim <=  'b0;
       ToggleA        <= 1'b0;
       end
  else begin
       ToggleA        <= ~ToggleA;
       if (ToggleA==1'b0)
         InParDataAStim <= $random(SeedA);
       end
  end
// -------------------------------------------------
// Generate the B clock:
always@(ClockBStim)
  begin : ClockBGen
  #(ClkBDelay) ClockBStim <= ~ClockBStim;
  end
//
// Clock in some B data.   Each data word takes
// 2 clocks to transmit, so ToggleB divides by 2:
//
initial SeedB = 1;
always@(posedge ClockBStim, posedge ResetStim)
  begin : ParDataGenB
  reg ToggleB;
  if (ResetStim==1'b1)
       begin
       InParDataBStim <=  'b0;
       ToggleB        <= 1'b0;
       end
  else begin
       ToggleB        <= ~ToggleB;
       if (ToggleB==1'b0)
         InParDataBStim <= $random(SeedB);
       end
  end
//
// --------- End Clock and data generators: ---------------
//
// -------------------------------------------------
// Testbench control stimuli:
//
//`ifdef COMMENTED_OUT
initial
  begin
  #0    ParValidAStim = 1'b0;
        ParValidBStim = 1'b0;
        ClockAStim    = 1'b0;
        ResetStim     = 1'b0;
  #1    ResetStim     = 1'b1;
  #9    ClockBStim    = 1'b0;
  #440  ResetStim     = 1'b0;
  #501  ResetStim     = 1'b1;
  #1020 ResetStim     = 1'b0;
  #5000 ResetStim     = 1'b1;
  #1010 ResetStim     = 1'b0;
  #25   ParValidAStim = 1'b1;
  #25   ParValidBStim = 1'b1;
  //
  #300000 $finish;
  end
//`endif
//
// ---------------------------------------------------------
FullDup #( .DWid(DWid) ) // Other params use defaults in FullDup.
FD_U1 ( .OutParDataA(OutParDataAWatch)
      , .OutParDataB(OutParDataBWatch)
      , .InParDataA(InParDataAStim)
      , .InParDataB(InParDataBStim)
      , .InParValidA(ParValidAStim)
      , .InParValidB(ParValidBStim)
      , .ClockA(ClockAStim)
      , .ClockB(ClockBStim)
      , .Reset(ResetStim)
      );
//
endmodule // FullDupTst.
//

