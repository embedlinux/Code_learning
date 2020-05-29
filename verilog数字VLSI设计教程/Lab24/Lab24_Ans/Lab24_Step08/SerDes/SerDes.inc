// Include macroes (moved here for DC compatibility):
//
`timescale 1ns/1ps // Timescale 1ns required by `defines below.
//
`define HalfPeriod32BitBus 500.0   // ns half-period at 1 MHz.
`define VFOBaseDelay `HalfPeriod32BitBus/32.0 // At 32 MHz.
`define VFO_DelayDelta 1.0  // ns.
//
`ifdef DC
`define VFO_MaxDelta  5.0  // 2x ns?
`else
`define VFO_MaxDelta  2.0  // ns.
`endif 
