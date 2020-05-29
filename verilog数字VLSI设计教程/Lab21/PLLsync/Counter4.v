// ===========================================================
// Counter4:  A 4-bit behavioral counter.
//
// ------------------------------------------------------------
// 2005-01-28 jmw: v. 1.2 moved here for PLL clock; testbench
//            and timescale removed. 
// 2005-01-28 jmw: v. 1.1 Moved delays away from the nonblocking
//            assignments for synthesis compatibility.
// 2004-12-20 jmw: v. 1.0 implemented.
// ============================================================
//
module Counter4 ( output[3:0] CountOut, input ClockIn, Clear);
  //
  reg[3:0] CountReg;
  //
  assign #3 CountOut = CountReg;
  //
  always@(posedge ClockIn, posedge Clear)
    begin
    if (Clear==1'b1)
         CountReg <= 4'b0000;
    else CountReg <= CountReg + 1;
    end
  //
endmodule // Counter4.
//
