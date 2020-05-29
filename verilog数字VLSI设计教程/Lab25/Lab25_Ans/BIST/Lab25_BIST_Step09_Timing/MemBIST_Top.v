// ===========================================================
// MemBIST_Top:  Wrapper module to combine Mem memory with
// its BIST module.
//
// ------------------------------------------------------------
// 2006-06-12 jmw: v. 1.1 Replaced AdrHi param with AWid.
//      Changed DHi refs to DWid-1.
// 2005-03-12 jmw: v. 1.0 Implemented, with BIST muxes. 
// ============================================================
//
module MemBIST_Top 
  #(parameter AWid = 5  // Default length of RAM storage.
   ,  DWid  = 32        // Default width of data word.
   )
   ( output Dready       // Data valid during a read.
   , ParityErr           // Parity error on read.
   , Testing             // Reports self-test in progress.
   , TestOK              // Reports self-test success.
   , output[DWid-1:0] DataO // For read from storage.
   , input[DWid-1:0]  DataI // For write to storage.
   , input[AWid-1:0] AddrR // Read address bus.
   ,                 AddrW // Write address bus.
   , input ClkR            // Clock data out.
   ,       ClkW            // Clock data in.
   ,       ChipEna         // Enables data I/O.
   ,       DoSelfTest // Initiates self-test.
   ,       Read       // Stored data are copied to Data[].
   ,       Write      // Data[] values replace stored values.
   ,       Reset      // To initialize parity report, mainly.
   ); 
localparam MemHi = (1<<AWid) - 1;
//
wire[DWid-1:0] DataOw, DataIw;
wire[AWid-1:0] AddrRw, AddrWw;
wire Dreadyw, ParityErrw, ClkRw, ClkWw
   , ChipEnaw, Readw, Writew, Resetw;
//
// BIST-specific:
wire[DWid-1:0] DataOBISTw, DataIBISTw;
wire[AWid-1:0] AddrBISTw;
wire ReadCmdBISTw, WriteCmdBISTw, ClockBISTw
   , TestingBISTw, TestOKBISTw, DoBISTw;
//
assign Dready    = (TestingBISTw==1'b1)? 1'b0: Dreadyw;
assign ParityErr = ParityErrw;
assign DataO     = (TestingBISTw==1'b1)?  'bz: DataOw;
//
assign DataIw   = (TestingBISTw==1'b1)? DataOBISTw: DataI;
assign AddrRw   = (TestingBISTw==1'b1)? AddrBISTw:  AddrR;
assign AddrWw   = (TestingBISTw==1'b1)? AddrBISTw:  AddrW;
assign ClkRw    = ClkR;
assign ClkWw    = (TestingBISTw==1'b1)? ClkR: ClkW;
assign ChipEnaw = ChipEna;
assign Readw    = (TestingBISTw==1'b1)?  ReadCmdBISTw:  Read;
assign Writew   = (TestingBISTw==1'b1)? WriteCmdBISTw: Write;
assign Resetw   = Reset;
//
Mem  #( .AWid(AWid), .DWid(DWid) )
 Mem_U1
   ( .Dready(Dreadyw), .ParityErr(ParityErrw), .DataO(DataOw)
   , .DataI(DataIw), .AddrR(AddrRw), .AddrW(AddrWw)
   , .ClkR(ClkRw) // Inverted read advances BIST sampling by a clock.
   , .ClkW(ClkWw), .ChipEna(ChipEnaw)
   , .Read(Readw), .Write(Writew), .Reset(Resetw)
   ); 
//
// BIST-specific:
assign DataIBISTw = (TestingBISTw==1'b1)? DataOw: 'bz;
assign ClockBISTw = ClkR;
assign Testing    = TestingBISTw;
assign TestOK     = TestOKBISTw;
assign DoBISTw    = DoSelfTest;
//
BIST  #( .AWid(AWid), .DWid(DWid) )
  BIST_U1
   ( .DataO(DataOBISTw), .Addr(AddrBISTw)
   , .ReadCmd(ReadCmdBISTw), .WriteCmd(WriteCmdBISTw)
   , .Testing(TestingBISTw), .TestOK(TestOKBISTw)
   , .DoSelfTest(DoBISTw), .ParityErr(ParityErrw)
   , .DataI(DataIBISTw), .Clk(ClockBISTw), .Reset(Resetw)
   ); 
//
endmodule // MemBIST_Top.
