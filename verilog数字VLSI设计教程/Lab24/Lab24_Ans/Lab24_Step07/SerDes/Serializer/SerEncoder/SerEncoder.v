// ======================================================
// SerEncoder.   The Serializer encoder block, which
// formats the outgoing serial stream.   It inserts the
// pad-byte boundaries and thus embeds the parallel
// clock for the receiver-end Des PLL.
//
// There are two main always blocks, Loader and Shifter.
//
// Loader:  Operates on posedge of the halved ParClk.
//
// This block loads InBuf from the parallel input
// bus so Shifter can format the 64-bit packet from it.
//
// On each posedge HalfParClkr (frequency = 1/2 MHz), if
// FIFO empty is not asserted, Loader asserts SerValid.
// 
// If FIFO empty is asserted, the data are replaced by 
// all 0's and the SerValid flag is deasserted as soon
// as the 0 data would begin shifting out serially.
//
// Shifter:  Operates on posedge of SerClk.
//
// On each posedge SerClk, shifts out one serial bit onto
// the SerOut serial output, which is read by SerialTx
// and transferred to the serial line out.
// Depending on the bit-count, Shifter shifts out
// either a pad bit or a data-byte bit on each SerClk..
//
// ------------------------------------------------------
// 2006-07-30 jmw: v. 1.4  Fixed some comments.
// 2006-07-27 jmw: v. 1.3 Load 64-bit SR from 64-bit
//      FrameSR causes synthesizer to replace SR register
//      bits with constants, causing failure of synth to
//      match simulation.
//      Redesigned to mux SR output with pad bits.
// 2006-06-02 jmw: v. 1.2 Implemented FIFO reader block at
//      half of ParClk frequency as continuous assignment.
// 2006-06-01 jmw: v. 1.1 Rewrote Shifter as always block,
//      with edge sensitivity.   Changed clocked assignments
//      to nonblocking.   Separated FIFOReader from Encoder.
// 2006-06-01 jmw: v. 1.0 Implemented with Shifter as
//      task.  VCS sim OK, but synthesis invalid.
// ======================================================
//
module SerEncoder
  #(parameter DWid = 32)
   ( output SerOut, SerValid, FIFO_ReadReq
   , input[DWid-1:0] ParIn
   , input F_Empty, ParClk, SerClk, ParValid, Reset
   );
//
// These derived params are an incomplete effort to
// make the design configurable by passed params,
// only:
// First, calculate the Log2 of the word (data) width:
// Assumes width <= 256:
localparam Log2DWid = (DWid ==   1)? 0
                    : (DWid ==   2)? 1
                    : (DWid <=   4)? 2
                    : (DWid <=   8)? 3
                    : (DWid <=  16)? 4
                    : (DWid <=  32)? 5
                    : (DWid <=  64)? 6
                    : (DWid <= 128)? 7
                    : (DWid <= 256)? 8
                    : 9;
//
localparam Log2ShN = 1;                 // 1 -> 2 words = 64 bits.
localparam ShCtrW  = Log2DWid+Log2ShN;  // Shifter counter width.
//
// The framing pad localparam formats:
`include "SerDesFormats.inc"
//
// --------------------------------------------------
// Declarations:
//
reg[DWid-1:0]   InBuf; // The data input buffer.
reg[ShCtrW-1:0] Sh_N;  // Shifter bit counter.
//
reg SerOutr, SerValidr, HalfParClkr;
//
assign SerOut   = SerOutr;
assign SerValid = SerValidr;
//
// --------------------------------------------------
// FIFOReader "block".  Asserts the FIFO_ReadReq to
// make new FIFO input data available for
// serialization:
//
assign FIFO_ReadReq 
       = HalfParClkr && !F_Empty && ParValid && !Reset;
//
// --------------------------------------------------
// Half-freq clock for data read:
//
always@(posedge ParClk, posedge Reset)
  if (Reset==1'b1)
       HalfParClkr <= 1'b0;
  else HalfParClkr <= ~HalfParClkr; // => 1/2 MHz.
//
// --------------------------------------------------
// Shifter block:  Called on posedge SerClk.
// Controls the shift register.  Uses the shift bit
// count in Sh_N to shift onto the serial output port
// either a new data bit from the InBuf or a pad
// bit.
//
// The Sh_N sequence for any packet is as follows,
// with higher bits first:
// 63 - 56  InBuf[24:31]
// 55 - 48  PAD3
// 47 - 40  InBuf[16:23]
// 39 - 32  PAD2
// 31 - 24  InBuf[08:15]
// 23 - 16  PAD1
// 15 - 08  InBuf[00:07]
// 07 - 00  PAD0
//
// Outputs: SerOut.
// Inputs:  InBuf, PADx, SerClk, Reset.
//
always@(posedge SerClk, posedge Reset)
  begin : ShifterBlock
  if (Reset==YES)
       begin
       Sh_N    <=  'b0;
       SerOutr <= 1'b0;
       end
  else begin
       Sh_N <= Sh_N - 6'h1;
       //
       if (Sh_N<=07) SerOutr <=  PAD0[Sh_N];    // --> 0 - 7.
          else
       if (Sh_N<=15) SerOutr <= InBuf[Sh_N-08]; // --> 0 - 7.
          else
       if (Sh_N<=23) SerOutr <=  PAD1[Sh_N-16]; // --> 0 - 7.
          else
       if (Sh_N<=31) SerOutr <= InBuf[Sh_N-16]; // --> 8 - 15.
          else
       if (Sh_N<=39) SerOutr <=  PAD2[Sh_N-32]; // --> 0 - 7.
          else
       if (Sh_N<=47) SerOutr <= InBuf[Sh_N-24]; // --> 16 - 23.
          else
       if (Sh_N<=55) SerOutr <=  PAD3[Sh_N-48]; // --> 0 - 7.
          else
       if (Sh_N<=63) SerOutr <= InBuf[Sh_N-32]; // --> 24 - 31.
            `ifdef DC
            `else
            else
            begin
            $display("time=%t: SerEncoder Shifter illegal count=[%02d]\nin %m."
                    , $time,                                     Sh_N
                    );
            #100 $stop;
            end
            `endif
       end // if not Reset.
  end // always Shifter.
//
// --------------------------------------------------
// Loader block:  Called on posedge HalfParClkr.
//
// Outputs: InBuf, SerValid.
// Inputs:  F_Empty, ParIn, HalfParClkr, ParValid, Reset.
//
always@(posedge HalfParClkr, posedge Reset)
begin : LoaderBlock
  begin
  if (Reset==YES)
       begin
       InBuf      <=  'b0;
       SerValidr  <=   NO;
       end
  else begin
       if (F_Empty==NO && ParValid==YES)
            begin
            InBuf     <= ParIn;
            SerValidr <= YES;
            end
       else begin
            InBuf     <= 'b0;
            SerValidr <= NO;
            end
       end
  end
end // always Loader.
//
endmodule // SerEncoder.
//
