// ===========================================================
// Mem1kx32gen:  1k of static RAM storage, arranged as 
//            words of 32 bits.   Separate read & write ports.
// Implemented by generate of a memory array of D flip-flops.
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
// 2006-10-06 jmw: v. 2.3 Removed Memory timescale & TB for FIFO.
// 2006-10-06 jmw: v. 2.2 Removed 3-state of DataO during write,
//            consistent with current model of Mem1kx32.
//            Also simplified parity computation.
// 2005-02-28 jmw: v. 2.1 Modified parity generator, because
//            synthesizer wanted no case equality stmt.  
//            Added `DC; Also commented out tb. 
// 2005-01-15 jmw: v. 2.0 Complete redesign for Lab14, using
//            structural DFF's and generates.   Renamed to
//            Mem1kx32gen.  DFF model is in Bit.v.
//            Silos demo version can do only 4 8-bit addrs.
// 2005-01-01 jmw: v. 1.1 Fixed use of AdrHi as exponent.
// 2004-12-17 jmw: v. 1.0 Implemented.
// ============================================================
//
module Mem1kx32gen 
    #(parameter AdrHi = 4     // Default hi bit of RAM address.
              , DatHi = 31    // Default hi bit of a word
     )                        //   (excludes 1 parity bit).
     (output Dready           // Data valid during a read.
     , ParityErr              // Parity error on read.
     , output[DatHi:0] DataO  // For read from storage.
     , input[DatHi:0]  DataI  // For write to storage.
     , input[AdrHi:0]  Addr   // Address bus.
     , input ClockIn          // Clocks data in or out.
     , ChipEna                // Enables data output drivers.
     , Read   // Stored data are copied to Bit array[Addr].
     , Write  // Bit array[Addr] values replace stored values.
     ); 
//
localparam MemHi = (1<<AdrHi+1) - 1;
//
reg  ParityErrReg; // To assign ParityErr procedurally.
wire ChipClock;    // Gated by ChipEna.
wire[DatHi:0] DataRead;  // Gated by ChipEna.
//
// Prevent any further effect of ClockIn if not ChipEna:
assign ChipClock = (ChipEna==1'b1)? ClockIn : 1'b0;
//
// Connect to output pins:
assign #2 Dready = ChipEna==1'b1 && Read==1'b1;
assign #1 ParityErr = ParityErrReg;
assign #1 DataO = (ChipEna==1'b1)? DataRead : 'bz;
//
// ------------------------------------------------
// First, set up an interface to the generated netlist:
//
wire[MemHi:0] AdrClk, AdrEna, ParityOut;
//
// Clock only the word written; enable only the word read:
generate
  genvar h;
  for (h=0; h<=MemHi; h=h+1)
    begin : Decode
    assign AdrEna[h] = (h==Addr)? 1'b1: 1'b0;
    assign AdrClk[h] = (h==Addr)? ChipClock: 1'b0;
    end
endgenerate
//
generate
  genvar i, j;
  for (i=0; i<=MemHi; i=i+1)
    begin : WordArray
    wire[DatHi+1:0] CoreIn, CoreOut, ParityQ;
    //
    for (j=0; j<=DatHi+1; j=j+1) // One address (no parity).
      begin : Word
      wire QWire;
      Bit Cell(.Q(QWire), .D(CoreIn[j]), .Clk(AdrClk[i]&&Write));
      bufif1 Buf(CoreOut[j], QWire, AdrEna[i] );
      end
    //
    // Connect all bits to input data; compute parity:
    assign WordArray[i].CoreIn = {^DataI, DataI};
    // Connect decoded output:
    assign DataRead = WordArray[i].CoreOut[DatHi:0];
    assign ParityOut[i] = ^(WordArray[i].CoreOut[DatHi:0]) && AdrEna[i] && AdrClk[i];
    end // for i WordArray.
endgenerate // i.
//
// To deal with simulation unknowns, need a case to
// match them which will be acceptable to the synthesizer:
//
always@(posedge ChipClock)
  begin : MakeParityErr
  if ((!Read || Write)==1'b1)
       ParityErrReg = 1'b0;
  else ParityErrReg = |ParityOut;
  end
//
endmodule // Mem1kx32gen.
//
