// =============================================
// Level3.  Lab problem in parameter passing
// by `define.
//
// 2006-06-07 jmw:  v. 1.1 Added parens for clarity.
//      Fixed Wid3 typo.
// 2005-02-02 jmw:  v. 1.0 completed.
// =============================================
`define Wid    8
//
module Level3 (inout[`Wid-1:0] DataB, input[3:0] Ctl, input Clk) ;
...
Level4 L4_01 (.DataB(DataB[`Wid-1:(`Wid/2)]), .Ctl(Ctl), .Clk(Clk) );
Level4 L4_02 (.DataB(DataB[(`Wid/2)-1:0]), .Ctl(Ctl), .Clk(Clk) );
endmodule

