// ===========================================================
// Counter:  The Counter module does a simple up-count,
// with asynchronous reset.   It allows the count to be
// suspended while the clock still is running.
//
// The count is stored in a register, and the assignments
// are sequential logic, so the nonblocking assignment
// operator, <=, is used throughout that block.   Use of
// this operator will be explained later.
//
// ------------------------------------------------------------
// 2005-08-23 jmw: v. 1.3 Added gated clock for enable.
// 2005-02-14 jmw: v. 1.2 Removed `DC switches & moved delay to
//            the assign.
// 2005-01-27 jmw: v. 1.1 `DC switches to overcome dc limitation.
// 2004-12-02 jmw: v. 1.0 implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module Counter #(parameter pHi = 3)    // default.
                (output[pHi:0] Count
                , input Clock, CountEnable, CountReset);
  //
  reg[pHi:0] CountReg;   // Store the count.
  wire       ClockWire;  // To gate the clock during disable.
  //
  // Keep the count wired to the output:
  assign #1 Count = CountReg;
  //
  // Don't count while disabled:
  assign ClockWire = (CountEnable==1'b1)? Clock : 1'b0;
  //
  // Do the counter:
  //
  always@(posedge ClockWire, posedge CountReset)
    begin
    if (CountReset==1'b1) 
           CountReg <= 'b0; // Ignore width.
      else CountReg <= CountReg + 1'b1;
    end
  //
endmodule // Counter.
