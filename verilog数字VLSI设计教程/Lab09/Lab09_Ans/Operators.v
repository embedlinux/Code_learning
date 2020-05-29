// ===========================================================
// Operators:  Shows results of various operators and 
//             precedence.
//
// ------------------------------------------------------------
// 2005-08-31 jmw: v. 1.1 Extended $finish from 50 to 210.
// 2004-12-26 jmw: v. 1.0 Implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module Operators;
  //
  reg[7:0] Bus;  // Vary width down to 2.
  //
  reg Evaluate, Parens, NoParens;
  wire a, b, c, d;
  //
  assign a = 1'b1;
  assign b = 1'b1;
  assign c = 1'b0;
  assign d = 1'b0;
  //
  initial 
    begin
    #0   Bus      = 8'hzz;
    #0   Evaluate = 1'b0;
    #210 $finish;
    end
  //
  always@(Evaluate)
    begin
    #10 Bus = 3'b110 & 4'b1111;
    #10 Bus = 3'b010 & 5'b00111;
    #10 Bus = 3'b101 & 3'b111;
    #10 Bus = 3'b010 && 6'b111000;
    #00 Parens = (a&(!d)^b|a&(~d)^a) ||((~a)^b^c^a) && d;
    #00 NoParens = a&!d^b|a&~d^a||~a^b^c^a&&d;
    end
  //
  always@(Evaluate) #100 Evaluate <= ~Evaluate;
  //
  //
endmodule // Operators.
//
