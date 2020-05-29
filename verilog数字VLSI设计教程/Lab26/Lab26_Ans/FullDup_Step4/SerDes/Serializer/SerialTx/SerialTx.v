// =======================================================
// SerialTx.   The serial transmitter module of the
// Serializer.  Contains an instance of a PLL;
// normally, the layout of this block would contain all
// components with analogue functionality (for example,
// the VFO in the PLL).
//
// -------------------------------------------------------
// 2006-01-01 jmw: v. 1.0 Implemented.
// =======================================================
//
module SerialTx ( output SerOut, SerClk
                , input SerIn, ParClk, Reset
                );
//
assign SerOut = SerIn;
//
PLLTop
PLL_TxU1 ( .ClockOut(SerClk), .ClockIn(ParClk), .Reset(Reset) );
//
endmodule // SerialTx.

