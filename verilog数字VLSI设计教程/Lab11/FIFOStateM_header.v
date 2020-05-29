// ===========================================================
// FIFOStateM:  The FIFO state machine controlling access to
// the FIFO registers (memory).
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
// (date) (your initials): v. 1.0 Implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module FIFOStateM
       #(parameter AdrHi=4) // 2**(AdrHi+1) registers. Default=32.
        ( output[AdrHi:0] ReadAddr, WriteAddr // The 2 pointers.
        , output EmptyFIFO, FullFIFO // Flags to other devices.
        , ReadCmd, WriteCmd          // Controls to FIFO RAM.
        , input ReadReq, WriteReq    // External requests.
        , Clk, Reset
        );
  //
  reg[AdrHi:0] ReadAddrReg, WriteAddrReg;
  reg[2:0]     CurState, NextState; // CurState is state reg.
  reg          EmptyFIFOReg, FullFIFOReg
             , ReadCmdReg, WriteCmdReg;
  //
  assign #1 ReadAddr  = ReadAddrReg;
  assign #1 WriteAddr = WriteAddrReg;
  assign #1 EmptyFIFO = EmptyFIFOReg;
  assign #1 FullFIFO  = FullFIFOReg;
  assign #1 ReadCmd   = ReadCmdReg;
  assign #1 WriteCmd  = WriteCmdReg;
  //
  // State encoding.  Use localparams to prevent external
  // control.   Because we have extra states (only 5 of
  // 8 possible are defined), we encode as mnemonically
  // as possible:
  //
  localparam  empty = 3'b000, // all 0 = empty.
            a_empty = 3'b010, // LSB 0 = close to empty.
             normal = 3'b011,
             a_full = 3'b101, // MSB 1 = close to full.
               full = 3'b111; // all 1 = full
  //
  // The sequential block controlling state transitions:
  //
  always@(posedge Clk, posedge Reset)
    if (Reset==1'b1)
         CurState <= empty;
    else CurState <= NextState;
  //
  always@(*)
    begin
    if (Clk==1'b0)
    case (CurState)
      empty: begin
             EmptyFIFOReg = 1'b1; // Deassert on exit.

             // Reset conditions:

             // transition rules:
             if (WriteReq==1'b1 && ReadReq==1'b0)
               begin
               NextState = a_empty;
               end
             end
    a_empty: begin
             // transition rules:
             end
     normal: begin
             // transition rules:
             end
     a_full: begin
             // transition rules:
             end
       full: begin
             FullFIFOReg = 1'b1; // Deassert on exit.
             WriteAddrReg = 'bz;
             // transition rules:
             end
    default: NextState = empty; // Reset on unknown.
    endcase
    end
  //
endmodule // FIFOStateM.
//
// ----------------------------------------
//
//
// Disabled tb to include in Lab11 FIFO_Top design:
//
//`define COMMENTED_OUT  // uncomment to run tb on SM.
`ifdef COMMENTED_OUT
`ifdef DC
`else
module FIFOStateM_Tst;
  //
  parameter AdrHi = 4;
  //
  wire[AdrHi:0] ReadAddrWatch, WriteAddrWatch;
  wire          EmptyFIFOWatch, FullFIFOWatch
              , ReadCmdWatch, WriteCmdWatch;
  reg           ReadReqStim, WriteReqStim
              , ClockStim, ResetStim;
  integer i;
  //
  localparam AdrWid = AdrHi+1;

  //
  always@(ClockStim) #10 ClockStim <= ~ClockStim;
  //
  initial
    begin
    fork
    #0   ResetStim = 1'b0;
    #10  ResetStim = 1'b1;
    #50  ResetStim = 1'b0;
    #0   ClockStim = 1'b0;
    join
    #1   ReadReqStim  = 1'b1;
    #25  ReadReqStim  = 1'b0;
    for (i=0; i<=5; i = i+1)
      begin
      #35  WriteReqStim = 1'b1;
      #35  WriteReqStim = 1'b0;
      end
    for (i=0; i<=3; i = i+1)
      begin
      #35  ReadReqStim = 1'b1;
      #35  ReadReqStim = 1'b0;
      end
    #35  ReadReqStim  = 1'b0;
    #35  WriteReqStim = 1'b1;
    #1000 WriteReqStim = 1'b0;
    #35  ReadReqStim  = 1'b1;
    #1000  $finish;
    end
  //
  FIFOStateM 
  FIFOStateM1( .ReadAddr(ReadAddrWatch)
             , .WriteAddr(WriteAddrWatch)
             , .EmptyFIFO(EmptyFIFOWatch)
             , .FullFIFO(FullFIFOWatch)
             , .ReadCmd(ReadCmdWatch), .WriteCmd(WriteCmdWatch)
             , .ReadReq(ReadReqStim), .WriteReq(WriteReqStim)
             , .Clk(ClockStim), .Reset(ResetStim)
             );
  //
endmodule // FIFOStateM_Tst.
`endif
`endif
