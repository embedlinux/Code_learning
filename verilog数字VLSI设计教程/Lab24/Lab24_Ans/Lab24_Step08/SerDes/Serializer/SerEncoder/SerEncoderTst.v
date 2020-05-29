// ===========================================================
// SerEncoderTst: Testbench for the SerEncoder module of
// the Serializer.
// ------------------------------------------------------------
// 2006-06-12 jmw: v. 1.1 Added FIFO Empty & *.inc refs.
// 2006-06-11 jmw: v. 1.0 Implemented.
// ============================================================
//
`include "SerDes.inc"  // timescale & period delays.
//
module SerEncoderTst;
localparam DWid = 32; // Width of parallel-data word.
//
// Get the pad formats:
`include "SerDesFormats.inc"
//
wire SerOutWatch, SerValidWatch, ReadReqWatch;
//
reg[DWid-1:0] ParInStim;
reg F_EmptyStim, ParClkr, SerClkr
  , ParValidStim, ResetStim;
//
// The Serializer parallel clock must run at 1 MHz; 
// parallel data will be input to the FIFO only at half 
// the implied 32 Mb/s rate because of the frame padding.
// Allow for frequency drift here, for later testing:
// Can't use localparam; need fractions:
//
`define ParHalfT `HalfPeriod32BitBus
`define LimitT 0.25
`define DeltaT 0.05
//
real ParClkDelay                     // tb current value.
   , MaxDelay = `ParHalfT + `LimitT  // Upper limit.
   , MinDelay = `ParHalfT - `LimitT; // Lower limit.
reg Direction;       // Latches direction of Incr.
//
real SerClkDelay;  //  Derived from parallel clock delay.
//
// Update the stimulus delay occasionally:
//
//
always@(posedge ParClkr, posedge ResetStim)
  begin : ParDelaygen
  reg[2:0] Counter;
  if (ResetStim==1'b1)
       begin
       Counter     <=  'b0;
       Direction   <= 1'b1; // 1 is up, 0 is down.
       ParClkDelay <= `ParHalfT;
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
// Generate the two correlated clocks:
//
reg[4:0] SerClkCounter; // Assumes 32 serial clocks/parallel clock.
//
// compute the serial clock delay:
always@(ParClkDelay)  SerClkDelay = ParClkDelay/32.0;
//
// Derive the serial clock:
always@(SerClkr, ResetStim) 
  begin : ClockGen
  if (ResetStim==1'b1)
       begin
       ParClkr       <= 1'b0;
       SerClkr       <= 1'b0;
       SerClkCounter <=  'b0;
       end
  else begin
       #(SerClkDelay) SerClkr <= !SerClkr;
       SerClkCounter <=  SerClkCounter + 5'b1;
       if (SerClkCounter==5'h0)
         ParClkr <= !ParClkr;
       end
  

  end
//
// Clock in some parallel data:
reg DivParClkBy2;
always@(posedge ParClkr, posedge ResetStim)
  begin : ParDataGen
  if (ResetStim==1'b1)
       begin
       ParInStim    <= 'b0;
       DivParClkBy2 <= 'b0;
       end
  else begin
       DivParClkBy2 <= !DivParClkBy2;
       if (DivParClkBy2==1'b1)
         #5 ParInStim <= $random;
       end
  end
//

// --------------------------------------------------
// SimVerify block:  This block is just to make packet
// format verification easy:
//
reg[DWid*2-1:0] Packet;
reg[5:0] Ix;
//
always@(negedge SerClkr, posedge ResetStim)
  begin : SimVerify
  if (ResetStim==1'b1)
       begin
       Ix         <= 6'h0;
       Packet[Ix] <= 'b0;
       end
  else begin
       Ix         <= Ix - 6'h1;
       Packet[Ix] <= SerOutWatch;
       end
  end
//
initial
  begin
  ParInStim    = 'b0;
  F_EmptyStim  = 'b0;
  ParValidStim = 1'b0;
  ResetStim    = 1'b0;
  ParClkDelay  = `ParHalfT;
  SerClkDelay  = ParClkDelay/32.0;
  //
  #611    ResetStim    = 1'b1;
  #2000   ResetStim    = 1'b0;
  //
  #5000   ParValidStim = 1'b1;
  #15000  ParValidStim = 1'b0;
  #2000   ParValidStim = 1'b1;
  #15000  F_EmptyStim  = 1'b1;
  #5000   F_EmptyStim  = 1'b0;
  //
  #20000  $finish;
  end
//
// ---------------------------------------------------------
SerEncoder #( .DWid(DWid) ) 
SerEnc_Tx1 ( .SerOut(SerOutWatch), .SerValid(SerValidWatch)
           , .FIFO_ReadReq(ReadReqWatch)
           , .ParIn(ParInStim), .F_Empty(F_EmptyStim) 
           , .ParClk(ParClkr), .SerClk(SerClkr) 
           , .ParValid(ParValidStim), .Reset(ResetStim)
           );
endmodule // SerEncoderTst.
//

