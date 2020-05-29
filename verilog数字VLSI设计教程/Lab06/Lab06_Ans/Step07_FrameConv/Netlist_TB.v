// ===========================================================
// Exact copy of the SerFrameEnc.v testbench, to
// use for netlist simulation.
// ------------------------------------------------------------
// 2006-08-11 jmw: v. 1.0 Created by copying.
// ============================================================
//
`timescale 1 ns/ 100 ps
//
module SerFrameEncTst;
  //
  reg[31:0] BusInReg;
  reg       DoFrameReg;
  wire[63:0] FrameOutwatch;
  wire[31:0] BusInstim;
  wire      DoFramestim;
  //
  assign BusInstim   = BusInReg;
  assign DoFramestim = DoFrameReg;
  //
  SerFrameEnc FramEnc01 ( .FrameOut(FrameOutwatch)
                        , .BusIn(BusInstim), .DoFrame(DoFramestim)
                        );
  //
  always@(DoFrameReg)
    begin
    #45 DoFrameReg <= 1'b1;
    @(DoFrameReg)
      #05 DoFrameReg <= 1'b0;
    end
  //
  initial
    begin
    #0   DoFrameReg = 1'b0;
    #40  BusInReg   = 32'hzzzzzzzz;
    #50  BusInReg   = 32'h00001111;
    #50  BusInReg   = 32'h11111111;
    #50  BusInReg   = 32'hffff0000;
    #50  BusInReg   = 32'h1f1f1f1f;
    #50  BusInReg   = 32'hf1f1f1f1;
    #50  BusInReg   = 32'hf0f0f0f0;
    #50  BusInReg   = 32'h0f0f0f0f;
    #50  BusInReg   = 32'hffffffff;
    #50  BusInReg   = 32'h00000000;
    #50  BusInReg   = 32'haaaaaaaa;
    #50  BusInReg   = 32'h55555555;
    #100 $finish;
    end
  //
endmodule // SerFrameEncTst.
