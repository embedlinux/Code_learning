// ===================================================
// DesDecoder.   The SerDes Deserialization Decoder.
//
// Composed of these tasks:
// 1. Unload32:  Copies the contents of the 32-bit
//    DecodeReg register onto the 32-bit output bus ParOut.
//      outputs: ParOut I/O, ParValid I/O.
//      inputs:  DecodeReg, ParClk, UnLoad, Reset I/O.
// 2. Shift1: Shifts one new bit from the SerIn digitized
//    serial input bus into the 64-bit Decoder shift
//    register, FrameSR.
//    Capable only of shifting 1 bit in 1 direction;
//    contents can be reset.
//      outputs: FrameSR (shifted).
//      inputs:  FrameSR (orig), SerIn I/O, Reset I/O.
// 3. Decode4:  Copies contents of 64-bit FrameSR to
//    the 32-bit DecodeReg; requests copy to ParOut.
//    Detects packet alignment; determines synchronized
//    or desynchronized state.
//    After checking not to create a ParClk glitch,
//    requests sync of ParClk upon resynch.
//      outputs: DecodeReg, doParSync, SyncOK, UnLoad.
//      inputs:  FrameSR, SerClock, ParClk, Reset I/O.
// 4. ClkGen:  Generates the ParClk; phase set by
//    Decode4 sync request.  Also gates SerClk for all
//    other components.
//      outputs: ParClk I/O, SerClock (gated by SerValid).
//      inputs:  SerClk I/O, SerValid I/O, doParSync,
//               Reset I/O.
//
// Data input is suspended during SerValid deasserted,
// but reassert just causes restart from the serial bit
// last shifted in.
// 
// ---------------------------------------------------
// 2006-05-23 jmw: v. 1.2 Removed unused WriteFIFO
//      port.  Added packet counter.
// 2006-05-23 jmw: v. 1.1 Removed all #(delays) and
//      comments concerning them.  Combined all task
//      calls except ClkGen in one always block
//      sensitive to negedge SerClock.
//      Rewrote SerValid control of ClkGen and 
//      replaced ClkGen edge event control with test
//      of ParClk==0.
//      Fixed Count32 init from 3'b0 to 'b0.
// 2006-05-19 jmw: v. 1.0 Copied from Lab16_Ans.
//      Removed timescale and substituted DWid param.
//      for originals.  Renamed ParBus to ParOut;
//      renamed ParRst to Reset; deleted tb; removed
//      SHIFT & RESET params.
// ===================================================
//
module DesDecoder
     #( parameter DWid = 32 )
      ( output[DWid-1:0] ParOut
      , output ParValid, ParClk
      , input SerIn, SerClk, SerValid, Reset
      );
//
localparam ShiftWid = DWid*2; // Shift reg. width.
//
reg[ShiftWid-1:0] FrameSR;    // Input shift register.
//
reg[DWid-1:0] DecodeReg  // Decoded data buffer.
            , ParOutReg; // Parallel bus out reg.
reg ParValidReg // To assign ParValid procedurally.
  , ParClkReg;  // (ditto) ParClk.
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
localparam YES  = 1'b1; // For general readability.
localparam  NO  = 1'b0;
localparam PAD3 = 8'b000_11_000;
localparam PAD2 = 8'b000_10_000;
localparam PAD1 = 8'b000_01_000;
localparam PAD0 = 8'b000_00_000;
//
// ---------------------------------------------------
// Unload32 task:  Copies the contents of the 32-bit
// DecodeReg register onto the 32-bit output bus ParOut.
//
task Unload32; // Copies the parallel SR to the bus.
  begin
    if (Reset==YES)
         begin
         ParValidReg =  NO; // Lower the flag.
         ParOutReg   = 'b0; // Zero the output.
         end
    else begin : UnloadParData
         if (UnLoad==YES)
              begin
              ParOutReg   = DecodeReg; // Move the data.
              ParValidReg = YES;       // Set the flag.
              end
         else if (ParClk==1'b0) ParValidReg = NO;
         end // UnloadParData.
  end
endtask
//
// --------------------------------------------------
// Shift1 task: Shifts one new bit from the SerIn
// digitized serial input bus into the Decoder shift
// register, FrameSR.   All params are declared at
// module level.  Called on every SerClock:
//
task Shift1;
  reg[ShiftWid-1:0] temp;
  begin
  // Respond to external reset:
  if (Reset==YES)
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
  if (Reset==YES) // Respond to external reset.
       begin
       ParClkReg = 1'b0;
       SerClock  = 1'b0;
       Count32   =  'b0;
       end
  else begin // If not a reset:
       if (SerValid==YES)
         begin : SerClockGen
         SerClock = SerClk; // Just gate it.
         //
         // Resynchronize this one:
         if (doParSync==YES)
              begin
              ParClkReg = 1'b0; // Put low immediately.
              Count32   =  'b0;
              end
         else begin
              Count32 = Count32 + 1;
              if (Count32==5'b0) ParClkReg = ~ParClkReg;
              end
         end // SerClockGen.
       end // not a reset.
  end
endtask
//
// --------------------------------------------------
// Decode4 task:  Does nothing unless it finds a PAD0
// pattern in the low-order byte of the SR.
//
// To the 32-bit DecodeReg; requests copy to ParOut.
// Detects packet alignment;
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
//      inputs:  FrameSR, SerClock, ParClk, Reset I/O.
//
`ifdef DC
`else
integer PacketN;
initial PacketN = 0;
`endif
task Decode4;
  begin
  if (Reset==YES)
       begin
       DecodeReg = 'b0;
       doParSync =  NO;
       SyncOK    =  NO;
       UnLoad    =  NO;
       end
  else begin : PacketFind  // Look for packet alignment:
       UnLoad    = NO;
       doParSync = NO;
       if ( FrameSR[7:0]==PAD0 )
         begin : FoundPAD0
         SyncOK = YES;
         if ( FrameSR[23:16]==PAD1 && FrameSR[39:32]==PAD2 && FrameSR[55:48]==PAD3 )
              begin // If all pads indicate all frames aligned:
              `ifdef DC
              `else
              PacketN = PacketN + 1;
              $display("DesDecoder: Packet at t=%07d. N=%02d", $time, PacketN);
              `endif
              DecodeReg = { FrameSR[63:56], FrameSR[47:40], FrameSR[31:24], FrameSR[15:8] }; 
              UnLoad = YES;
              end
         else // Found a PAD0, but rest failed; so, synchronize:
              begin
              doParSync = YES;
              SyncOK = NO;
              end // If all pads found.
         end // FoundPAD0
       end // PacketFind.
  end
endtask
//
// ==================================================
// Runtime:  
//
assign ParOut   = ParOutReg;
assign ParClk   = ParClkReg;
assign ParValid = ParValidReg;
//
// The clock generator task runs continuously:
always@(SerClk, Reset) ClkGen;
//
always@(negedge SerClock, posedge Reset)
  begin
  Shift1;
  Decode4;
  Unload32;
  end
//
endmodule // DesDecoder.
//
