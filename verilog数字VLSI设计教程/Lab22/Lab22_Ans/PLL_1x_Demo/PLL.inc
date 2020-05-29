// Include macroes:
// The first two are tuning parameters;
// they must be integers for VFO synthesis:
`define VFO_Delta    1  // ns.
// not in synth: `define VFO_MaxDelta 1  // ns.
//
`timescale 1ns/10ps // unit=1ns for `defines; res=10ps for synth library.
//
`define ClockHalfPeriod 1.25   // ns half-period at 400 MHz.
// not in synth: `define VFOBaseDelay `ClockHalfPeriod 
//
// not in synth: `define VFO_Max (`VFOBaseDelay*1.0 + `VFO_MaxDelta*1.0)
// not in synth: `define VFO_Min (`VFOBaseDelay*1.0 - `VFO_MaxDelta*1.0)
//
// End include macroes.
