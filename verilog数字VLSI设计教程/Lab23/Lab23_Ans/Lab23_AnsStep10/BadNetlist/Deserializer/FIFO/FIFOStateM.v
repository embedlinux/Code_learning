// ===========================================================
// FIFOStateM:  The FIFO state machine controlling access to
// the FIFO registers (memory).  Used in FIFO_Top simulation.
//
// There are 5 states:  emptyS, almost empty = a_emptyS,
// normalS, almost full = a_fullS, and fullS.
// Abbreviations below:  R = read operation at current
// read address; W = write operation at current write
// address.  RA = read address; WA = write address.
//
// States and rules are as follows:
// 1. emptyS:  EmptyFIFO flag asserted.  R disabled;
//             RA invalid.
//             W at WA causes RA = WA, WA++, EmptyFIFO
//             deasserted, and transition to a_emptyS.
// 2. a_emptyS:R at RA causes transition to emptyS.
//             W at WA causes WA++ and transition to
//             normalS.
// 3. normalS: R at RA causes RA++.  RA == WA-1 causes
//             transition to a_emptyS.
//             W at WA causes WA++.  WA == RA-1 causes
//             transition to a_fullS.
// 4. a_fullS: R at RA causes RA++ and transition to normalS.
//             W at WA causes transition to fullS.
// 5. fullS:   FullFIFO flag asserted.  W disabled;
//             WA invalid.
//             R at RA causes WA = RA, RA++, FullFIFO
//             deasserted, and transition to a_fullS.
//
// ------------------------------------------------------------
// 2006-10-13 jmw: v. 1.12 Removed get_cells and get_nets from
//      comment directives (not allowed by latest DC).
// 2006-07-07 jmw: v. 1.11 Changed SM combo block to negedge
//      StateClock, to avoid weird latches.
// 2006-07-05 jmw: v. 1.10 Fixed FIFO SM IncrWriteBlock to init
//      write addr to 0 in EmptyS, same as read addr; this makes
//      all other counter arithmetic work.   Also fixed 
//      memory control case stmt to turn off opposite mem cmd
//      when no concurrent read & write was requested.
// 2006-05-29 jmw: v. 1.9 Minor comment changes; added
//      more deasserts of ReadCmdr & WriteCmdr in fullS &
//      emptyS.
// 2006-05-29 jmw: v. 1.8  Rewrote tasks so they would be
//      synthesizable.   Removed all explicit ReadCmdr or
//      WriteCmdr assignments in the combinational SM block,
//      except in transition logic, because new tasks control
//      these values.
//      Deleted all fork-joins and their `DC switches and
//      added case statements to handle concurrency.
//      Deleted resets of ReadCmdr and WriteCmdr at ends of
//      combo transition logic, because tasks no longer block
//      on posedge.
//      Fixed some minor bugs, including implementation of case
//      defaults in a_emptyS, normalS, and a_fullS.
// 2006-05-29 jmw: v. 1.7  Inverted new StateClock, so it would
//      same phase relative to input clcks as did the old, 
//      unsynthesizable StateClock.
// 2006-05-24 jmw: v. 1.6  Moved ReadCount init into combo
//      Reset block so it would not be 'x'.  Added synthesizable
//      StateClock generator based on delay-cell deglitcher
//      and ClkR && ClkW.
// 2006-05-24 jmw: v. 1.5 Separated read & write controls in
//      a_empty and a_full.   Added counter-based transition
//      rules in those states, and added missing increments
//      (bug fix) on end-state transitions.
//      Added temporary (unsynthesizable) fork-joins around
//      a_empty, normal, and a_full control logic.
//      Redeclared state names as *S and as sized localparams.
// 2006-05-24 jmw: v. 1.4 Replaced Clk with ClkR and ClkW.
//      Added latch semaphores to tasks; added StateClock
//      generator & changed Clk to StateClock in machine
//      control logic.
// 2006-05-24 jmw: v. 1.3 Renamed all *Reg to *r.
// 2006-05-24 jmw: v. 1.2 Removed all delay expressions.
//      Removed unnecessary 'bz assignments to ReadCount &
//      WriteCount in full & empty states.   Also removed
//      redundant full & empty flag assignments in a_full and
//      a_empty.
// 2006-05-23 jmw: v. 1.1 Assigned wraparound addresses to a
//      specific reg (tempCount) in normal state, to constrain
//      addition overflow expression width in Lab22.
// 2006-05-19 jmw: v. 1.0 Copied from Lab11_Ans.  Renamed AdrHi
//      param to AWid; removed timescale;  removed unused
//      localparam MaxAdr; deleted tb.
// ============================================================
//
module FIFOStateM
       #(parameter AWid = 5) // 2**AWid registers. Default=32.
       ( output[AWid-1:0] ReadAddr, WriteAddr // The 2 pointers.
       , output EmptyFIFO, FullFIFO // Flags to other devices.
       , ReadCmd, WriteCmd          // Controls to FIFO RAM.
       , input ReadReq, WriteReq    // External requests.
       , ClkR, ClkW, Reset
       );
//
// --------
reg[AWid-1:0] ReadAr, WriteAr  // Current address counters.
         , OldReadAr, OldWriteAr // Saved on posedge.
         , tempAr;               // To resolve wraps.
reg[2:0] CurState, NextState;    // CurState is state reg.
reg      EmptyFIFOr, FullFIFOr   // Generic flags.
         , ReadCmdr, WriteCmdr;  // Memory controls.
// --------------------------------------------------------
assign ReadAddr  = ReadAr;
assign WriteAddr = WriteAr;
assign EmptyFIFO = EmptyFIFOr;
assign FullFIFO  = FullFIFOr;
assign ReadCmd   = ReadCmdr;
assign WriteCmd  = WriteCmdr;
//
// --------------------------------------------------------
// State encoding.  Use localparams to prevent external
// control.   Because we have extra states (only 5 of
// 8 possible are defined), we encode as mnemonically
// as possible:
//
localparam[2:0]
       emptyS = 3'b000, // all 0 = emptyS.
     a_emptyS = 3'b010, // LSB 0 = close to emptyS.
      normalS = 3'b011, // a_emptyS < normalS < a_fullS.
      a_fullS = 3'b101, // MSB 1 = close to fullS.
        fullS = 3'b111; // all 1 = fullS
//
// --------------------------------------------------------
// The state machine clock:
//
// Unsynthesizable:
//reg StateClock;
//always@(ClkR, ClkW, Reset)
//  if (Reset==1'b1)
//       StateClock = 1'b0;
//  else StateClock = ~StateClock;
// -----------------------
//
// Synthesizable, and with glitch filter:
//
reg  StateClockRaw;
wire StateClock;
//
always@(ClkR, ClkW)
  StateClockRaw = ~(ClkR && ClkW);
//
// Glitch filter:
DEL005 SM_DeGlitcher1 ( .Z(StateClock), .I(StateClockRaw) );
//
// jmw: Not in latest DC: set_dont_touch [get_cells SM_DeGlitcher1]
// jmw: Not in latest DC: set_dont_touch [get_nets "StateClock*"]
//synopsys dc_tcl_script_begin
// set_dont_touch SM_DeGlitcher1
// set_dont_touch StateClock*
//synopsys dc_tcl_script_end
//
// --------------------------------------------------------
// The sequential block controlling state transitions:
//
always@(posedge StateClock, posedge Reset)
  if (Reset==1'b1)
       CurState <= emptyS;
  else CurState <= NextState;
//
// --------------------------------------------------------
// Read logic:
//
always@(posedge StateClock, posedge Reset)
  begin : IncrReadBlock
  if (Reset==1'b1)
       ReadAr <= 'b0;
  else begin
       if (CurState==emptyS)
            ReadAr <= 'b0;
       else if (ReadCmdr==1'b1)
              ReadAr <= ReadAr + 1;
       end
  end
//
task incrRead(input ActionR);
  begin
  if (ActionR==1'b1)
       begin
       if (CurState==emptyS)
            begin
            ReadCmdr  = 1'b0;
            OldReadAr =  'b0;
            end
       else begin
            if (OldReadAr==ReadAr) // Schedule an incr.
                 ReadCmdr = 1'b1;
            else begin // No incr; already changed:
                 ReadCmdr  = 1'b0;
                 OldReadAr = ReadAr;
                 end
            end
       end
  else begin // ActionR is a reset:
       ReadCmdr  = 1'b0;
       OldReadAr = 1'b0;
       end
  end
endtask
//
// --------
// Write logic:
//
always@(posedge StateClock, posedge Reset)
  begin : IncrWriteBlock
  if (Reset==1'b1)
       WriteAr <= 'b0;
  else begin
       case (CurState)
       emptyS: WriteAr <= 'b0;    // Set equal to emptyS read addr.
        fullS: WriteAr <= ReadAr; // Set equal to first valid addr.
       endcase                    // No default.
       // If current state not special:
       if (CurState!=fullS && WriteCmdr==1'b1)
         WriteAr <= WriteAr + 1;
       end
  end
//
task incrWrite(input ActionW);
  begin
  if (ActionW==1'b1)
       begin
       if (CurState==fullS)
              begin
              WriteCmdr  = 1'b0;
              OldWriteAr = ReadAr;
              end
         else begin
              if (OldWriteAr==WriteAr) // Schedule an incr.
                   WriteCmdr = 1'b1;
              else begin // No incr; already changed:
                   WriteCmdr  = 1'b0;
                   OldWriteAr = WriteAr;
                   end
              end
       end
  else begin // ActionW is a reset:
       WriteCmdr  = 1'b0;
       OldWriteAr = 1'b0;
       end
  end
endtask
//
// --------------------------------------------------------
// The combinational block controlling everything
// but state assignment and memory addressing.
//
always@(negedge StateClock, posedge Reset)
begin
if (Reset==1'b1)
     begin
     // Reset conditions:
     NextState  = emptyS;
     incrRead(1'b0);  // 0 -> reset counter.
     incrWrite(1'b0); // 0 -> reset counter.
     end
else
case (CurState)
         // ---------------------------
  emptyS:// This state combines the hardware reset
         // with a simple empty state during operation:
         begin
         EmptyFIFOr = 1'b1;
         FullFIFOr  = 1'b0;
         ReadCmdr   = 1'b0;  // Just in case.
         // One transition rule:
         if (WriteReq==1'b1)
              begin
              incrWrite(1'b1);
              EmptyFIFOr = 1'b0;
              NextState  = a_emptyS;
              end
         else WriteCmdr = 1'b0;  // Just in case.
         end
         // ---------------------------
a_emptyS:// In this state, we know W == R+1; one read at
         // the current read address will invalidate the 
         // last datum and leave the read pointer nowhere.
         // However, one write will put the FIFO into
         // normalS state:
         begin
         EmptyFIFOr = 1'b0;
         // Memory control logic:
         case ({ReadReq,WriteReq})
           2'b01: begin
                  incrWrite(1'b1);
                  ReadCmdr  = 1'b0;
                  end
           2'b10: begin
                  incrRead(1'b1);
                  WriteCmdr = 1'b0;
                  end
           2'b11: begin // Concurrent calls:
                  incrRead(1'b1);
                  incrWrite(1'b1);
                  end
         default: begin // No request pending:
                  ReadCmdr  = 1'b0;
                  WriteCmdr = 1'b0;
                  end
         endcase
         //
         // Transition logic:
         // Set default:
         NextState = a_emptyS;
         //
         tempAr = ReadAr + 2;
         if (WriteAr==tempAr)
              NextState = normalS;
         else if (WriteAr==ReadAr)
              NextState = emptyS;
         //
         end // a_emptyS state.
         // ---------------------------
 normalS:// In this state, we know W > R+1
         // and R > W+1 before anything happens here.
         // The simplest way to look for a transition,
         // then, is just to compare the new counter
         // value + 1 with the other counter value.
         // If, after increment, W == R+1 or R == W+1,
         // we are no longer in the normalS state.
         begin
         // Memory control logic:
         case ({ReadReq,WriteReq})
           2'b01: begin
                  incrWrite(1'b1);
                  ReadCmdr  = 1'b0;
                  end
           2'b10: begin
                  incrRead(1'b1);
                  WriteCmdr = 1'b0;
                  end
           2'b11: begin // Concurrent calls:
                  incrRead(1'b1);
                  incrWrite(1'b1);
                  end
         default: begin // No request pending:
                  ReadCmdr  = 1'b0;
                  WriteCmdr = 1'b0;
                  end
         endcase
         //
         // Transition logic:
         // Default is normalS:
         NextState = normalS;
         //
         // Check for a_fullS:
         tempAr = WriteAr+1;
         if (ReadAr==tempAr) NextState = a_fullS;
         //
         // Check for a_emptyS:
         tempAr = ReadAr+1;
         if (tempAr==WriteAr) NextState = a_emptyS;
         //
         end // normalS state.
         // ---------------------------
 a_fullS:// In this state, we know R == W+1; one write at
         // the current write address will invalidate the 
         // last datum and leave the write pointer nowhere.
         // However, one read will put the FIFO into
         // normalS state:
         begin
         FullFIFOr = 1'b0;
         // Memory control logic:
         case ({ReadReq,WriteReq})
           2'b01: begin
                  incrWrite(1'b1);
                  ReadCmdr  = 1'b0;
                  end
           2'b10: begin
                  incrRead(1'b1);
                  WriteCmdr = 1'b0;
                  end
           2'b11: begin // Concurrent calls:
                  incrRead(1'b1);
                  incrWrite(1'b1);
                  end
         default: begin // No request pending:
                  ReadCmdr  = 1'b0;
                  WriteCmdr = 1'b0;
                  end
         endcase
         //
         // Transition logic:
         // Set default:
         NextState = a_fullS;
         //
         tempAr = WriteAr + 2;
         if (ReadAr==tempAr)
              NextState = normalS;
         else if (ReadAr==WriteAr)
              NextState = fullS;
         //
         end // a_fullS state.
         // ---------------------------
   fullS:// This state has just one possible transition,
         // on a read request:
         begin
         FullFIFOr = 1'b1;
         WriteCmdr = 1'b0; // Just in case.
         if (ReadReq==1'b1)
              begin
              incrRead(1'b1);
              FullFIFOr = 1'b0;
              NextState = a_fullS;
              end
         else ReadCmdr = 1'b0; // Just in case.
         end // fullS state.
         // ---------------------------
default: NextState = emptyS; // Always handle the unknown.
endcase
end // always@(*)
//
endmodule // FIFOStateM.
//
