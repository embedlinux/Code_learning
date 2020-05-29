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
// 1. emptyS:   EmptyFIFO flag asserted.  R disabled;
//             RA invalid.
//             W at WA causes RA = WA, WA++, EmptyFIFO
//             deasserted, and transition to a_emptyS.
// 2. a_emptyS: R at RA causes transition to emptyS.
//             W at WA causes WA++ and transition to
//             normalS.
// 3. normalS:  R at RA causes RA++.  RA == WA-1 causes
//             transition to a_emptyS.
//             W at WA causes WA++.  WA == RA-1 causes
//             transition to a_fullS.
// 4. a_fullS:  R at RA causes RA++ and transition to normalS.
//             W at WA causes transition to fullS.
// 5. fullS:    FullFIFO flag asserted.  W disabled;
//             WA invalid.
//             R at RA causes WA = RA, RA++, FullFIFO
//             deasserted, and transition to a_fullS.
//
// ------------------------------------------------------------
// 2006-10-13 jmw: v. 1.8  Restored StateClock phase, because
//      inversion prevented SM reset.
// 2006-05-29 jmw: v. 1.7  Inverted new StateClock, so it would
//      same phase relative to input clocks as did the old, 
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
reg[AWid-1:0] ReadCount, WriteCount // The counters.
            , tempCount; // To handle counter wraparound.
reg[2:0]     CurState, NextState; // CurState is state reg.
reg          EmptyFIFOr, FullFIFOr
           , ReadCmdr, WriteCmdr;
// --------------------------------------------------------
assign ReadAddr  = ReadCount;
assign WriteAddr = WriteCount;
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
// Synthesizable, and with glitch filter:
//
reg  StateClockRaw;
wire StateClock;
//
always@(ClkR, ClkW)
  //jmw:  This doesn't work: StateClockRaw = ~(ClkR && ClkW);
  StateClockRaw = ClkR && ClkW;
//
// Glitch filter:
DEL005 SM_DeGlitcher1 ( .Z(StateClock), .I(StateClockRaw) );
//
//synopsys dc_tcl_script_begin
// set_dont_touch [get_cells SM_DeGlitcher1]
// set_dont_touch [get_nets "StateClock*"]
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
// The counters (FIFO address pointers).
// This can be done many ways, but tasks work. 
// ----------
reg LatchR, LatchW;
// ----------
task incrRead;  // Unsynthesizable!
  begin
  if (LatchR==1'b0)
    begin
    LatchR = 1'b1;
    @(posedge StateClock) ReadCount = ReadCount + 1;
    LatchR = 1'b0;
    end
  end
endtask
// ----------
task incrWrite;
  begin
  if (LatchW==1'b0)
    begin
    LatchW = 1'b1;
    @(posedge StateClock) WriteCount = WriteCount + 1;
    LatchW = 1'b0;
    end
  end
endtask
//
// --------------------------------------------------------
// The combinational block controlling everything
// but state assignment.  This FIFO state machine is not
// allowed to issue read and write commands simultaneously;
// but, should the asserted commands overlap, it is
// up to other logic to control register file operation
// under the various possible conditions.
// However, the state machine does not respond to read or
// write requests unless only one is asserted at a time.
//
always@(*)
begin
if (StateClock==1'b0)
case (CurState)
         // ---------------------------
  emptyS:// This state combines the hardware reset
         // with a simple empty state during operation:
         begin
         if (Reset!=1'b0)
           begin
           // Reset conditions:
           FullFIFOr  = 1'b0;
           WriteCount =  'b0;
           ReadCount  =  'b0;
           WriteCmdr  = 1'b0;
           ReadCmdr   = 1'b0;
           NextState  = emptyS;
           LatchR     = 1'b0;
           LatchW     = 1'b0;
           end
         EmptyFIFOr = 1'b1;
         // One transition rule:
         if (WriteReq==1'b1)
           begin
           incrWrite; // Blocks on posedge StateClock.
           WriteCmdr  = 1'b1;
           EmptyFIFOr = 1'b0;
           NextState  = a_emptyS;
           end
         end
         // ---------------------------
a_emptyS:// In this state, we know W == R+1; one read at
         // the current read address will invalidate the 
         // last datum and leave the read pointer nowhere.
         // However, one write will put the FIFO into
         // normalS state:
         begin
         // On a write:
         `ifdef DC
         `else
         fork
         `endif
         if ( WriteReq==1'b1 )
           begin
           WriteCmdr = 1'b1;
           incrWrite; // Blocks on posedge StateClock.
           end
         // On a read:
         if ( ReadReq==1'b1 )
           begin
           ReadCmdr  = 1'b1;
           incrRead; // Blocks on posedge StateClock.
           end
         `ifdef DC
         `else
         join
         `endif
         //
         // Transition logic:
         // Set default:
         NextState = a_emptyS;
         //
         tempCount = ReadCount + 2;
         if (WriteCount==tempCount)
              NextState = normalS;
         else if (WriteCount==ReadCount)
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
         // On a write:
         `ifdef DC
         `else
         fork
         `endif
         if ( WriteReq== 1'b1 )
           begin
           WriteCmdr = 1'b1;
           incrWrite; // Blocks on posedge StateClock.
           end
         // On a read:
         if ( ReadReq== 1'b1 )
           begin
           ReadCmdr  = 1'b1;
           incrRead; // Blocks on posedge StateClock.
           end
         `ifdef DC
         `else
         join
         `endif
         //
         // Transition logic:
         // Default is normalS:
         NextState = normalS;
         //
         // Check for a_fullS:
         tempCount = WriteCount+1;
         if (ReadCount==tempCount) NextState = a_fullS;
         //
         // Check for a_emptyS:
         tempCount = ReadCount+1;
         if (tempCount==WriteCount) NextState = a_emptyS;
         //
         end // normalS state.
         // ---------------------------
 a_fullS:// In this state, we know R == W+1; one write at
         // the current write address will invalidate the 
         // last datum and leave the write pointer nowhere.
         // However, one read will put the FIFO into
         // normalS state:
         begin
         // On a write:
         `ifdef DC
         `else
         fork
         `endif
         if ( WriteReq==1'b1 )
           begin
           WriteCmdr = 1'b1;
           incrWrite; // Blocks on posedge StateClock.
           end
         // On a read:
         if ( ReadReq==1'b1 )
           begin
           ReadCmdr  = 1'b1;
           incrRead; // Blocks on posedge StateClock.
           end
         `ifdef DC
         `else
         join
         `endif
         //
         // Transition logic:
         // Set default:
         NextState = a_fullS;
         //
         tempCount = WriteCount + 2;
         if (ReadCount==tempCount)
              NextState = normalS;
         else if (ReadCount==WriteCount)
              NextState = fullS;
         //
         end // a_fullS state.
         // ---------------------------
   fullS:// This state has just one possible transition,
         // on a read request:
         begin
         FullFIFOr = 1'b1;
         if (ReadReq==1'b1)
           begin
           WriteCount = ReadCount;
           incrRead; // Blocks on posedge StateClock.
           FullFIFOr = 1'b0;
           ReadCmdr  = 1'b1;
           NextState   = a_fullS;
           end
         end // fullS state.
         // ---------------------------
default: NextState = emptyS; // Always handle the unknown.
endcase
end // always@(*)
//
endmodule // FIFOStateM.
//
