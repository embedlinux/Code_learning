// ===========================================================
// SerializerTst: Testbench for the Ser half of the SerDes.
// ------------------------------------------------------------
// 2006-06-01 jmw: v. 1.0 Implemented.
// ============================================================
//
`include "../SerDes.inc"  // timescale & period delays.
//
module SerializerTst;
localparam DWid = 32 // Width of parallel-data word.
         , AWid =  5; // 32 addresses deep.
//
// Get the pad formats:
`include "../SerDesFormats.inc"
//
wire SerOutWatch, SerValidWatch
	, FIFOEmptyWatch, FIFOFullWatch
	, SerClkWatch;
//
reg[DWid-1:0] ParInStim;
reg InParValidStim, ParInClkStim, ResetStim;
//
// The Serializer parallel clock must run at 1 MHz; 
// parallel data will be input to the FIFO only at half 
// the implied 32 Mb/s rate because of the frame padding.
// Allow for frequency drift here, for later testing:
// Can't use localparam; need fractions:
//
`define ParHalfT `HalfPeriod32BitBus
`define LimitT   1.0
`define DeltaT   0.05
//
real ParClkDelay     // tb current value.
   , MaxDelay = `ParHalfT + `LimitT   // Upper limit.
   , MinDelay = `ParHalfT - `LimitT;  // Lower limit
reg Direction        // Latches direction of Incr.
  , SendSerialStim;  // Enables FIFO output to be nonzero.
//
// Update the stimulus delay occasionally:
//
initial ParClkDelay = `ParHalfT;
//
always@(posedge ParInClkStim, posedge ResetStim)
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
//
// Generate the parallel clock:
always@(ParInClkStim) 
  begin : ParClockGen
  #(ParClkDelay) ParInClkStim <= ~ParInClkStim;
  end
//
// Clock in some parallel data:
always@(posedge ParInClkStim, posedge ResetStim)
  begin : ParDataGen
  reg[1:0] ToggleR;
  if (ResetStim==1'b1)
       begin
       ParInStim = 'b0;
       ToggleR   = 'b0;
       end
  else begin
       ToggleR = ToggleR + 2'b01;
       if (ToggleR==2'b10)
         ParInStim = $random;
       end
  end
//
initial
  begin
           InParValidStim = 1'b0;
             ParInClkStim = 1'b0;
                ResetStim = 1'b1;
           SendSerialStim = 1'b1;
  #7       InParValidStim = 1'b1;
  #1000         ResetStim = 1'b0;
  //
  #15000   InParValidStim = 1'b0;
  #52117   InParValidStim = 1'b1;
  #100000  SendSerialStim = 1'b0;
  //
  #30000  $finish;
  end
//
// ---------------------------------------------------------
Serializer #( .DWid(DWid), .AWid(AWid) ) 
   Ser_U1
  ( .SerOut(SerOutWatch), .SerValid(SerValidWatch)
  , .FIFOEmpty(FIFOEmptyWatch), .FIFOFull(FIFOFullWatch)
  , .SerClk(SerClkWatch) 
  , .ParIn(ParInStim), .InParValid(InParValidStim)
  , .ParInClk(ParInClkStim), .SendSerial(SendSerialStim)
  , .Reset(ResetStim)
  );
endmodule // SerializerTst.
//

