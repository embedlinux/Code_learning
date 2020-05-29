// ===========================================================
// DeserializerTst: Testbench for the Des half of the SerDes.
// ------------------------------------------------------------
// 2006-05-23 jmw: v. 1.1 Initialized ParOutClkStim.
// 2006-05-23 jmw: v. 1.0 Newly implemented.
// ============================================================
//
// To relocate PLL VFO includes:
`define DeserializerTB
//
`include "Deserial.inc"  // timescale.
//
module DeserializerTst;
localparam DWid = 32
         , AWid = 5; // 5 -> 32 bits deep (default).
//
localparam PAD3 = 8'b000_11_000;
localparam PAD2 = 8'b000_10_000;
localparam PAD1 = 8'b000_01_000;
localparam PAD0 = 8'b000_00_000;
//
wire[DWid-1:0] ParOutWatch;
wire ParValidWatch
   , DecoderParClkWatch
   , EmptyWatch, FullWatch;
reg SerCkStim, SerialInStim, ParOutClkStim
  , ReadCmdStim, SerValidStim, ResetStim;
//
reg[DWid-1:0]     ParWordIn;
reg[AWid:0]       ShiftOutN;
reg[(2*DWid)-1:0] ShiftOut64;
//
// --------- End tb decs. ---------------------------------
//
// The parallel-output clock stimulus (1/2 MHz):
//
always@(ParOutClkStim)
  begin : ParallelClockGen
  #(`HalfPeriod32BitBus*2) ParOutClkStim <= ~ParOutClkStim;
  end
//
// The serial clock stimulus should be 32 MHz ~= 31.25 
// ns/cycle ~= 15.625 ns / half-cycle.  But, we can't do that
// without a lot of more stuff, so we shall settle for a
// period very close to the one our Serializer would have
// to use, anyway.   But, we'll put it a little off,
// anyway.   The farther off it is, the fewer valid
// parallel data will be transferred (more lost because
// of resync time; these would be resent in a more
// complicated and more robust design than ours):
//
always@(SerCkStim)
  begin : SerialClockGen
  #15.6 SerCkStim <= ~SerCkStim;
  end
//
// The frame formatter:  Load a SR and shift it
// out on the serial line:
//
always@(posedge SerCkStim, posedge ResetStim)
  begin : PacketGen
  if (ResetStim==1'b1)
       begin
       ShiftOutN  <= 'b0;
       ShiftOut64 <= 'b0;
       ParWordIn  <= 'b0;
       end
  else begin
       ShiftOutN <= ShiftOutN - 1; // Need wrapped downcount.
       //
       // Assign the serial bit:
       SerialInStim <= ShiftOut64[ShiftOutN];
       //
      if (ShiftOutN==64'h0) // Load new stimulus vector in 0 time:
        begin
        ParWordIn <= $random;
        ShiftOut64 <= { ParWordIn[31:24],PAD3
                      , ParWordIn[23:16],PAD2
                      , ParWordIn[15:08],PAD1
                      , ParWordIn[07:00],PAD0
                      };
        end
      end
  end // PacketGen.
//
`ifdef CHECK_SerValid
always@(posedge SerCkStim)
  begin
  // Exercise SerValid:
  if      ($time>52100 && $time<52250) #1 SerValidStim = 1'b0;
  else if ($time>54000 && $time<54150) #1 SerValidStim = 1'b0;
  else                                 #1 SerValidStim = 1'b1;
  end
  //
`endif
//
//
initial
  begin
  #0  ParOutClkStim = 1'b0;
  #0  ReadCmdStim   = 1'b0;
  #0  SerValidStim  = 1'b1;
  #0  SerialInStim  = 1'b0;
  #0  ShiftOut64    =  'b0;
  #0  ShiftOutN     = 64'h01;
  #0  SerCkStim     = 1'b0;
  #0  ResetStim = 1'b0;
  #1  ResetStim = 1'b1;
  #19 ResetStim = 1'b0;
  //
  // for FIFOFull: #2500000 ReadCmdStim = 1'b1;
  #2500000 ReadCmdStim = 1'b1;
  //
  #200000 $finish;
  end
//
// ---------------------------------------------------------
Deserializer #( .AWid(AWid), .DWid(DWid) )
DesU1
   ( .ParOut(ParOutWatch), .ParValid(ParValidWatch)
   , .DecoderParClk(DecoderParClkWatch) 
   , .FIFOEmpty(EmptyWatch), .FIFOFull(FullWatch)
   , .ParOutClk(ParOutClkStim), .SerialIn(SerialInStim)
   , .ReadReq(ReadCmdStim), .SerValid(SerValidStim)
   , .Reset(ResetStim)
   );
endmodule // Deserializer.
//

