// ===========================================================
// Converter:  Converts a register value to the same value
// assigned to the lower-order bits in a bus of configurable
// width.
//
// ------------------------------------------------------------
// 2004-12-02 jmw: v. 1.0 implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module Converter #(parameter pHi = 3, pPad = 0) // defaults.
       (output[pHi+pPad:0] OutBus
       , input[pHi:0] InBus
       , input Enable
       );
  //
  reg[pHi+pPad:0] BusReg      // Retains current count value.
                , OutBusGate; // Retains three-state.
  //
  // Keep BusReg always updated (combinational):
  always@(InBus)
    begin
    // This could be done by concatenation, a later topic:
    BusReg[pHi:0] = InBus;
    if (pPad!=1'b0)
      BusReg[pHi+pPad:pHi+1] = 'b0; // Pad with 0.
    end
  //
  // Next block controls the state of the output drivers:
  always@(Enable, BusReg)
    if (Enable==1'b1)
         #2 OutBusGate = BusReg;
    else #1 OutBusGate = 'bz; // Set high-impedance.
  //
  // Connect output drivers to output pins:
  assign OutBus = OutBusGate;
  //
endmodule // Converter.
