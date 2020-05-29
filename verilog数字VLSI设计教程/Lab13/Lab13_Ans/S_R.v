// ===========================================================
// S_R:  A S-R latch for assembly of a D flip-flop in Lab 12
// from elementary (nand) gates.
//
// ------------------------------------------------------------
// 2005-01-06 jmw: v. 1.0 Assembled as defined in DFFGates.v.
// ============================================================
//
module S_R (output oS, oR, input iS, is, iR, ir);
//
wire to_oS, to_oR;
//
// Two 3-input nands, with two inputs cross-connected locally:
//
assign oS = to_oS;
assign oR = to_oR;
//
nand TopNand (to_oS, iS, to_oR, is);
nand BotNand (to_oR, iR, to_oS, ir);
//
endmodule // S_R.
