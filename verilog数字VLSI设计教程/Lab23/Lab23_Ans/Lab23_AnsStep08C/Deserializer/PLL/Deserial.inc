// Include macroes (moved here for DC compatibility):
`timescale 1ns/1ps // High res, for simulation.
//
`define HalfPeriod32BitBus 500.0   // ns half-period at 1 MHz.
`define VFOBaseDelay `HalfPeriod32BitBus/32.0 // At 32 MHz.
`define VFO_DelayDelta  1.0  // ns.
`define VFO_MaxDelta    2.0  // ns.
