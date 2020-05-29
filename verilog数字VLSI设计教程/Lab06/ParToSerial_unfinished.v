// ===========================================================
// ParToSerial:  Generic parallel-to-serial converter.
//               Unfinished version.
//
// Assumes:  Parallel data stay valid while ParValid==1.
// Uses SerValid reg for state.  Done reg prevents repeated
// serial transfers during the same ParValid interval.
//
// ------------------------------------------------------------
// 2007-03-25 jmw: v. 1.2 Changed clocked blockings to nonblocking.
//            Minor comment changes.
// 2005-04-20 jmw:        Removed parameters and testbench to
//            provide template for Lab06.
// 2005-01-31 jmw: v. 1.1 Modified for synthesis.
// 2004-12-12 jmw: v. 1.0 Implemented.
// ============================================================
//
module ParToSerial (output SerOut, SerValidFlag
                    , input SerClock, ParValid
                    , input[31:0] BusIn
                    );
  integer ix; // Small reg OK, too.
  reg SerValid, Done, SerBit;
  //
  assign #1 SerValidFlag = SerValid;
  assign #2 SerOut      = SerBit;
  //
  always@(posedge SerClock)
    begin // Reset everything unless ParValid:
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
                 ix       <= 31;
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

