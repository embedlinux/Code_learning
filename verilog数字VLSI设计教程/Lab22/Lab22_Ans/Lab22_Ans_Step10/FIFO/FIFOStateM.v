// ===========================================================
// FIFOStateM:  The FIFO state machine controlling access to
// the FIFO registers (memory).  Used in FIFO_Top simulation.
//
// There are 5 states:  empty, almost empty = a_empty,
// normal, almost full = a_full, and full.
// Abbreviations below:  R = read operation at current
// read address; W = write operation at current write
// address.  RA = read address; WA = write address.
//
// States and rules are as follows:
// 1. empty:   EmptyFIFO flag asserted.  R disabled;
//             RA invalid.
//             W at WA causes RA = WA, WA++, EmptyFIFO
//             deasserted, and transition to a_empty.
// 2. a_empty: R at RA causes transition to empty.
//             W at WA causes WA++ and transition to
//             normal.
// 3. normal:  R at RA causes RA++.  RA == WA-1 causes
//             transition to a_empty.
//             W at WA causes WA++.  WA == RA-1 causes
//             transition to a_full.
// 4. a_full:  R at RA causes RA++ and transition to normal.
//             W at WA causes transition to full.
// 5. full:    FullFIFO flag asserted.  W disabled;
//             WA invalid.
//             R at RA causes WA = RA, RA++, FullFIFO
//             deasserted, and transition to a_full.
//
// ------------------------------------------------------------
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
       , Clk, Reset
       );
//
reg[AWid-1:0] ReadCount, WriteCount;  // The counters.
reg[2:0]     CurState, NextState; // CurState is state reg.
reg          EmptyFIFOReg, FullFIFOReg
           , ReadCmdReg, WriteCmdReg;
// --------------------------------------------------------
assign #1 ReadAddr  = ReadCount;
assign #1 WriteAddr = WriteCount;
assign #1 EmptyFIFO = EmptyFIFOReg;
assign #1 FullFIFO  = FullFIFOReg;
assign #1 ReadCmd   = ReadCmdReg;
assign #1 WriteCmd  = WriteCmdReg;
//
// --------------------------------------------------------
// State encoding.  Use localparams to prevent external
// control.   Because we have extra states (only 5 of
// 8 possible are defined), we encode as mnemonically
// as possible:
//
localparam  empty = 3'b000, // all 0 = empty.
          a_empty = 3'b010, // LSB 0 = close to empty.
           normal = 3'b011, // a_empty < normal < a_full.
           a_full = 3'b101, // MSB 1 = close to full.
             full = 3'b111; // all 1 = full
//
// --------------------------------------------------------
// The sequential block controlling state transitions:
//
always@(posedge Clk, posedge Reset)
  if (Reset==1'b1)
       CurState <= empty;
  else CurState <= NextState;
//
// --------------------------------------------------------
// The counters (FIFO address pointers).
// This can be done many ways, but tasks work. 
// ----------
task incrRead;
  begin
  @(posedge Clk)
    ReadCount = ReadCount + 1;
  end
endtask
// ----------
task incrWrite;
  begin
  @(posedge Clk)
    WriteCount = WriteCount + 1;
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
if (Clk==1'b0)
case (CurState)
         // ---------------------------
  empty: // This state combines the hardware reset
         // with a simple empty state during operation:
         begin
         if (Reset!=1'b0)
           begin
           // Reset conditions:
           FullFIFOReg  = 1'b0;
           WriteCount   =  'b0;
           WriteCmdReg  = 1'b0;
           ReadCmdReg   = 1'b0;
           NextState    = empty;
           end
         EmptyFIFOReg = 1'b1;
         ReadCmdReg   = 1'b0;  // Disable RAM read.
         // One transition rule:
         if (WriteReq==1'b1 && ReadReq==1'b0)
         begin
           ReadCount  = WriteCount;
           incrWrite; // Call task, which blocks on posedge Clk.
           WriteCmdReg  = 1'b1;
           EmptyFIFOReg = 1'b0;
           NextState    = a_empty;
           end
         else ReadCount    = 'bz; // Nowhere.
         end
         // ---------------------------
a_empty: // In this state, we know W == R+1; one read at
         // the current read address will invalidate the 
         // last datum and leave the read pointer nowhere.
         // However, one write will put the FIFO into
         // normal state:
         begin
         EmptyFIFOReg = 1'b0;
         // On a write:
         if ( {WriteReq, ReadReq} == 2'b10 )
           begin
           ReadCmdReg   = 1'b0;  // Disable RAM read.
           WriteCmdReg  = 1'b1;
           incrWrite; // Call task, which blocks on posedge Clk.
           //
           // Transition rule:  Go to normal:
           NextState = normal;
           end
         // On a read:
         if ( {WriteReq, ReadReq} == 2'b01 )
           begin
           WriteCmdReg  = 1'b0; // Disable RAM write.
           ReadCmdReg  = 1'b1;
           // Transition rule:  Go to empty:
           NextState = empty;
           end
         end // a_empty state.
         // ---------------------------
 normal: // In this state, we know W > R+1
         // and R > W+1 before anything happens here.
         // The simplest way to look for a transition,
         // then, is just to compare the new counter
         // value + 1 with the other counter value.
         // If, after increment, W == R+1 or R == W+1,
         // we are no longer in the normal state.
         begin
         // On a write:
         if ( {WriteReq, ReadReq} == 2'b10 )
           begin
           ReadCmdReg   = 1'b0;  // Disable RAM read.
           WriteCmdReg  = 1'b1;
           incrWrite; // Call task, which blocks on posedge Clk.
           //
           // Transition rule:  Check for a_full:
           if ( ReadCount == WriteCount+1 )
                NextState = a_full;
           else NextState = normal;
           end
         // On a read:
         if ( {WriteReq, ReadReq} == 2'b01 )
           begin
           WriteCmdReg = 1'b0; // Disable RAM write.
           ReadCmdReg  = 1'b1;
           incrRead; // Call task, which blocks on posedge Clk.
           //
           // Transition rule:  Check for a_empty:
           if ( ReadCount+1 == WriteCount )
                NextState = a_empty;
           else NextState = normal;
           end
         end // normal state.
         // ---------------------------
 a_full: // In this state, we know R == W+1; one write at
         // the current write address will invalidate the 
         // last datum and leave the write pointer nowhere.
         // However, one read will put the FIFO into
         // normal state:
         begin
         FullFIFOReg  = 1'b0;
         // On a write:
         if ( {WriteReq, ReadReq} == 2'b10 )
           begin
           ReadCmdReg   = 1'b0;  // Disable RAM read.
           WriteCmdReg  = 1'b1;
           // Transition rule:  Go to full:
           NextState = full;
           end
         // On a read:
         if ( {WriteReq, ReadReq} == 2'b01 )
           begin
           WriteCmdReg  = 1'b0; // Disable RAM write.
           ReadCmdReg   = 1'b1;
           incrRead; // Call task, which blocks on posedge Clk.
           // Transition rule:  Go to normal:
           NextState = normal;
           end
         end // a_full state.
         // ---------------------------
   full: // This state has just one possible transition,
         // on a read request:
         begin
         FullFIFOReg  = 1'b1;
         WriteCmdReg  = 1'b0; // Disable RAM write.
         if (WriteReq==1'b0 && ReadReq==1'b1)
           begin
           WriteCount = ReadCount;
           incrRead; // Call task, which blocks on posedge Clk.
           FullFIFOReg  = 1'b0;
           ReadCmdReg   = 1'b1;
           NextState    = a_full;
           end
         else WriteCount  = 'bz; // Nowhere.
         end // full state.
         // ---------------------------
default: NextState = empty; // Always handle the unknown.
endcase
end // always@(*)
//
endmodule // FIFOStateM.
//
