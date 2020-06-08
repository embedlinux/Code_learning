// =====================================================================
// FileName : PLLsim.v
// Function : Top level of the PLL design simulation model.
//            Nominal frequency is 32 MHz, for the SerDes PLL
//            synchronized to a nominal 1 MHz parallel clock.
//
// ---------------------------------------------------------------------
// Author   : QilinZhao
// Version  : v-1.0
// Date     : 2013-09-02
// E-mail   : forqilin@163.com
// Copyright: QiXin Studio
// ======================================================================

`include "PLLsim.inc"

module PLLsim (output ClockOut, input ClockIn, Sample, Reset);
  
  wire[1:0] AdjFreq;
  wire VFOOut, ClockFromCounter;
  
  assign ClockOut = VFOOut;
  
ClockComparator 
u_ClockComparator ( .AdjustFreq     (AdjFreq         ), 
                    .ClockIn        (ClockIn         ),
                    .CounterClock   (ClockFromCounter), 
                    .Reset          (Reset           )
                  );
VFO
u_VFO ( .ClockOut    (VFOOut ), 
        .AdjustFreq  (AdjFreq),
        .SampleCmd   (Sample ), 
        .Reset       (Reset  )
        );
MultiCounter
u_MultiCounter (.CarryOut   (ClockFromCounter), 
                .Clock      (VFOOut          ),
                .Reset      (Reset           )
               );

endmodule // PLLsim

// ----------------------------------------------------------------
// Simulation Testbench here:

`ifdef DC
`else

module PLLsimTst;
  
  reg  PLLClockStim;
  reg  SampleStim;
  reg  Reset; // New 2005-01-31 jmw.
  
  PLLsim 
  u_PLLsim ( .ClockOut (PLLClockwatch),
             .ClockIn  (PLLClockStim ), 
             .Sample   (SampleStim   ), 
             .Reset    (Reset        )
           );
  
  always@(PLLClockStim) // 500 ns is half-period at 1 MHz
     #`HalfPeriod32BitBus PLLClockStim <= ~PLLClockStim;
  
  always@(posedge PLLClockStim)
  begin
    #50  SampleStim = 1'b1;
    #100 SampleStim = 1'b0;
  end
  
  initial
  begin
    #0 Reset        = 1'b0;
    #1 Reset        = 1'b1;
    #9 Reset        = 1'b0;
    #1 SampleStim   = 1'b0;
    #1 PLLClockStim = 1'b0;
    #20000 $finish;
  end
  
  initial begin
    $vcdpluson();
  end
endmodule // PLLsimTst
`endif
