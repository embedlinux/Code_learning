// ===================================================
// DesDecoder.   The SerDes Deserialization Decoder.
//
// Composed of these tasks:
// 1. Unload32:  Copies the contents of the 32-bit
//    DecodeReg register onto the 32-bit output bus ParBus.
//      outputs: ParBus I/O, ParValid I/O.
//      inputs:  DecodeReg, ParClk, UnLoad, ParRst I/O.
// 2. Shift1: Shifts one new bit from the SerIn digitized
//    serial input bus into the 64-bit Decoder shift
//    register, FrameSR.
//    Capable only of shifting 1 bit in 1 direction;
//    contents can be reset.
//      outputs: FrameSR (shifted).
//      inputs:  FrameSR (orig), SerIn I/O, ParRst I/O.
// 3. Decode4:  Copies contents of 64-bit FrameSR to
//    the 32-bit DecodeReg; requests copy to ParBus.
//    Detects frame alignment; determines synchronized
//    or desynchronized state.
//    After checking not to create a ParClk glitch,
//    requests sync of ParClk upon resynch.
//      outputs: DecodeReg, doParSync, SyncOK, UnLoad.
//      inputs:  FrameSR, SerClock, ParClk, ParRst I/O.
// 4. ClkGen:  Generates the ParClk; phase set by
//    Decode4 sync request.  Also gates SerClk for all
//    other components.
//      outputs: ParClk I/O, SerClock (gated by SerValid).
//      inputs:  SerClk I/O, SerValid I/O, doParSync,
//               ParRst I/O.
//
// Data input is suspended during SerValid deasserted,
// but reassert just causes restart from the serial bit
// last shifted in.
// 
// ---------------------------------------------------
// 2007-10-26 jmw: v. 1.7 Minor comment change.
// 2007-02-27 jmw: v. 1.6 Minor comment change.
// 2006-05-30 jmw: v. 1.5 Minor fixes.
// 2005-10-05 jmw: v. 1.4 Minor comment changes.
// 2005-04-28 jmw: v. 1.3 Delays moved to cts assigns;
//            Shift1 task fixed to else.
// 2005-02-24 jmw: v. 1.2 Added `DC switch.
// 2005-01-31 jmw: v. 1.1 Blockings for synthesis.
// 2005-01-18 jmw: v. 1.0 implemented.
// ===================================================
`timescale 1ns/100ps
//
module DesDecoder
     #( parameter Log2ParWid = 5  // 5 -> 2^5 = 32bit bus.
      , ParHi = (1<<Log2ParWid)-1 // 5 -> 31.
      )
      ( output[ParHi:0] ParBus, output ParValid, ParClk
      , input SerIn, SerClk, SerValid, ParRst
      );
// Derived params:
localparam ParWid   = ParHi+1;    // Width of out bus.
localparam ShiftWid = ParWid*2;   // Width of shift reg.
localparam ShiftHi  = ParWid*2-1; // High bit of shift reg.
//
reg[ShiftHi:0] FrameSR;   // Input shift register.
//
reg[ParHi:0]   DecodeReg  // Decoded data.
             , ParBusReg; // Parallel bus out reg.
reg ParValidReg  // To assign ParValid procedurally.
  , ParClkReg;   // (ditto) ParClk.
//
reg SerClock  // Gated SerClk.
  , doParSync // Request parallel-clock synchronization.
  , SyncOK    // Broadcast that ParClk is sync'ed.
  , UnLoad;   // Request Unload32 call.
//
// ---------------------------------------------------
// Some useful constants.  Upper case is to remind
// reader these are not variable names, but constant
// (parameter) names:
//
localparam SHIFT = 1'b0; // For task readability.
localparam RESET = 1'b1;
localparam YES  = 1'b1; // For general readability.
localparam  NO  = 1'b0;
localparam PAD3 = 8'b000_11_000;
localparam PAD2 = 8'b000_10_000;
localparam PAD1 = 8'b000_01_000;
localparam PAD0 = 8'b000_00_000;
//
// ---------------------------------------------------
// Unload32 task:  Copies the contents of the 32-bit
// DecodeReg register onto the 32-bit output bus ParBus.
//
task Unload32; // Copies the parallel SR to the bus.
  begin
  if (ParRst==YES)
       begin
       ParValidReg =  NO; // Lower the flag.
       ParBusReg   = 'b0; // Zero the output.
       end
  else if (UnLoad==YES)
            begin
            ParBusReg   = DecodeReg; // Move the data.
            ParValidReg = YES;       // Set the flag.
            end
       else @(negedge ParClk) ParValidReg = NO;
  end
endtask
//
// --------------------------------------------------
// Shift1 task: Shifts one new bit from the SerIn
// digitized serial input bus into the Decoder shift
// register, FrameSR.  Delay is left to the caller;
// all params are declared at module level.
// Called on every SerClock:
//
task Shift1;
  reg[ShiftHi:0] temp;
  begin
  // Respond to external reset:
  if (ParRst==YES)
		 begin
		 temp    = 'b0;
		 FrameSR = 'b0;
		 end
  else begin
		 // If not a reset:
		 temp    = FrameSR;
		 temp    = temp<<1;
		 temp[0] = SerIn;
		 FrameSR = temp;
       end
  end
endtask
//
// --------------------------------------------------
// ClkGen task:  Generates the ParClk; phase set by
// a Decode4 sync request.  Also gates SerClk for all
// other Decoder components.  Called on every change
// of SerClk.
//
task ClkGen;
  reg[4:0] Count32; // Wraps to divide by 32.
  begin
  if (ParRst==YES) // Respond to external reset.
       begin
       ParClkReg = 1'b0;
       SerClock  = 1'b0;
       Count32   =  'b0;
       end
  else begin // If not a reset:
       if (SerValid==YES)
         #1 SerClock = SerClk; // Just gate it.
       //
       // Resynchronize this one:
       if (doParSync==YES)
            begin
            ParClkReg = 1'b0; // Put low immediately.
              Count32 = 5'b0;
            end
       else begin
            Count32 = Count32 + 1;
            #1 if (Count32==5'b0) ParClkReg = ~ParClkReg;
            end
       end // not a reset.
  end
endtask
//
// --------------------------------------------------
// Decode4 task:  Does nothing unless it finds a PAD0
// pattern in the low-order byte of the SR.
//
// To the 32-bit DecodeReg; requests copy to ParBus.
// Detects frame alignment;
// determines synchronized or desynchronized state.
// requests sync of ParClk upon resynch.
//
// Called on every SerClock, after a new bit has been
// shifted in.
//
/* The numbers help identify bits in the shift register vector:
*  60         50         40          30         20         10          0
*32109876 54321098 76543210 98765432 10987654 32109876 54321098 76543210
*xxxxxxxx_00011000_xxxxxxxx_00010000_xxxxxxxx_00001000_xxxxxxxx_00000000;
*           PAD3              PAD2              PAD1              PAD0
*           8'18              8'10              8'08              8'00
*/
// The most complex of the tasks, Decode4 is located
// closest to the runtime, for debugging.
//      outputs: DecodeReg, doParSync, SyncOK, UnLoad.
//      inputs:  FrameSR, SerClock, ParClk, ParRst I/O.
//
task Decode4;
  begin
  if (ParRst==YES)
       begin
       DecodeReg = 'b0;
       doParSync =  NO;
       SyncOK    =  NO;
       UnLoad    =  NO;
       end
  else // Look for frame alignment:
       begin
       UnLoad =  NO;
       if (FrameSR[7:0]==PAD0)
         begin
         if (   FrameSR[23:16]==PAD1
             && FrameSR[39:32]==PAD2
             && FrameSR[55:48]==PAD3
            ) // If all pads indicate valid data:
              begin
              doParSync = NO;
              SyncOK    = YES;
              DecodeReg = { FrameSR[63:56], FrameSR[47:40]
                          , FrameSR[31:24], FrameSR[15:8] }; 
              UnLoad = YES;
              end
         else // Found a PAD0, but rest failed; so, synchronize:
              if (SyncOK==NO)
                doParSync = YES;
         end
       end // look frame align.
  end
endtask
//
// ==================================================
// Runtime:  
//
assign #2 ParBus   = ParBusReg;
assign #1 ParClk   = ParClkReg;
assign #1 ParValid = ParValidReg;
//
// The clock generator task runs continuously;
// its delays are internal:
//
// NOTE:  This is not synthesizable, because of
//        mixed change and edge event controls:
//
always@(SerClk, posedge ParRst) ClkGen;
//
// Decode4 has delays internally:
always@(posedge SerClock, posedge ParRst) Decode4;
//
// Shift1 is delayed externally:
always@(posedge SerClock, posedge ParRst) #1 Shift1;
//
// Unload32 has delays internal:
always@(UnLoad) Unload32;
//
endmodule // DesDecoder.
//
// --------------------
`ifdef DC
`else
module DesDecoderTst;
//
localparam Log2ParWid = 5; // 5 --> 32 bit bus.
localparam ParHi = (1<<Log2ParWid)-1; // 5 --> 31
//
localparam PAD3 = 8'b000_11_000;
localparam PAD2 = 8'b000_10_000;
localparam PAD1 = 8'b000_01_000;
localparam PAD0 = 8'b000_00_000;
//
wire[ParHi:0] ParBusWatch;
wire ParValidWatch, ParClkWatch;
reg SerClkStim, SerInStim, SerValidStim, ParRstStim;
//
reg[31:0] temp;
reg[5:0]  ShiftOutN;
reg[63:0] ShiftOut64;
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
  if (ParRstStim==1'b1)
       ShiftOutN = 'b0;
  else ShiftOutN = ShiftOutN - 1; // Need wrapped downcount.
  //
  // Assign the serial bit:
  #1 SerInStim = ShiftOut64[ShiftOutN];
  //
  if (ShiftOutN==64'h0) // Load another stimulus vector in 0 time:
    begin
    temp = $random;
    ShiftOut64 
       = {temp[7:0],PAD3,temp[15:8],PAD2,temp[23:16],
                    PAD1,temp[31:24],PAD0};
    end
  //
  // Exercise SerValid:
//@@  if      ($time>2100 && $time<2250) #1 SerValidStim = 1'b0;
//@@  else if ($time>4000 && $time<4150) #1 SerValidStim = 1'b0;
//@@  else                               #1 SerValidStim = 1'b1;
  end // always posedge SerClkStim.
  //
//
initial
  begin
  #0  SerValidStim =  'b1;
  #0  SerInStim    =  'bz;
  #0  ShiftOut64   =  'b0;
  #0  ShiftOutN    = 6'h01;
  #0  SerClkStim      = 1'b0;
  #0  ParRstStim   = 1'b0;
  #1  ParRstStim   = 1'b1;
  #19  ParRstStim   = 1'b0;
  //
  #10000  $finish;
  end
//
DesDecoder #( .Log2ParWid(Log2ParWid) )
       U1
       ( .ParBus(ParBusWatch), .ParValid(ParValidWatch)
       , .ParClk(ParClkWatch), .SerIn(SerInStim)
       , .SerClk(SerClkStim)
       , .SerValid(SerValidStim), .ParRst(ParRstStim)
       );
//
endmodule // DesDecoderTst.
`endif
