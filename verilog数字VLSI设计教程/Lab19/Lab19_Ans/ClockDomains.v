// =======================================================
// ClockDomains.  A testbench to show the use
// of a synchronizer across clock domains.
//
// The Counter3 module is defined below for
// expository purposes; it usually would be put
// in its own file.
//
// The logic in the fast clock domain is assumed
// to be receiving data from the slow clock domain.
// An and of three counter bits is to be compared
// across both domains; when both and's are
// asserted, the fast-domain logic has to do
// something (undefined in this example).
//
// So, the fast domain must eliminate glitches,
// insofar as possible, and not mistake a '0' for
// a '1' coming in from the slow domain.
//
// To see the difference because of latching,
// a raw, unsynchronized and is captured in the
// testbench as well as its latched counterpart.
//
// Note that the "latches" are flip-flops, specifically.
//
// The latching rejects some data; these should be
// interpreted as ambiguous data, although the
// evolution of good data from ambiguous states
// to known ones (in the fast domain) really can't
// be simulated very well in a digital context.
//
// -------------------------------------------------------
// 2005-10-13 jmw:  v. 1.1 Fixed "latches" to posedge.
// 2005-02-05 jmw:  v. 1.0 completed.
// =======================================================
//
`timescale 1ns/1ps  // 1 ps resolution required.
//
module ClockDomains; // A testbench; so, no I/O.
//
// Set clock periods/2 here:
//         F = Fast        S = Slow:
localparam FDelay = 1.301, SDelay = 2.011;
//
// Inertial rejection of unsynched sampler
// in combinational logic:
localparam CombDelay = 0.200;
localparam FastCombDelay = CombDelay/5.0;
//
// Uncertainty in latching in receiving domain:
localparam LatchLagDelay = CombDelay/1.5;
//
//
wire FastClock, SlowClock, Reset
   , FastAnd, SlowAnd
   , UnsyncAnd // The raw, unsynchronized logic.
   , SyncAnd;  // Synchronized logic.
//
wire[2:0] FastCount, SlowCount;
//
// The two counter instances:
//
Counter3 
FastLogic
( .Count(FastCount), .Clk(FastClock), .Clr(Reset) );
//
Counter3
SlowLogic
( .Count(SlowCount), .Clk(SlowClock), .Clr(Reset) );
//
// Clock domain counter output logic:
//
assign #CombDelay FastAnd = &FastCount;
assign #CombDelay SlowAnd = &SlowCount;
//
// The sampling logic:
//
reg HoldFastAnd, HoldSlowAnd;
assign #FastCombDelay UnsyncAnd =     FastAnd &     SlowAnd;
assign #FastCombDelay SyncAnd   = HoldFastAnd & HoldSlowAnd;
//
// The synchronizing latches (RTL):
always@(posedge FastClock)
  if (FastClock==1'b1)
    #LatchLagDelay HoldFastAnd = FastAnd;
always@(posedge FastClock)
  if (FastClock==1'b1)
    #LatchLagDelay HoldSlowAnd = SlowAnd;
//
// ----------------------------------------
// The rest is testbench:
//
reg FastStim, SlowStim, ResetStim;
assign Reset     = ResetStim;
assign FastClock = FastStim;
assign SlowClock = SlowStim;
//
always@(FastStim) #FDelay FastStim <= ~FastStim;
always@(SlowStim) #SDelay SlowStim <= ~SlowStim;
//
initial
  begin
  #0    FastStim   = 1'b0;
        SlowStim   = 1'b0;
  #1    ResetStim  = 1'b1;
  #9    ResetStim  = 1'b0;
  #500  $finish;
  end
//
endmodule // ClockDomains.
//
// The counter module is here for convenience;
// it might as well be in its own file.
// Delay is assigned in instantiation.
//
module Counter3
      (output[2:0] Count, input Clk, Clr);
reg[2:0] CountReg;
//
assign Count = CountReg;
//
always@(Clk)
  if (Clr==1'b1) CountReg <= 'b0;
  else CountReg <= CountReg + 1;
//
endmodule // Counter3.

