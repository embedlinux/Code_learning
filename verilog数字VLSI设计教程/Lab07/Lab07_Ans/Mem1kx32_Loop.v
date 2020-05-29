// ===========================================================
// Mem1kx32_Loop:  Same as Mem1kx32, but includes a for loop
//         in the initial block to exercise system tasks.
// 1k of static RAM storage, arranged as 
// words of 32 bits.   Separate read & write ports.
//
// Data are clocked out, so the verilog storage elements
// will be flip-flops.
//
// Using even parity on count of 1's.
//
// Note, if Clock is asserted while Read & Write are asserted 
// simultaneously, Read takes precedence and Write is ignored.
//
// ------------------------------------------------------------
// 2006-10-06 jmw: v. 1.4 Removed 'z' of output on write.
//            See Mem1kx32.v comment.
// 2005-04-12 jmw: v. 1.3 Uncommented tb so parity OK.
//                 Also removed conditional on parity assign.
// 2005-01-28 jmw: v. 1.2 Moved delays away from nonblocks.
// 2005-01-01 jmw: v. 1.1 Fixed use of AdrHi as exponent.
// 2004-12-17 jmw: v. 1.0 Implemented.
// ============================================================
//
`timescale 1ns/100ps
//
module Mem1kx32_Loop 
        #(parameter AdrHi = 4) // Default length of RAM storage.
        ( output Dready        // Data valid during a read.
         , ParityErr           // Parity error on read.
         , output[31:0] DataO  // For read from storage.
         , input[31:0] DataI   // For write to storage.
         , input[AdrHi:0] Addr // Address bus.
         , input ClockIn       // Clocks data in or out.
         , ChipEna             // Enables data output drivers.
         , Read       // Stored data are copied to Data[].
         , Write      // Data[] values replace stored values.
         ); 
//
localparam MemHi = (1<<AdrHi+1) - 1;
//
reg[32:0] Storage[MemHi:0]; //  RAM storage (internal);
                            // bit 32 is parity.
reg[31:0] DataOreg;  // Holds data output.
wire      ChipClock; // Gated by ChipEna.
reg       ParityReg  // To drive output pin.
        , DreadyReg; // To drive output pin.
//
// Prevent any further effect of ClockIn if not ChipEna:
assign #1 ChipClock = (ChipEna==1'b1)? ClockIn  : 1'b0;
//
// Connect to output pins:
assign ParityErr = ParityReg;
assign #3 Dready = (ChipEna==1'b1)? DreadyReg : 1'b0;
assign #2 DataO  = (ChipEna==1'b1)? DataOreg : 'bz;
//
always@(posedge ChipClock) // Do nothing unless clocked.
  begin
  if (ChipEna==1'b1)
    begin
    if (Read==1'b1) // Don't assign Storage on read.
         begin
         // First, parity check:
         ParityReg <= ^(Storage[Addr]);
         // Then, read out data, even if bad:
         DataOreg  <= Storage[Addr]; // Lower 32 bits will go.
         DreadyReg <= 1'b1;    // Flag valid data.
         end
    else if (Write==1'b1)  // Don't assign ChipData on write.
         begin
         DreadyReg <= 1'b0; // Flag invalid data.
         //
         // Use concatenation to compute & store parity:
         Storage[Addr] <= {^DataI[31:0], DataI[31:0]};
         end
    else // Neither read nor write asserted:
         DreadyReg <= 1'b0; // Flag possibly invalid read.
    end
  end // always @ clock.
endmodule // Mem1kx32_Loop.
//
// ------------------------------------------------------------
// Testbench:
//
`ifdef DC
`else
module Mem1kx32_LoopTst; // no I/O for testbench
//
parameter AdrHiParam = 4;
//
wire DreadyWatch, ParityErrWatch;
wire[31:0] DataOWatch;
 reg[31:0] DataStim;
reg [AdrHiParam:0] AddrStim;
reg ClockInStim
  , ChipEnaStim
  , ReadStim
  , WriteStim;
//
// Design instance:
//
Mem1kx32_Loop // No parameter passed, so default used.
MemLoopInst1
        (  .Dready(DreadyWatch)
         , .ParityErr(ParityErrWatch)
         , .DataO(DataOWatch)
         , .DataI(DataStim)
         , .Addr(AddrStim)
         , .ClockIn(ClockInStim)
         , .ChipEna(ChipEnaStim)
         , .Read(ReadStim)
         , .Write(WriteStim)
         );
//
always@(ClockInStim) #10 ClockInStim <= ~ClockInStim;
//
integer j;
reg[32:0] tempReg;  // To $display parity bit.
//
initial
  begin // Blocking assignments used for testbench:
  #0   ClockInStim = 1'b0;
  #0   ChipEnaStim = 1'b1;
  #0   ReadStim    = 1'b0;
  #0   WriteStim   = 1'b0;
  for ( j = 0; j<=AdrHiParam; j = j + 1)
    begin
    #1  DataStim  = j * 3;
    #1  AddrStim  = j;
    #1  WriteStim = 1'b1;
    #17 WriteStim = 1'b0; // Clock has ticked.
    // Do the display:
    tempReg = MemLoopInst1.Storage[j];
    $display("display t=[%03d]: Adr=[%02d] Data=[%.8b] p=[%1b]"
                , $time, AddrStim, tempReg[31:0], tempReg[32] );
    end
  #0   AddrStim    = 5'b00000;
  #5   DataStim    = 32'h1111_ffff;
  #1   WriteStim   = 1'b1;
  #30  WriteStim   = 1'b0;
  #1   DataStim    = 'bz;
  #1   ReadStim    = 1'b1;
  #39  ReadStim    = 1'b0;
  #15  ChipEnaStim = 1'b0;
  #55  ChipEnaStim = 1'b1;
  #0   DataStim    = 'bz;
  #1   ReadStim    = 1'b1;
  #39  ReadStim    = 1'b0;
  #0   AddrStim    = 5'b00001;
  #5   DataStim    = 32'h11ff_eeee;
  #1   WriteStim   = 1'b1;
  #30  WriteStim   = 1'b0;
  #1   ReadStim    = 1'b1;
  #0   DataStim    = 'bz;
  #39  ReadStim    = 1'b0;
  #5   AddrStim    = 5'b00000;
  #5   ReadStim    = 1'b1;
  #80 $finish;
  end

endmodule  // Mem1kx32_LoopTst.
`endif

