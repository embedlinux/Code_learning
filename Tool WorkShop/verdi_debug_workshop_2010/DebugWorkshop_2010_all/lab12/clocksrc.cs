@verdi rc file Version 1.0
[CKDomain]
clkSrcOnly = True
reglist = False
separateRegToMultiClkDmn = False
traceMultiResolveSource = True
mergeCell = GATECLK CombLogic
[ClkTreeOption]
FF = "Clock pin"
Latch = "Control pin"
Macro = "Clock pin"
PrimaryOutputPort = stop
FloatingGate = ignore
noSchema = TRUE
[ClockGroup]
Item_0 = "R_W" "system.R_W"
Item_1 = "R_W" "system.reset"
Item_2 = "CLKA" "system.VMA"
Item_3 = "clock" "system.clock"
[ClockRoot]
Item_1 = system.R_W
Item_2 = system.reset
Item_3 = system.VMA
Item_4 = system.clock
[ConstantSignal]
system.reset = Binary 0
system.i_cpu.i_ALUB.n737 = Binary 1
[File]
ClockDBFile = output.cdb
[GeneratedClock]
Item_0 = "system.VMA" "system.VMA" "system.i_cpu.i_CCU.C6_reg.Q"
