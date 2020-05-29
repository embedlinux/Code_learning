// ===========================================================
// ParToSerial:  Generic parallel-to-serial converter.
//               Parameterized input bus width.
//
// Assumes:  Parallel data stay valid while ParValid==1.
// Uses SerValid reg for state.  Done reg prevents repeated
// serial transfers during the same ParValid interval.
//
// ------------------------------------------------------------
// 2007-03-25 jmw: v. 1.2 Changed clocked blockings to
//            nonblocking.  Changed ix declaration to reg.
//            Minor comment changes.
// 2005-01-31 jmw: v. 1.1 Modified for synthesis.
// 2004-12-12 jmw: v. 1.0 Implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module ParToSerial #(parameter BusHi = 15)
                    (output SerOut, SerValidFlag
                    , input SerClock, ParValid
                    , input[BusHi:0] BusIn
                    );
  //
  // A clever way to declare the width of ix to agree with
  // the parameterized width of BusHi would be to calculate
  // the log using the C-like conditional expression operator.
  //
  // Note:  A localparam is the same as a parameter,
  // which would be OK here.   A localparam can not be
  // overridden; it gets a definite value, not just a default.
  //
  localparam ixHi = (BusHi <  2**2)?  1
                  : (BusHi <  2**3)?  2
                  : (BusHi <  2**4)?  3
                  : (BusHi <  2**5)?  4
                  : (BusHi <  2**6)?  5
                  : (BusHi <  2**7)?  6
                  : (BusHi <  2**8)?  7
                  : (BusHi <  2**9)?  8
                  : (BusHi < 2**10)?  9
                  : (BusHi < 2**11)? 10
                  : 'bx;
  // Might as well stop at 10:  That will handle
  // BusIn up to 2**11 = 2048 bits wide.
  //
  reg[ixHi:0] ix;
  //
  reg SerValid, Done, SerBit;
  //
  assign #1 SerValidFlag = SerValid;
  assign #2 SerOut       = SerBit;
  //
  always@(posedge SerClock)
    begin
    // Reset everything unless ParValid:
    if (ParValid==1'b1)
          if (SerValid==1'b1)
               begin
               SerBit <= BusIn[ix]; // Current serial bit.
               if (ix==0)
                    begin
                    SerValid <= 1'b0;
                    Done     <= 1'b1;
                    end
               else ix <= ix - 1;
               end // SerValid was asserted.
          else // No start yet:
               begin
               if (Done==1'b0)
                 begin
                 SerValid <= 1'b1; // Flag start on next SerClock.
                 ix       <= BusHi;
                 // Ready to start on next SerClock.
                 end
               SerBit <= 1'b0; // Serial bit default.
               end
      else // ParValid not 1; reset everything:
           begin
           SerValid <= 1'b0;
           Done     <= 1'b0;
           SerBit   <= 1'b0; // Serial bit default.
           end // if ParValid else
    end // always
  //
endmodule // ParToSerial.
//
// ----------------------------------------------------------------
// Simulation Testbench here:
//
`ifdef DC
`else
module ParToSerialTst;
  //
  parameter WidthParam = 32;
  reg[WidthParam-1:0] BusInstim;
  reg SerClockstim, ParValidstim;
  //
  ParToSerial #( .BusHi(WidthParam-1) ) 
  PtoS01       ( .SerOut(SerOutwatch), .SerValidFlag(SerValidFlagwatch)
               , .SerClock(SerClockstim)
               , .ParValid(ParValidstim), .BusIn(BusInstim)
               );
  //
  always@(SerClockstim) // 100 MHz
     #5 SerClockstim <= ~SerClockstim;
  //
  always@(BusInstim) // 1 MHz
    begin
    #500 BusInstim <= BusInstim << 1;
    if (BusInstim==32'h00008888)
      #500 BusInstim <= 32'h88881111;
    end
  //
  always@(BusInstim)
    begin
    #14 ParValidstim  = 1'b1;
    #460 ParValidstim = 1'b0;
    end
  //
  initial
    begin
    #0    SerClockstim = 1'b0;
    #0    ParValidstim = 1'b0;
    #21   BusInstim    = 32'h00001111;
    #5000 $finish;
    end
  //
endmodule // ParToSerialTst.
`endif
