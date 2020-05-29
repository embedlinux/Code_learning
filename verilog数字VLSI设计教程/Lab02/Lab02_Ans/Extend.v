// ===========================================================
// Extend:   A simple design showing the effect of
// logic value extension when assigning a bit to a vector.
//
// ANSI module header.
// ------------------------------------------------------------
// 2005-11-02 jmw:  v. 1.2 Moved reg dec inside module.
// 2004-12-05 jmw:  v. 1.1 Fixed "array" to "vector".
// 2004-11-30 jmw:  v. 1.0 implemented.
// ============================================================
`timescale 1ns/100ps
//
module Extend (output[47:0] My48bits, My48bit);
  // No need for inputs.
  // For good design practice, the outputs are converted
  // explicitly from reg to wire by continuous assigns.
  //
  reg[47:0] My48bitsReg, My48bitReg;
  assign My48bits = My48bitsReg;
  assign My48bit  = My48bitReg;
  //
  // An initial block is procedural and thus is not
  // allowed to assign to a wire -- only to a reg or
  // integer:
  //
  initial
    begin
    #5   My48bitsReg =  'bz;
    #0.1 My48bitReg  = 1'bz;
    #5   My48bitsReg =  'bx;
    #0.1 My48bitReg  = 1'bx;
    #5   My48bitsReg =  'b0;
    #0.1 My48bitReg  = 1'b0;
    #5   My48bitsReg =  'b1;
    #0.1 My48bitReg  = 1'b1;
    #5 $finish;
    end
  //
endmodule // Extend
