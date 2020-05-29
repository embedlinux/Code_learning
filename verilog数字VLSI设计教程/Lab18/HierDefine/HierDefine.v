// =============================================
// HierDefine.  Lab problem in parameter passing
// by `define and not parameters.
// 
// These files have to be ordered correctly
// to be compiled.
//
// 2006-06-07 jmw:  v. 1.1 Added parens for clarity.
// 2005-02-02 jmw:  v. 1.0 completed.
// =============================================
`define Wid    32
`define ResWid 32
//
module HierDefine ( output[(`ResWid-1):0] ResultBus
                  , inout[(`Wid-1):0] DataB
                  , input[3:0] Ctl, input Clk);
wire[(`ResWid/2)-1:0] ResBusHi, ResBusLo;
...
assign ResultBus = { ResBusHi, ResBusLo };
//
Level2 L2_01
       ( .ResL2(ResBusHi), .DataB(DataB[(`Wid/2)-1:0])
       , .Ctl(Ctl), .Clk(Clk) );
Level2 L2_02 
       ( .ResL2(ResBusLo), .DataB(DataB[`Wid-1:(`Wid/2)])
       , .Ctl(Ctl), .Clk(Clk) );
endmodule // HierDefine.

