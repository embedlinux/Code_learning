// ===================================================
// DesDecoder.   The SerDes Deserialization Decoder.
//
// Composed of these always blocks (which once were
// tasks):
// 1. Unload32:  Copies the contents of the 32-bit
//    Decoder register onto the 32-bit output bus ParOut.
//      outputs: ParOut I/O, ParValid I/O.
//      inputs:  Decoder, ParClk, UnLoad, Reset I/O.
// 2. Shift1: Shifts one new bit from the SerIn digitized
//    serial input bus into the 64-bit Decoder shift
//    register, FrameSR.
//    Capable only of shifting 1 bit in 1 direction;
//    contents can be reset.
//      outputs: FrameSR (shifted).
//      inputs:  FrameSR (orig), SerIn I/O, Reset I/O.
// 3. Decode4:  Copies contents of 64-bit FrameSR to
//    the 32-bit Decoder; requests copy to ParOut.
//    Detects packet alignment; determines synchronized
//    or desynchronized state.
//    After checking not to create a ParClk glitch,
//    requests sync of ParClk upon resynch.
//      outputs: Decoder, doParSync, SyncOK, UnLoad.
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
// 2006-07-28 jmw: v. 1.9 Added %m to packet message
//      because FullDup has two DesDecoders.
// 2006-07-26 jmw: v. 1.8 Increased packet message
//      counter, which was wrapping at 256.
// 2006-07-21 jmw: v. 1.7 Improved ParValidTimer logic.
// 2006-07-07 jmw: v. 1.6 Added ParValidTimer reset.
// 2006-05-30 jmw: v. 1.5 Fixed ParValidTimer params.
// 2006-05-26 jmw: v. 1.4 Renamed all *Reg to *r.
//      Removed old task remnants and
//      modified comments.   Rewrote Shift1 so it did
//      not require a temporary reg.  Rewrote last
//      remaining task, ClkGen, as an always block,
//      disentangling the SerClock gating into a new
//      conditional cts assignment.  Changed ClkGen
//      sensitivity to edge.
//      Changed all clocked assignments to nonblocking.
//      Added ParValidTimer to prolong ParValid assertion.
//      SerClock edge triggers now are:
//        negedge: Unload32, Shift1, Decode4.
//        posedge: ClkGen.
// 2006-05-23 jmw: v. 1.3 For synthesis, changed
//      task runtime to 3 concurrent always blocks.
//      Replaced tasks with always blocks, with local
//      task data redeclared at module level.
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
//
reg[ShiftWid-1:0] FrameSR; // Input shift register.
reg[DWid-1:0] Decoder    // Decoded data buffer.
            , ParOutr;   // Parallel bus out reg.
reg[4:0] Count32;          // Wraps to divide by 32.
//
reg ParValidr // To assign ParValid procedurally.
  , ParClkr   // (ditto) ParClk.
  , doParSync // Request parallel-clock synchronization.
  , SyncOK    // Broadcast that ParClk is sync'ed.
  , UnLoad;   // Request Unload32.
//
wire SerClock; // Gated SerClk.
//
// ---------------------------------------------------
// The ParValidTimer is used to count SerClock cycles
// to prolong the duration of each assertion of ParValid:
//
// Minimum number of SerClocks to hold ParValid
// asserted is set here:
//
localparam ParValidMinCnt = 8;
//
// Declared width of ParValidTimer reg. is calculated
// here automatically:
localparam ParValidTWid =
                   (    2   > ParValidMinCnt )? 1
                 : ( (1<<2) > ParValidMinCnt )? 2
                 : ( (1<<3) > ParValidMinCnt )? 3
                 : ( (1<<4) > ParValidMinCnt )? 4
                 : ( (1<<5) > ParValidMinCnt )? 5
                 : ( (1<<6) > ParValidMinCnt )? 6
                 :      7;
reg[ParValidTWid-1:0] ParValidTimer;
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
//
assign ParOut   = ParOutr;
assign ParClk   = ParClkr;
assign ParValid = ParValidr;
assign SerClock = (SerValid==YES)? SerClk : 1'b0;
//
// ---------------------------------------------------
// Unload32 block:  Copies the contents of the 32-bit
// Decoder register onto the 32-bit output bus ParOut.
//
always@(negedge SerClock, posedge Reset) 
  begin : Unload32
  if (Reset==YES)
       begin
       ParValidr     <=  NO; // Lower the flag.
       ParOutr       <= 'b0; // Zero the output.
       ParValidTimer <= 'b0;
       end
  else begin
       if (UnLoad==YES)
            begin
            ParOutr       <= Decoder; // Move the data.
            ParValidr     <= YES;     // Set the flag.
            ParValidTimer <= 'b0;
            end
       else begin
            if (ParValidTimer<ParValidMinCnt)
                 ParValidTimer <= ParValidTimer + 1;
            else if (ParClk==1'b0)
                   ParValidr <= NO; // Terminates assertion.
            end
       end // UnloadParData.
  end
//
// --------------------------------------------------
// Shift1 block: Shifts one new bit from the SerIn
// digitized serial input bus into the Decoder shift
// register, FrameSR.
//
always@(negedge SerClock, posedge Reset)
  begin : Shift1
  // Respond to external reset:
  if (Reset==YES)
		 FrameSR <= 'b0;
  else begin
		 FrameSR    <= FrameSR<<1;
		 FrameSR[0] <= SerIn;
       end
  end
//
// --------------------------------------------------
// ClkGen block:  Generates the ParClk; phase set by
// a Decode4 sync request.  Now called on SerClock
// posedge.
//
always@(posedge SerClock, posedge Reset)
  begin : ClkGen
  if (Reset==1'b1) // Respond to external reset.
       begin
       ParClkr <= 1'b0;
       Count32 <=  'b0;
       end
  else begin // If not a reset:
       if (SerValid==YES)
         begin
         // Resynchronize this one:
         if (doParSync==YES)
              begin
              ParClkr <= 1'b0; // Put low immediately.
              Count32 <=  'b0;
              end
         else begin
              Count32 <= Count32 + 1;
              if (Count32==5'h0) ParClkr <= ~ParClkr;
              end
         end // if SerValid.
       end // not a reset.
  end // ClkGen.
//
// --------------------------------------------------
// Decode4 block:  Does nothing unless it finds a PAD0
// pattern in the low-order byte of the SR.
//
// To the 32-bit Decoder; requests copy to ParOut.
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
//      outputs: Decoder, doParSync, SyncOK, UnLoad.
//      inputs:  FrameSR, SerClock, ParClk, Reset I/O.
//
`ifdef DC
`else
reg[9:0] PacketN;
initial PacketN = 'b0;
`endif
always@(negedge SerClock, posedge Reset)
  begin : Decode4
  if (Reset==YES)
       begin
       Decoder   <= 'b0;
       doParSync <=  NO;
       SyncOK    <=  NO;
       UnLoad    <=  NO;
       end
  else begin : PacketFind  // Look for packet alignment:
       UnLoad    <= NO;
       doParSync <= NO;
       if ( FrameSR[7:0]==PAD0 )
         begin : FoundPAD0
         SyncOK <= YES;
         if ( FrameSR[23:16]==PAD1 && FrameSR[39:32]==PAD2 && FrameSR[55:48]==PAD3 )
              begin // If all pads indicate all frames aligned:
              `ifdef DC
              `else
              PacketN = PacketN + 1;
              $display("DesDecoder: Packet at t=%07d. N=%d --> %m", $time, PacketN);
              `endif
              Decoder <= { FrameSR[63:56], FrameSR[47:40], FrameSR[31:24], FrameSR[15:8] }; 
              UnLoad  <= YES;
              end
         else // Found a PAD0, but rest failed; so, synchronize:
              begin
              doParSync <= YES;
              SyncOK <= NO;
              end // If all pads found.
         end // FoundPAD0
       end // PacketFind.
  end
//
endmodule // DesDecoder.
//
