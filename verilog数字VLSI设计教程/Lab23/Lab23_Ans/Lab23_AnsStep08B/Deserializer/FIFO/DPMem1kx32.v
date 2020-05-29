// ===========================================================
// DPMem1kx32:  1k of static RAM storage, arranged as 
//            words of 32 bits.   Separate read & write ports.
//
// Data are clocked out, so the verilog storage elements
// will be flip-flops.
//
// Using even parity on count of 1's.
//
// ------------------------------------------------------------
// 2006-10-13 jmw: v. 1.3 Rewrote some comments.
// 2005-05-26 jmw: v. 1.2 Simplified read parity expression.
// 2005-05-24 jmw: v. 1.1 Removed all delay expressions.
//      Renamed from Mem1kx32 to DPMem1kx32.
//      Separated read & write addresses, clocks and logic.
//      Renamed all old *Reg to *r.
// 2005-05-19 jmw: v. 1.0 Copied from Lab11_Ans.  Renamed AdrHi
//      param to AWid; added DWid param; removed timescale;
//      deleted tb.   Added Reset port and logic to clear RAM
//      on Reset; also, Reset initializes all outputs.
// ============================================================
//
module DPMem1kx32 
   #(parameter AWid = 5  // Default length of RAM storage.
   ,           DWid = 32 // Default addressable word width.
   )
   ( output Dready          // Data valid during a read.
   , ParityErr              // Parity error on read.
   , output[DWid-1:0] DataO // For read from storage.
   , input[DWid-1:0]  DataI // For write to storage.
   , input[AWid-1:0]  AddrR // Read address.
   , input[AWid-1:0]  AddrW // Write address.
   , input ClkR             // Clocks data out.
   , input ClkW             // Clocks data in.
   , ChipEna       // Enables data output drivers.
   , Read          // Stored data are copied to Data[].
   , Write         // Data[] values replace stored values.
   , Reset         // Clears memory to allow parity checks.
   ); 
//
localparam MemHi = (1<<AWid) - 1;
//
reg[DWid:0] Storage[MemHi:0]; //  RAM storage (internal);
                              //        bit 32 is parity.
reg[DWid-1:0] DataOr;   // Holds data output.
wire      ClockR, ClockW; // Gated by ChipEna.
reg Parityr  // To drive output pin.
  , Dreadyr; // To drive output pin.
//
integer i;
//
// Prevent any clocking if not ChipEna:
assign ClockR = (ChipEna==1'b1)? ClkR : 1'b0;
assign ClockW = (ChipEna==1'b1)? ClkW : 1'b0;
//
// Connect to output pins:
assign ParityErr = Parityr;
assign Dready    = (ChipEna==1'b1)? Dreadyr : 1'b0;
assign DataO     = (ChipEna==1'b1)? DataOr : 'bz;
//
//`define DEBUG
//
always@(posedge ClockR, posedge Reset)
  begin : Reader
  if (Reset==1'b1)
       begin
       Parityr <= 1'b0;
       Dreadyr <= 1'b0;
       DataOr  <= 'b0;
       end
  else if (Read==1'b1)
         begin
         // First, parity check:
         Parityr <= ^(Storage[AddrR]);
         // Then, read out data, even if bad:
         `ifdef DEBUG
         $display("%05d: Read Storage[%02h]=[%08h]."
                , $time,             AddrR, Storage[AddrR]);
         `endif
         DataOr  <= Storage[AddrR]; // Lower 32 bits will go.
         Dreadyr <= 1'b1;    // Flag valid data.
         `ifdef DC
         `else
         if (Parityr==1'b1) 
            $display(" *** *** Parity Error. time=%4d", $time);
         `endif
         end
  end // Reader.
//
always@(posedge ClockW, posedge Reset)
  begin : Writer
  if (Reset==1'b1)
    for (i=0; i<=MemHi; i=i+1) Storage[i] <= 'b0;
  else
  if (Write==1'b1)
    begin
    `ifdef DEBUG
    $display("%05d: Write Storage[%02h]=[%08h]."
           , $time,             AddrW, Storage[AddrW]);
    `endif
    Storage[AddrW] <= {^DataI[DWid-1:0], DataI[DWid-1:0]};
    end
  end // Writer.
endmodule // DPMem1kx32.
//
