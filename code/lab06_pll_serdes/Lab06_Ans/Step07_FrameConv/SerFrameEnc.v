// ========================================================================
// FileName : SerFrameEnc.v
// Function : Serial frame encoder.   This module accepts a parallel bus 
//            (register) as input and reformats it into a different register 
//            ready for serialization.
//
//            The input is an arbitrary 32-bit bus the value of which must be 
//            constant during the framing process.   The output is a 64-bit 
//            bus or register with the individual bytes in the input bus 
//            punctuated into frames by 8-bit  pad bytes:
//
//            Input: [bit31] ... [bit0], as 4 contiguous bytes, each 8 bits wide:  
//            [byte3][byte2][byte1][byte0] = 32 bits.
//
//            Output:
//            [byte3][pad3][byte2][pad2][byte1][pad1][byte0][pad0] = 64 bits.
//
//            We define: Pad3 = 8'b00011000, Pad2 = 8'b00010000,
//                       Pad1 = 8'b00001000, Pad0 = 8'b00000000.
//
//            So, in each pad byte, the ordinal number of that pad is encoded, 
//            itself padded on both sides by three 0's.
//
//            By framing all at once, on one clock edge, with essentially a 
//            bit-swizzle, we avoid the need for an input-valid flag.
//
// -------------------------------------------------------------------------------
// Author   : QilinZhao
// Version  : v-1.0
// Date     : 2013-09-02
// E-mail   : forqilin@163.com
// Copyright: QiXin Studio
// ===============================================================================

module SerFrameEnc 
  #( parameter InHi=31, OutHi=63, DatHi=7, PadHi=7,
     Pad3=8'b000_11_000, Pad2=8'b000_10_000,
     Pad1=8'b000_01_000, Pad0=8'b000_00_000
    )
    ( output[OutHi:0] FrameOut,
      input[InHi:0] BusIn, input DoFrame
    );
  reg[OutHi:0] FrameReg;
  
  assign #2 FrameOut = FrameReg;
  
  localparam DatWid = DatHi + 1;
  localparam PadWid = PadHi + 1;
  
  always@(posedge DoFrame)
  begin
    FrameReg[OutHi:OutHi-DatHi] <= BusIn[InHi:InHi-DatHi];
    FrameReg[OutHi-DatWid:OutHi-DatWid-DatHi]     <= Pad3;
    FrameReg[OutHi-2*DatWid:OutHi-2*DatWid-DatHi]
                  <= BusIn[InHi-DatWid:InHi-DatWid-DatHi];
    FrameReg[OutHi-3*DatWid:OutHi-3*DatWid-DatHi] <= Pad2;
    FrameReg[OutHi-4*DatWid:OutHi-4*DatWid-DatHi]
              <= BusIn[InHi-2*DatWid:InHi-2*DatWid-DatHi];
    FrameReg[OutHi-5*DatWid:OutHi-5*DatWid-DatHi] <= Pad1;
    FrameReg[OutHi-6*DatWid:OutHi-6*DatWid-DatHi]
              <= BusIn[InHi-3*DatWid:InHi-3*DatWid-DatHi];
    FrameReg[OutHi-7*DatWid:OutHi-7*DatWid-DatHi] <= Pad0;
  end
  
endmodule // SerFrameEnc

// ----------------------------------------------------------------
// Simulation Testbench here:

`ifdef DC
`else
module SerFrameEncTst;
  
  reg[31:0] BusInReg;
  reg       DoFrameReg;
  wire[63:0] FrameOutwatch;
  wire[31:0] BusInstim;
  wire      DoFramestim;
  
  assign BusInstim   = BusInReg;
  assign DoFramestim = DoFrameReg;
  
  SerFrameEnc u_SerFrameEnc ( .FrameOut  (FrameOutwatch),
                              .BusIn     (BusInstim    ), 
                              .DoFrame   (DoFramestim  )
                            );
  
  always@(DoFrameReg)
  begin
    #45 DoFrameReg <= 1'b1;
    @(DoFrameReg)
      #05 DoFrameReg <= 1'b0;
  end
  
  initial
  begin
    #0   DoFrameReg = 1'b0;
    #40  BusInReg   = 32'hzzzzzzzz;
    #50  BusInReg   = 32'h00001111;
    #50  BusInReg   = 32'h11111111;
    #50  BusInReg   = 32'hffff0000;
    #50  BusInReg   = 32'h1f1f1f1f;
    #50  BusInReg   = 32'hf1f1f1f1;
    #50  BusInReg   = 32'hf0f0f0f0;
    #50  BusInReg   = 32'h0f0f0f0f;
    #50  BusInReg   = 32'hffffffff;
    #50  BusInReg   = 32'h00000000;
    #50  BusInReg   = 32'haaaaaaaa;
    #50  BusInReg   = 32'h55555555;
    #100 $finish;
  end
  
  initial begin
    $vcdpluson();
  end
endmodule // SerFrameEncTst
`endif
