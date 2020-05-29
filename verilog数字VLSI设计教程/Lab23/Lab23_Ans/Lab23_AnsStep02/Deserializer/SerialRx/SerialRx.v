// ===========================================================
// SerialRx: The serial receiver which instantiates the PLL
//       but does not do much else.
// ------------------------------------------------------------
// 2006-05-17 jmw: v. 1.0 Implemented.
// ============================================================
//
module SerialRx
       ( output SerClk, SerData , input SerLinkIn, ParClk, Reset );
//
assign SerData = SerLinkIn;
//
PLLTop PLL_RxU1 ( .ClockOut(SerClk), .ClockIn(ParClk), .Reset(Reset) );
//
endmodule // SerialRx.
//
