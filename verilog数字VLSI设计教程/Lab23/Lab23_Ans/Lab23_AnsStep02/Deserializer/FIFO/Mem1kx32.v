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
// 2007-11-06 jmw: v. 1.1 Removed all delays for Lab23 Step 2.
// 2005-05-19 jmw: v. 1.0 Copied from Lab11_Ans.  Renamed AdrHi
//      param to AWid; added DWid param; removed timescale;
//      deleted tb.   Added Reset port and logic to clear RAM
//      on Reset; also, Reset initializes all outputs.
// ============================================================
//
module Mem1kx32 
        #(parameter AWid = 5  // Default length of RAM storage.
        ,           DWid = 32 // Default addressable word width.
        )
        ( output Dready        // Data valid during a read.
         , ParityErr           // Parity error on read.
         , output[DWid-1:0] DataO // For read from storage.
         , input[DWid-1:0]  DataI // For write to storage.
         , input[AWid-1:0]  Addr  // Address bus.
         , input ClockIn  // Clocks data in or out.
         , ChipEna // Enables data output drivers.
         , Read    // Stored data are copied to Data[].
         , Write   // Data[] values replace stored values.
         , Reset   // Clears memory to allow parity checks.
         ); 
//
localparam MemHi = (1<<AWid) - 1;
//
reg[DWid:0] Storage[MemHi:0]; //  RAM storage (internal);
                              //        bit 32 is parity.
reg[DWid-1:0] DataOreg;  // Holds data output.
wire      ChipClock; // Gated by ChipEna.
reg       ParityReg  // To drive output pin.
        , DreadyReg; // To drive output pin.
//
integer i;
//
// Prevent any further effect of ClockIn if not ChipEna:
assign ChipClock = (ChipEna==1'b1)? ClockIn  : 1'b0;
//
// Connect to output pins:
assign ParityErr = ParityReg;
assign Dready    = (ChipEna==1'b1)? DreadyReg : 1'b0;
assign DataO     = (ChipEna==1'b1)? DataOreg : 'bz;
//
always@(posedge ChipClock, posedge Reset)
  begin
  if (Reset==1'b1)
         begin
         ParityReg <= 1'b0;
         DreadyReg <= 1'b0;
         DataOreg  <= 'b0;
         for (i=0; i<=MemHi; i=i+1) Storage[i] <= 'b0;
         end
    else // No Reset asserted:
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
              $display(" *** *** Parity Error. time=%4d", $time);
           `endif
           end
      else if (Write==1'b1)  // Don't assign ChipData on write.
           begin
           DreadyReg <= 1'b0; // Flag invalid data.
           //
           // Use concatenation to compute & store parity:
           Storage[Addr] <= {^DataI[DWid-1:0], DataI[DWid-1:0]};
           DataOreg      <= 'bz; // Don't drive outputs.
           end
      else // Neither read nor write asserted:
           DreadyReg <= 1'b0; // Flag possibly invalid read.
      end // ChipEna == 1.
  end // always @ clock.
endmodule // Mem1kx32.
//
