// ===========================================================
// FileName : par2serial.v
// Function : Generic parallel-to-serial converter.
//            Unfinished version.
//
// Assumes:  Parallel data stay valid while ParValid==1.
// Uses SerValid reg for state.  Done reg prevents repeated
// serial transfers during the same ParValid interval.
//
// ------------------------------------------------------------
// Modification: Changed clocked blockings to nonblocking.
//
// Author   : QilinZhao
// Version  : v-1.0
// Date     : 2013-09-02
// E-mail   : forqilin@163.com
// Copyright: QiXin Studio
// ============================================================

module par2serial (output SerOut, SerValidFlag,
                   input SerClock, ParValid,
                   input[31:0] BusIn
                  );
  integer ix; // Small reg OK, too.
  reg SerValid, Done, SerBit;
  
  assign #1 SerValidFlag = SerValid;
  assign #2 SerOut       = SerBit;
  
  always@(posedge SerClock)
  begin // Reset everything unless ParValid
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
      else // No start yet: ParValid:1; SerValid:0
      begin
        if (Done==1'b0)
        begin
          SerValid <= 1'b1; // Flag start on next SerClock.
          ix       <= 31;
          // Ready to start on next SerClock.
        end
          SerBit <= 1'b0; // Serial bit default.
      end
    else // ParValid:0; reset everything
    begin
      SerValid <= 1'b0;
      Done     <= 1'b0;
      SerBit   <= 1'b0; // Serial bit default.
    end // if ParValid else
  end // always
  
endmodule // par2serial

