// ===========================================================
// SerDesTst: Testbench for the fully assembled SerDes.
// ------------------------------------------------------------
// 2006-06-05 jmw: v. 1.0 of SerDesTest created for Lab24
//      by copying from SerializerTst.v.
// ============================================================
//
`include "SerDes.inc"  // timescale & period delays.
//
module SerDesTst;
localparam DWid = 32
         , AWid = 5; // 32 addresses deep.
//
wire[DWid-1:0] RcvrDomainOut, SendDomainOut;
wire SerDataXferWatch;
//
reg[DWid-1:0] InParStim;
reg InParValidStim, InParClkStim
  , OutParClkStim, RxRequestStim, TxRequestStim
  , ResetStim;
//
// The Serializer parallel clock must run at 1 MHz; 
// parallel data will be input to the FIFO only at half 
// the implied 32 Mb/s rate because of the frame padding.
// Allow for frequency drift here, for later testing:
// Can't use localparam; need fractions:
//
`define ParHalfT `HalfPeriod32BitBus
`define LimitT   1.0  // Max excursion will be 2 ns in period.
`define DeltaT   1.0
//
real ParClkDelay     // tb current value.
   , MaxDelay = `ParHalfT + `LimitT   // Upper limit.
   , MinDelay = `ParHalfT - `LimitT;  // Lower limit
reg Direction;       // Latches direction of Incr.
//
// Update the stimulus delay occasionally:
//
initial ParClkDelay = `ParHalfT;
always@(posedge InParClkStim, posedge ResetStim)
  begin : ParDelaygen
  reg[2:0] Counter;
  if (ResetStim==1'b1)
       begin
       Counter   <=  'b0;
       Direction <= 1'b1; // 1 is up, 0 is down.
       end
  else begin : ParDelayCalc
       Counter <= Counter + 3'h1;
       if (Counter==3'h2)
         case (Direction)
          1'b0  : begin
                  ParClkDelay <= ParClkDelay - `DeltaT;
                  if (ParClkDelay<MinDelay)
                    Direction <= 1'b1;
                  end
         default: begin
                  ParClkDelay <= ParClkDelay + `DeltaT;
                  if (ParClkDelay>MaxDelay)
                    Direction <= 1'b0;
                  end
         endcase
       end
  end
// -------------------------------------------------
// Generate the parallel Tx clock:
always@(InParClkStim) 
  begin : ParClockGen
  #(ParClkDelay) InParClkStim <= ~InParClkStim;
  end
//
// Clock in some parallel data:
always@(posedge InParClkStim, posedge ResetStim)
  begin : ParDataGen
  reg ToggleR;
  if (ResetStim==1'b1)
       begin
       InParStim =  'b0;
       ToggleR   = 1'b0;
       end
  else begin
       ToggleR = ~ToggleR;
       if (ToggleR==1'b0)
         InParStim = $random;
       end
  end
// -------------------------------------------------
// Generate the parallel Rx clock:
always@(OutParClkStim) 
  begin : OutParClockGen
  #(`HalfPeriod32BitBus*2)
    OutParClkStim <= ~OutParClkStim;
  end
//
// -------------------------------------------------
// Testbench control stimuli:
//
//`ifdef COMMENTED_OUT
initial
  begin
  $display("Total simulation time will be about 2,200,000 ns.\n This may take a couple of minutes.");
  #0  InParValidStim    = 1'b0;
      InParClkStim      = 1'b0;
      OutParClkStim     = 1'b0;
      ResetStim         = 1'b0;
      TxRequestStim     = 1'b0;
      RxRequestStim     = 1'b0;
  #1     ResetStim      = 1'b1;
  #449   ResetStim      = 1'b0;
  #501   ResetStim      = 1'b1;
  #449   ResetStim      = 1'b0;
  #7     InParValidStim = 1'b1;
  #500000 TxRequestStim = 1'b1;
  #800000 RxRequestStim = 1'b1;
  #800000 TxRequestStim = 1'b0;
  //
  #50000 $finish;
  end
//`endif
//
// ---------------------------------------------------------
SerDes #( .DWid(DWid), .AWid(AWid) ) 
SerDes_U1
   ( .ParOutRxClk(RcvrDomainOut) /*, .ParOutTxClk(SendDomainOut) */
   , .SerLineXfer(SerDataXferWatch)
   , .ParDataIn(InParStim)
   , .InParClk(InParClkStim), .InParValid(InParValidStim)
   , .OutParClk(OutParClkStim), .RxRequest(RxRequestStim)
   , .TxRequest(TxRequestStim), .Reset(ResetStim)
   );
//
endmodule // SerDesTst.
//

