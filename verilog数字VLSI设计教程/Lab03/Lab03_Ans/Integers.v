// ===========================================================
// Integers:  Miscellaneous integer arithmetic exercises.
//
// ------------------------------------------------------------
// 2004-12-02 jmw: v. 1.0 implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module Integers;
  //
  integer   iX, iA, iB;
  reg[31:0] rX, rA, rB;
  //
  initial
    begin
    //
    #1 iX =   0; iA =   0; iB =   0; // time = 1
       rX = 'b0; rA = 'b0; rB = 'b0;
    // A. Signed (simple) integers:
       iA = 16;
       iB = -8;
    #1 iX = iA + iB;
    #1 iX = iA - iB;
    #1 iX = iB - iA;
    #1 iX =   0; iA =   0; iB =   0; // time = 5
       rX = 'b0; rA = 'b0; rB = 'b0;
    // B. Registers (unsigned):
       rA = 32'd16;
       rB = -32'd8;
    #1 rX = rA + rB;
    #1 rX = rA - rB;
    #1 rX = rB - rA;
    #1 iX =   0; iA =   0; iB =   0; // time = 9
       rX = 'b0; rA = 'b0; rB = 'b0;
    // C. Just X integer:
       rA = 32'd16;
       rB = -32'd8;
    #1 iX = rA + rB;
    #1 iX = rA - rB;
    #1 iX = rB - rA;
    #1 iX =   0; iA =   0; iB =   0; // time = 13
       rX = 'b0; rA = 'b0; rB = 'b0;
    // C. Just A integer:
       iA = 16;
       rB = -32'd8;
    #1 rX = iA + rB;
    #1 rX = iA - rB;
    #1 rX = rB - iA;
    #1 iX =   0; iA =   0; iB =   0; // time = 17
       rX = 'b0; rA = 'b0; rB = 'b0;
    // C. Just B integer:
       rA = 32'd16;
       iB = -8;
    #1 rX = rA + iB;
    #1 rX = rA - iB;
    #1 rX = iB - rA;
    #1 iX =   0; iA =   0; iB =   0; // time = 21
       rX = 'b0; rA = 'b0; rB = 'b0;
    #2 $finish;
    end
  //
endmodule // Integers.
