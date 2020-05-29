// ====================================================
// HierParamAns.  Solution to the HierParam lab
// problem in parameter passing.
//
// 2007-11-20 jmw:  v. 1.2 Renamed module to HierParam.
//            Changed timescale res to 1 ns.
// 2005-05-03 jmw:  v. 1.1 Commented so VCS
//            will compile it (uselessly).
// 2005-02-02 jmw:  v. 1.0 completed.
// ====================================================
`timescale 1ns/1ns
//
module 
HierParam #(parameter Wid = 32, ResWid = 32)
             ( output[ResWid-1:0] ResultBus
             , inout[Wid-1:0] DataB, input[3:0] Ctl, input Clk);
wire[ResWid/2-1:0] ResBusHi, ResBusLo;
// ...
assign ResultBus = { ResBusHi, ResBusLo };
//
Level2 #(.Wid(Wid/2), .ResWid(ResWid/2) )
L2_01 (.ResL2(ResBusHi), .DataB(DataB[Wid/2-1:0]), .Ctl(Ctl), .Clk(Clk));
//
Level2 #(.Wid(Wid/2), .ResWid(ResWid/2) )
L2_02 (.ResL2(ResBusLo), .DataB(DataB[Wid-1:Wid/2]), .Ctl(Ctl), .Clk(Clk));
//
endmodule // HierParamAns.
// ====================
module Level2 #(parameter Wid = 1, ResWid = 1)
       (output[ResWid-1:0] ResL2
       , inout[Wid-1:0] DataB, input[3:0] Ctl, input Clk) ;
// ...
Level3 #(.Wid(Wid/2))
L3_01 (.DataB(DataB[Wid-1:Wid/2]), .Ctl(Ctl), .Clk(Clk) );
//
Level3 #(.Wid(Wid/2))
L3_02 (.DataB(DataB[Wid/2-1:0]), .Ctl(Ctl), .Clk(Clk) );
//
endmodule
// ====================
module Level3 #(parameter Wid = 1)
       (inout[Wid-1:0] DataB, input[3:0] Ctl, input Clk) ;
// ...
Level4 #(.Wid(Wid/2))
L4_01 (.DataB(DataB[Wid-1:Wid/2]), .Ctl(Ctl), .Clk(Clk) );
//
Level4 #(.Wid(Wid/2))
L4_02 (.DataB(DataB[Wid/2-1:0]), .Ctl(Ctl), .Clk(Clk) );
//
endmodule
// ====================
module Level4 #(parameter Wid = 1)
       (inout[Wid-1:0] DataB, input[3:0] Ctl, input Clk) ;
  // always@(negedge Clk)
  //   ...
endmodule

