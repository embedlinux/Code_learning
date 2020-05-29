// =============================================
// HierParam.  Lab problem in parameter passing.
// Replace the '?' areas with correct parameter
// overrides consistent with the Workbook
// requirements.
//
// 2005-02-02 jmw:  v. 1.0 completed.
// =============================================
module 
HierParam #(parameter Wid = 32, ResWid = 32)
          ( output[ResWid-1:0] ResultBus
          , inout[Wid-1:0] DataB, input[3:0] Ctl, input Clk);
wire[ResWid/2-1:0] ResBusHi, ResBusLo;
...
assign ResultBus = { ResBusHi, ResBusLo };
//
Level2 #(???)
L2_01 (.ResL2(ResBusHi), .DataB(DataB[Wid/2-1:0]), .Ctl(Ctl), .Clk(Clk));
//
Level2 #(???)
L2_02 (.ResL2(ResBusLo), .DataB(DataB[Wid-1:Wid/2]), .Ctl(Ctl), .Clk(Clk));
//
endmodule // HierParam.
// ====================
module Level2 #(parameter Wid = 1, ResWid = 1)
       (output[ResWid-1:0] ResL2
       , inout[Wid-1:0] DataB, input[3:0] Ctl, input Clk) ;
...
Level3 #(???)
L3_01 (.DataB(DataB[Wid-1:Wid/2]), .Ctl(Ctl), .Clk(Clk) );
//
Level3 #(???)
L3_02 (.DataB(DataB[Wid/2-1:0]), .Ctl(Ctl), .Clk(Clk) );
//
endmodule
// ====================
module Level3 #(parameter Wid = 1)
       (inout[Wid-1:0] DataB, input[3:0] Ctl, input Clk) ;
...
Level4 #(???)
L4_01 (.DataB(DataB[Wid-1:Wid/2]), .Ctl(Ctl), .Clk(Clk) );
//
Level4 #(???)
L4_02 (.DataB(DataB[Wid/2-1:0]), .Ctl(Ctl), .Clk(Clk) );
//
endmodule
// ====================
module Level4 #(parameter Wid = 1)
       (inout[Wid-1:0] DataB, input[3:0] Ctl, input Clk) ;
  always@(negedge Clk)
    ...
endmodule

