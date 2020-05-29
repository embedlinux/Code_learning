// ===================================================
// GenericDes.   A generic deserializer.
//
// ---------------------------------------------------
// 2005-11-01 jmw: v. 1.4 Minor comment change.
// 2005-04-28 jmw: v. 1.3 Shifted delays to cts assigns.
// 2005-02-24 jmw: v. 1.2 Added `DC switch.
// 2005-01-31 jmw: v. 1.1 Blocking assigns for synthesis.
// 2005-01-16 jmw: v. 1.0 implemented.
// ===================================================
`timescale 1ns/100ps
//
module GenericDes
      #( parameter ParHi = 31 )
       ( output[ParHi:0] ParBus, output ParValid
       , input SerIn, SerValid, ParClk, ParRst
       );
reg[ParHi:0] ParSR      // Input shift register.
           , ParBusReg; // Drives the parallel bus.
reg ParValidReg;
//
task Unload32; // Copies the parallel SR to the bus.
  begin
  #1 ParValidReg  = 1'b0;  // Lower Flag.
  #3 ParBusReg    = ParSR; // Transfer the data.
  #1 ParSR        = 'b0;   // Clear the SR.
  #1 ParValidReg  = 1'b1;  // Set the flag.
  end
endtask
//
// We'll do the shift explicitly in 0 sim time,
// so a function seems right:
function[ParHi:0] Shift1(input[ParHi:0] OldSR, input NewBit);
  reg[ParHi:0] temp;
  begin
  temp    = OldSR;
  temp    = temp<<1;
  temp[0] = NewBit;
  Shift1  = temp;
  end
endfunction
//
// ----------------------
// Runtime:  Assumes serial stream synchronized
// with the parallel clock:
assign #1 ParBus   = ParBusReg;
assign #1 ParValid = ParValidReg;
//
reg[5:0] N; // Holds the shift count between SerValid episodes.
//
always@(posedge ParClk, posedge ParRst)
  begin : Shifter
  if (ParRst==1'b1)
       begin
       N           =    0; // N counts bits shifted.
       ParSR       =  'b0; // The shift register.
       ParBusReg   =  'bz; // The parallel out bus.
       ParValidReg = 1'b0; // ParValid.
       end
  else if (SerValid) // Ignore the serial line if not.
         begin
         ParSR = Shift1(ParSR, SerIn);
             N = N + 1;
         if (N>ParHi) // 32 bits shifted.
           begin
           Unload32;
           N     =   0;
           ParSR = 'b0;
           end
         end // SerValid.
  end // Shifter named block.
//
endmodule // GenericDes.
//
// --------------------
`ifdef DC
`else
module GenericDesTst;
//
localparam ParHi = 31;
wire[ParHi:0] ParBusWatch;
wire ParValidWatch;
reg ClkStim, SerInStim, SerValidStim, ParRstStim;
//
reg[31:0] temp;
reg[4:0] ClkCnt;
//
always@(ClkStim) #5 ClkStim <= ~ClkStim;
//
always@(ClkStim)
  begin
  temp = $random;
  #1 SerInStim = temp[0];
  if (ParRstStim==1'b1)
       ClkCnt = 'b0;
  else if (SerValidStim==1'b1) ClkCnt = ClkCnt+ClkStim;
  end
//
initial
  begin
  #0  SerValidStim = 1'b0;
  #0  SerInStim    =  'bz;
  #0  ClkStim      = 1'b0;
  #0  ParRstStim   = 1'b0;
  #1  ParRstStim   = 1'b1;
  #9  ParRstStim   = 1'b0;
  #2  SerValidStim = 1'b1;
  //
  #100 SerValidStim = 1'b0;
  #51  SerValidStim = 1'b1;
  #900  $finish;
  end
//
GenericDes #( .ParHi(ParHi) ) U1
       ( .ParBus(ParBusWatch), .ParValid(ParValidWatch)
       , .SerIn(SerInStim), .SerValid(SerValidStim)
       , .ParClk(ClkStim), .ParRst(ParRstStim)
       );
//
endmodule // GenericDesTst.
`endif
