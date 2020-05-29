// =============================================
// Level2.  Lab problem in parameter passing
// by `define.
//
// 2006-06-07 jmw:  v. 1.1 Added parens for clarity.
//      Fixed Wid2 typo.
// 2005-02-02 jmw:  v. 1.0 completed.
// =============================================
`define Wid    16
`define ResWid 16
//
module Level2 (output[`ResWid-1:0] ResL2
       , inout[`Wid-1:0] DataB
       , input[3:0] Ctl, input Clk) ;
...
Level3 L3_01 (.DataB(DataB[`Wid-1:(`Wid/2)]), .Ctl(Ctl), .Clk(Clk) );
Level3 L3_02 (.DataB(DataB[(`Wid/2)-1:0]), .Ctl(Ctl), .Clk(Clk) );
endmodule

