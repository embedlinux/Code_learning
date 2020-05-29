// ===================================================
// ReportToggleA.   A simple device demonstrating
// concurrency in verilog, using (A) always blocks.
// The device monitors bits toggling on an input
// bus and reports each bit by its bus position
// on an output bus.
//
//  Note:  Silos can't accept the 'automatic' declaration,
//         and VCS-MX 7.1.2 dumps core if a bit-select
//         appears in the task event control.
//         Likewise, ModelSim (QuestaSim v. 6.1e) reports
//         internal errors and crashes on repeated attempts.
//
//         However, VCS-MX 7.2 and later VCS versions
//         simulate the bit-select correctly.
//
// ---------------------------------------------------
// 2006-09-22 jmw:  v. 2.3 Added comment on QuestaSim.
// 2005-11-28 jmw:  v. 2.2 Added `ifdef VCS_71 compiler
//            directives because VCS 7.2 works well.
//            Must define VCS_71 to use versions older
//            than 7.2.
// 2005-04-26 jmw:  v. 2.1 Added bitwise workaround for
//            VCS 7.1 core dump.
// 2005-04-23 jmw:  v. 2.0 Changed passed real param
//            from int to 2-bit value.   Redesigned for
//            toggle sensitivity without edge.
// 2005-01-09 jmw:  v. 1.0 implemented.
// ===================================================
`timescale 1ns/100ps
//
module ReportToggleA
       (output[1:0] Toggled, input[3:0]InBus);
//
reg[1:0] ToggledReg;
// Work-around:
`ifdef VCS_71
wire InBus0, InBus1, InBus2, InBus3;
assign InBus0 = InBus[0];
assign InBus1 = InBus[1];
assign InBus2 = InBus[2];
assign InBus3 = InBus[3];
`endif
//
// This task collects common code reused in
// each bit-monitor:
task
`ifdef SILOS
`else
     automatic 
`endif
CheckToggle(input[1:0] BitNo);
  begin
  //
  `ifdef VCS_71
  case (BitNo)
  2'b00: @(InBus0) #1 ToggledReg = BitNo;
  2'b01: @(InBus1) #1 ToggledReg = BitNo;
  2'b10: @(InBus2) #1 ToggledReg = BitNo;
  2'b11: @(InBus3) #1 ToggledReg = BitNo;
  default: $display("t=[%4d] %m illegal call:  InBus BitNo=[%04b] undefined."
                   ,    $time, BitNo
                   );
  endcase
  `else
  @(InBus[BitNo]) #1 ToggledReg = BitNo;
  `endif
  end
endtask
//
// Runtime:
//
assign Toggled = ToggledReg;
//
// Concurrent always means nonprioritized
// bit-monitoring:
always@(InBus) CheckToggle(2'b00);
always@(InBus) CheckToggle(2'b01);
always@(InBus) CheckToggle(2'b10);
always@(InBus) CheckToggle(2'b11);
//
endmodule // ReportToggleA.
//
module ReportTstA; // Testbench.
//
wire[1:0] ToggledWatch;
reg[3:0] InBusStim;
//
//
initial
  begin
  #0  InBusStim = 4'b0000;
  #10 InBusStim = 4'b0001;
  #10 InBusStim = 4'b0011;
  #10 InBusStim = 4'b0111;
  #10 InBusStim = 4'b1111;
  #10 InBusStim = 4'b0001;
  #10 InBusStim = 4'b1001;
  #10 InBusStim = 4'b0111;
  #10 InBusStim = 4'b0011;
  #10 InBusStim = 4'b1111;
  #10 InBusStim = 4'b0000;
  #10 InBusStim = 4'b1000;
  #10 InBusStim = 4'b0100;
  #10 InBusStim = 4'b0010;
  #10 InBusStim = 4'b1110;
  #10 InBusStim = 4'b1111;
  #10 $finish;
  end
//
ReportToggleA U1(.Toggled(ToggledWatch), .InBus(InBusStim));
//
endmodule // ReportTstA.
