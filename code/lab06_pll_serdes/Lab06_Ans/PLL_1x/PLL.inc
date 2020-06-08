// Include macroes:
// The first two are tuning parameters:
`define VFO_Delta    0.001  // ns.
`define VFO_MaxDelta 0.250  // ns.


`define ClockHalfPeriod 1.25   // ns half-period at 400 MHz.
`define VFOBaseDelay `ClockHalfPeriod 

`define VFO_Max (`VFOBaseDelay*1.0 + `VFO_MaxDelta*1.0) // 1.5
`define VFO_Min (`VFOBaseDelay*1.0 - `VFO_MaxDelta*1.0) // 1.0

// End include macroes.
