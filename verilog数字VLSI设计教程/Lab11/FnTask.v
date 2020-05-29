// ===========================================================
// FnTask:  Demonstrates Use of a task and a function.
//
// ------------------------------------------------------------
// 2005-01-30 jmw: v. 1.1 Task assigns blocking.
// 2004-12-30 jmw: v. 1.0 Implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module FnTask(output[7:0] FnOut, output[3:0] TaskOut
             , input[31:0] InBus, input Clk
             );
  reg[7:0] FnOutReg;
  reg[3:0] TaskOutReg;
  //
  assign #2 FnOut   = FnOutReg;
  assign TaskOut = TaskOutReg;
  // -----------
  task SwizzleIt (output[3:0] SwizOut
                 , input[3:0] SwizIn, input Ena);
    begin
    if (Ena==1'b1)
         #7 SwizOut = {SwizIn[2],SwizIn[3],SwizIn[0],SwizIn[1]};
    else #5 SwizOut = SwizIn;
    end
  endtask
  // -----------
  function[7:0]  doCheckSum ( input[63:0] DataArray );
    reg[15:0] temp1, temp2;
    begin
    temp1 = DataArray[15:0]  ^ DataArray[31:16];
    temp2 = DataArray[63:48] ^ DataArray[47:32];
    doCheckSum = temp1[7:0]+temp2[7:0]^temp1[15:8]+temp2[15:8];
    end
  endfunction
  // -----------
  //
  always@(posedge Clk)
    begin
    SwizzleIt( TaskOutReg, InBus[3:0], InBus[4] );
    FnOutReg <= doCheckSum( {InBus, InBus} );
    end
  //
endmodule // FnTask.
//
`ifdef DC
`else
module FnTaskTst;
  //
  wire[7:0] FunctionWatch;
  wire[3:0] TaskWatch;
  reg       ClockStim;
  reg[31:0] InBusReg;
  //
  always@(ClockStim) #10 ClockStim <= ~ClockStim;
  always@(ClockStim) #1 InBusReg <= InBusReg + 1;
  //
  initial
    begin
    #00   ClockStim = 1'b0;
    #00   InBusReg  = 32'h7777_3333;
    #05   ClockStim = 1'b0;
    #20   InBusReg  = 32'heeee_6666;

    #50  $finish;
    end
  //
  FnTask 
  FnTaskInst1( .FnOut(FunctionWatch), .TaskOut(TaskWatch)
             , .InBus(InBusReg), .Clk(ClockStim) );
  //
endmodule //FnTaskTst.
`endif

