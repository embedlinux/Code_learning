// ===================================================
// DesDecoderTst.  The SerDes Deserialization Decoder
//    testbench, copied from Lab16_Ans into its own
//    separate file.
// 
// ---------------------------------------------------
// 2006-05-19 jmw: v. 1.0 Copied from Lab16_Ans/
//      DesDecoder.v.   timescale to 1ns/1ps; removed
//      old `DC directives; reparameterized for DWid.
//      Renamed instance pins from ParBus to ParOut,
//      from ParRst to Reset.
//      Renamed tb temp to ParWordIn and reversed byte
//      ordering to make it more consistent with the
//      design (MSB == MSB).
// ===================================================
//
`timescale 1ns/1ps
//
module DesDecoderTst;
//
localparam DWid = 32;
//
localparam PAD3 = 8'b000_11_000;
localparam PAD2 = 8'b000_10_000;
localparam PAD1 = 8'b000_01_000;
localparam PAD0 = 8'b000_00_000;
//
wire[DWid-1:0] ParOutWatch;
wire ParValidWatch, ParClkWatch;
reg SerClkStim, SerInStim, SerValidStim, ResetStim;
//
reg[DWid-1:0] ParWordIn;
reg[5:0]  ShiftOutN;
reg[(2*DWid)-1:0] ShiftOut64;
//
// The serial clock stimulus:
//
// 32 MHz ~= 31.3 ns/cycle:
always@(SerClkStim) #15.6 SerClkStim <= ~SerClkStim;
//
// The frame formatter:  Load a SR and shift it
// out on the serial line:
//
always@(posedge SerClkStim)
  begin : FrameGen
  if (ResetStim==1'b1)
       ShiftOutN = 'b0;
  else ShiftOutN = ShiftOutN - 1; // Need wrapped downcount.
  //
  // Assign the serial bit:
  SerInStim = ShiftOut64[ShiftOutN];
  //
  if (ShiftOutN==64'h0) // Load another stimulus vector in 0 time:
    begin
    ParWordIn = $random;
    ShiftOut64 = { ParWordIn[31:24],PAD3
                 , ParWordIn[23:16],PAD2
                 , ParWordIn[15:08],PAD1
                 , ParWordIn[07:00],PAD0
                 };
    end
  end // always posedge SerClkStim.
  //
//
initial
  begin
  #0  SerValidStim =  'b1;
  #0  SerInStim    =  'bz;
  #0  ShiftOut64   =  'b0;
  #0  ShiftOutN    = 64'h01;
  #0  SerClkStim      = 1'b0;
  #0  ResetStim   = 1'b0;
  #1  ResetStim   = 1'b1;
  #19  ResetStim   = 1'b0;
  //
  #25000  $finish;
  end
//
DesDecoder #( .DWid(DWid) )
       U1
       ( .ParOut(ParOutWatch), .ParValid(ParValidWatch)
       , .ParClk(ParClkWatch), .SerIn(SerInStim)
       , .SerClk(SerClkStim)
       , .SerValid(SerValidStim), .Reset(ResetStim)
       );
//
endmodule // DesDecoderTst.
