// ===========================================================
// Counter4:  A 4-bit behavioral counter.
//
// ------------------------------------------------------------
// 2005-08-31 jmw: v. 2.0 Removed testbench to separate file.
// 2005-04-14 jmw: v. 1.2 Changed + to - for Lab08 Step 3.
// 2005-01-28 jmw: v. 1.1 Moved delays away from the nonblocking
//            assignments for synthesis compatibility.
// 2004-12-20 jmw: v. 1.0 implemented.
// ============================================================
//
`timescale 1ns/100ps
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
    else CountReg <= CountReg - 1;
    end
  //
endmodule // Counter4.
//
