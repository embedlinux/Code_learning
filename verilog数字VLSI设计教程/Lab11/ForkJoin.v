// ===========================================================
// ForkJoin:  Demonstrates Use of a parallel block to 
// synchronize assignments to separate bits of a bus.
//
// Not intended for synthesis.
//
// ------------------------------------------------------------
// 2004-12-30 jmw: v. 1.0 Implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module ForkJoin(output[7:0] OutBus, input Ena1, Ena2);
  //
  reg[7:0] DataBus;
  reg[3:0] temp;
  //
  initial #0 DataBus = 8'h00;
  //
  // Plain, concurrent execution:
  //
  always@(posedge Ena1)
    begin
    #2 DataBus[0] <= 1'b0;
    #2 DataBus[1] <= 1'b1;
    end
  always@(posedge Ena2)
    begin
    #2 DataBus[2] <= 1'b1;
    #1 DataBus[3] <= 1'b0;
    end
  assign OutBus[3:0] = DataBus[3:0];
  //
  // Parallel block control:
  //
  always@(posedge Ena1)
    begin
    fork
    #2 DataBus[4] <= 1'b0;
    #2 DataBus[5] <= 1'b1;
    @(posedge Ena2)
      begin
      #2 DataBus[6] <= 1'b1;
      #1 DataBus[7] <= 1'b0;
      end
    join
    temp <= DataBus[7:4];
    end
  assign OutBus[7:4] = temp;
  //
endmodule // ForkJoin.
//
module ForkJoinTst;
  //
  wire[7:0] OutBusWatch;
  reg       Ena1Stim, Ena2Stim;
  //
  always@(Ena1Stim) #10 Ena1Stim <= ~Ena1Stim;
  always@(Ena2Stim) #15 Ena2Stim <= ~Ena2Stim;
  //
  initial
    begin
    #00   Ena1Stim = 1'b0;
    #00   Ena2Stim = 1'b0;

    #20  $finish;
    end
  //
  ForkJoin 
  ForkJoinInst1( .OutBus(OutBusWatch)
               , .Ena1(Ena1Stim)
               , .Ena2(Ena2Stim)
               );
  //
endmodule //ForkJoinTst.
