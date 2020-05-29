// ===================================================
// ForRptWhile.   Combined module, with a forever
// testbench clock, and a repeat and a while block.
//
// 2005-01-09 jmw:  v. 1.0 implemented.
// ===================================================
`timescale 1ns/100ps
//
module ForRptWhile
      #(parameter Pattern = 32'h0000_7777) // To be while'd.
       ( output[31:0] OutBus, output PatFlag
       , input[31:0] InBus, input Clk
       );
//
reg[31:0] OutBusReg;
reg       PatFlagReg;
//
assign #2 OutBus  = OutBusReg; // Must delay here; loop too much!
assign PatFlag = PatFlagReg;
//
// The code below may imply some sequential logic, but
// updating of variables in the loops requires blocking
// assignments; so, ALL assignments in a block are
// blocking:
//
always@(posedge Clk)
  begin : Repeater  // Verilog allows declared data
  reg[5:0] j;       // locally, if in named blocks.
  //
  OutBusReg = 'b0; // This will make clocking visible.
  #2 j = 'b0;  // Allow time for 'b0 to stay on bus.
  repeat(16)
    begin
    OutBusReg[j] = 1'b1; // Any delay here is x 16!
    j = j + 1;
    OutBusReg[j] = 1'b0;
    j = j + 1;
    end
  end // Repeater.
//
always@(posedge Clk)
  begin : Whiler
  reg[5:0] k;
  reg Match; // Loop flag.
  #2 PatFlagReg = 1'b0;
  k     =  'b0;
  Match = 1'b0;
  while(k<=31)
    begin
    if (Pattern[k]==InBus[k])
         Match = 1'b1;
    else begin
         Match = 1'b0;
         k = 32; // Force exit.
         end
    k = k + 1;
    end
  // By this point, Match==1 means all 32 bits
  // must have been matched:
  //
  if (Match==1'b1)
    #2 PatFlagReg = 1'b1; // Delay OK here; better in cts assign.
  //
  end // always Clk.
//
endmodule // ForRptWhile.
//
module ForRptWhileTst;
//
reg[31:0]  InBusStim;
reg        ClkStim;
wire[31:0] OutBusWatch;
wire       PatFlagWatch;
//
initial
  begin
  #0 ClkStim = 1'b0;
  forever #5 ClkStim <= ~ClkStim;
  end
//
initial
  begin
  #0   InBusStim = 32'h0000_0000;
  #10  InBusStim = 32'h3456_789a;
  #10  InBusStim = 32'hbcde_f555;
  #10  InBusStim = 32'h1111_7777;
  #10  InBusStim = 32'h3333_eeee;
  #10  InBusStim = 32'h1234_5555;
  #10  InBusStim = 32'h2456_8888;
  #10  InBusStim = 32'h2222_ffff;
  #10  InBusStim = 32'h0000_7777;
  #10  InBusStim = 32'hffff_ffff;
  #10  InBusStim = 32'h0000_ffff;
  #10  $finish;
  end
//
ForRptWhile U1 (.OutBus(OutBusWatch), .PatFlag(PatFlagWatch)
               , .InBus(InBusStim), .Clk(ClkStim)
               );

//
endmodule // ForRptWhileTst.
