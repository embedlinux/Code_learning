// ===================================================
// Decoder1024.v.   Shows use of a looping generate 
// statement to implement a decoder tree composed of
// 4-16 decoder components.
//
// The Dec4_16 submodule is kept together
// in this one file, for illustration.
//
// This model is not fully parameterized; so, it can't
// be resized in its present form without detailed 
// attention.
//
// ---------------------------------------------------
// 2005-12-20 jmw:  v. 1.4  Removed all SILOS
//            compatibility directive code, and replaced
//            always final decode with cts assign, which
//            worked for Silos.
// 2005-09-09 jmw:  v. 1.3  Added Log2AdrEna to VCS ports.
// 2005-04-26 jmw:  v. 1.2  Changed Find1 assigns to
//            blocking, for synthesizer.  Changed
//            integer i to reg, but DC iteration limit
//            exceeded.
// 2005-02-24 jmw:  v. 1.1  Changed some inst names;
//            Got the design to simulate in Silos with
//            assign instead of always (if Silos
//            extensions turned on and SILOS defined).
//            Added `DC switch.
// 2005-01-15 jmw:  v. 1.0 implemented.
// ===================================================
`timescale 1ns/100ps
//
module Decoder1024
       #(parameter
          AdrHi   = 9 // default = 10-bit address bus.
        , NumAddr = (1<<AdrHi+1) - 1   // Not Silos.
        )
        (
          output[NumAddr:0] AdrEna     // VCS only.
        ,  input[AdrHi:0]   Address
        );
// ------------------------------------------------------
// Set up I/O's & sizes:
//
// 4-16 Decoder assumptions:
localparam DecodiHi = 3; // High bit of input bus.
localparam DecodiWid = DecodiHi+1;
localparam DecodHi = (1<<DecodiWid)-1;
localparam DecodWid = DecodHi + 1;
//
// ------------------------------------------------------
// Begin decoding:
//
// If AddrHi = 9, then NumAddr = 1024:
// 1024/16 = 2**6  = 64 level 3 decoders.
// 64/16   = 2**4  =  4 level 2 decoders.
//     4 addresses =  1 level 1 decoder.
// ------------------------------------------------------
// Start with Level 1, which underutilizes a 4-to-16:
//
wire[DecodiHi:0] DecodedL1;
wire[1:0] inL1;
wire[DecodHi:4] unusedo; // Suppress warnings.
//
// Get Address LSB's:
assign inL1 = Address[1:0];
// The level 1 decode:
//
Dec4_16 U1({unusedo,DecodedL1}, {2'b0, inL1});
//
// ------------------------------------------------------
// Now Level 2, which requires 4 x 4-16's:
//
wire[DecodWid*4-1:0] DecodedL2;
wire[DecodiHi:0]  inL2;
assign inL2 = Address[5:2];
//
generate
  genvar i;
  // Generate the 4 4-16's:
  for(i=0; i<=DecodiHi; i=i+1)
    begin : DL2
    wire[DecodHi:0] tempL2;
    Dec4_16 U2(tempL2, inL2); // Each gets bits 2 - 5.
    //
    // Compose the decoded address from L1 and L2, and assign the bit:
    assign DecodedL2[(DecodWid*(i+1)-1):DecodWid*i] = 
                (DecodedL1[i]==1'b1)? DL2[i].tempL2: 1'b0;
    //
    end
endgenerate
//
// ------------------------------------------------------
// Now Level 3, which requires 64 x 4-16's:
//
wire[DecodiHi:0]  inL3;
assign inL3 = Address[9:6];
//
generate
  genvar j;
  // Generate the 64 4-16's:
  for(j=0; j<=4*DecodWid-1; j=j+1)
    begin : DL3
    wire[DecodHi:0] tempL3;
    Dec4_16 U3(tempL3, inL3); // Each gets bits 6 - 9.
    //
    // Compose the decoded address from L2 and L3, and assign the bit:
    assign  AdrEna[(DecodWid*(j+1)-1):DecodWid*j] =
                            (DecodedL2[j]==1'b1)? DL3[j].tempL3: 1'b0;
    end
//
endgenerate
//
endmodule // Decoder1024.
//
// --------------
module Dec4_16 #(parameter DecodiHi = 3 // 3 for 4-16 decoder.
                , DecodHi = (1<<DecodiHi+1)-1
                )
                (output[DecodHi:0] Hot
                , input[DecodiHi:0] Sel);
//
reg[DecodHi:0] HotReg;
assign #1 Hot = HotReg;
//
always@(Sel)
  begin
  HotReg      <=  'b0;
  HotReg[Sel] <= 1'b1;
  end
//
endmodule // Dec4_16.
//
`ifdef DC
`else
// -------------------------------------------
module Decoder1024Tst;
// -------------------------------------------
//
localparam AdrHi = 9;
localparam NumAddr = (1<<AdrHi+1) - 1;
//
 reg[AdrHi:0] AddrStim;
wire[NumAddr:0] AdrEnaWatch;
reg ClkStim;
//
always@(ClkStim) #10 ClkStim <= ~ClkStim;
always@(posedge ClkStim)
       begin
       #4 AddrStim = (AddrStim + 1) %NumAddr;
       #4 AddrStim = (AddrStim + 9) %NumAddr;
       #4 AddrStim = (AddrStim + 89)%NumAddr;
       #4 AddrStim = (AddrStim + 1) %NumAddr;
       end
//
initial
  begin
  #0    ClkStim  = 1'b0;
  #0    AddrStim =  'b0;
  #1000 $finish;
  end
//
Decoder1024 #( .AdrHi(AdrHi) ) UTop
   (
     .AdrEna(AdrEnaWatch)
   , .Address(AddrStim)
   );
//
endmodule // Decoder1024Tst.
`endif
