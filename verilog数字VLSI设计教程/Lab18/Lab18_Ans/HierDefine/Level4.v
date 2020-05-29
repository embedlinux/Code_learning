// =============================================
// Level4.  Lab problem in parameter passing
// by `define.
//
// 2006-10-11 jmw:  v. 1.2 Added comment to compile.
//      Also added a driver to the inout.
// 2006-06-07 jmw:  v. 1.1 Fixed Wid4 typo.
// 2005-02-02 jmw:  v. 1.0 completed.
// =============================================
//
module Level4 (inout[(`Wid/4)-1:0] DataB, input[3:0] Ctl, input Clk) ;
//
assign #1 DataB = Ctl & {2'b11, Clk, ~Clk};
//  always@(negedge Clk)
//    ...
endmodule

