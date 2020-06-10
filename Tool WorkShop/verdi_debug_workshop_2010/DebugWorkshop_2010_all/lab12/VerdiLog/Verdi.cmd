srcSourceCodeView
srcResizeWindow 163 117 804 500
debImport "-f" "run.f"
schEditClkSrc -add "system.clock"
schEditClkSrc -add "system.R_W"
schEditClkSrc -add "system.reset" -sdcName "R_W"
schEditClkSrc -add "system.VMA" -sdcName "CLKA"
schEditClkSrc -clkSrc "system.VMA" -currentClk "system.VMA" -add \
           "system.i_cpu.i_CCU.C6_reg.Q" -sdcName "i_cpu/i_CCU/C6_reg/Q"
schExtractClockDomain -sdcFile \
           "/sales/home/jb_chen/DebugWorkshop/lab8/sdc_system.sdc" -design \
           "system" -delim "/"
schExtractClockDomain -clkSrcOnly on -mergeCell GATECLK CombLogic -latchEnAsClk \
           on -reglist off -separateRegToMultiClkDmn off \
           -traceMultiResolveSource on -constant "system.reset" Binary 0 \
           -cksour "system.R_W" "system.reset" "system.VMA" \
           "system.i_cpu.i_CCU.C6_reg.Q" "system.clock"
srcDeselectAll -win $_nTrace1
schShowClockDomain -domainNo 2.f -showOn schema
schSelect -win $_nSchema3 -instpin "system.i_cpu.i_ALUB.U250" "A"
schTraceDriver -win $_nSchema3
schSelect -win $_nSchema3 -instpin "system.i_cpu.i_ALUB.U250" "B"
schTraceDriver -win $_nSchema3
schSelect -win $_nSchema3 -signal "system.i_cpu.i_ALUB.n737"
schClkTreeEditMode -win $_nSchema3 -update default -name "system.reset" -value 0 \
           -radix Binary -signal
schClkTreeEditMode -win $_nSchema3 -update default -name \
           "system.i_cpu.i_ALUB.n737" -radix Decimal -signal
schClkTreeEditMode -win $_nSchema3 -update default -name \
           "system.i_cpu.i_ALUB.n737" -value 1 -radix Decimal -signal
schClkTreeEditMode -win $_nSchema3 -update default -name \
           "system.i_cpu.i_ALUB.n737" -value 1 -radix Binary -signal
schExtractClockDomain -clkSrcOnly on -mergeCell GATECLK CombLogic -latchEnAsClk \
           on -reglist off -separateRegToMultiClkDmn off \
           -traceMultiResolveSource on -constant "system.reset" Binary 0 \
           -constant "system.i_cpu.i_ALUB.n737" Binary 1 -cksour "system.R_W" \
           "system.reset" "system.VMA" "system.i_cpu.i_CCU.C6_reg.Q" \
           "system.clock"
schClkExtractCDCloseWindow -win $_ExtractClockDomains2
schCloseWindow -win $_nSchema3
debExit
