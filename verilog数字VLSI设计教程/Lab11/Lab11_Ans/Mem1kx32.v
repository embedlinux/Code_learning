// ===========================================================
// Mem1kx32:  1k of static RAM storage, arranged as 
//            words of 32 bits.   Separate read & write ports.
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
// 2006-10-06 jmw: v. 1.5 Removed Lab 7 timescale & TB.
// 2006-10-06 jmw: v. 1.4 Removed output 'z' on write; this
//            means that old read output will persist and
//      fulfills the Lab instructions correctly.   With
//      'z' driving, the bidir model would work with no
//      additional three-stating in the wrapper!
// 2005-08-29 jmw: v. 1.3 Added %m to parity assertion.
// 2005-01-28 jmw: v. 1.2 Moved delays away from nonblocking
//            assignments, for synthesis compatibility.
// 2005-01-01 jmw: v. 1.1 Fixed use of AdrHi as exponent.
// 2004-12-17 jmw: v. 1.0 Implemented.
// ============================================================
//
module Mem1kx32 
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
assign #3 Dready    = (ChipEna==1'b1)? DreadyReg : 1'b0;
assign #2 DataO     = (ChipEna==1'b1)? DataOreg : 'bz;
//
always@(posedge ChipClock) // Do nothing unless clocked.
  begin
  if (ChipEna==1'b1)
    begin
    if (Read==1'b1) // Don't assign Storage on read.
         begin
         // First, parity check:
         ParityReg <= (^(Storage[Addr])==1'b0)? 1'b0 : 1'b1;
         // Then, read out data, even if bad:
         DataOreg  <= Storage[Addr]; // Lower 32 bits will go.
         DreadyReg <= 1'b1;    // Flag valid data.
         `ifdef DC
         `else
         if (ParityReg==1'b1) 
            $display(" *** *** Parity Error. time=%4d: %m", $time);
         `endif
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
endmodule // Mem1kx32.
//
