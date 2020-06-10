srcSourceCodeView
srcResizeWindow 178 92 804 500
debImport "-f" "run.f"
debLoadSimResult ./gate.fsdb
wvCreateWindow
wvResizeWindow -win $_nWave2 51 298 960 407
wvOpenFile -win $_nWave2 {./gate.fsdb}
srcSelect -inst "carry_flag_reg" -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvAddSignal -win $_nWave2 "/system/i_cpu/i_ALUB/carry" "/system/i_cpu/i_ALUB/T2" \
           "/system/i_cpu/i_ALUB/n137" "/system/i_cpu/i_ALUB/carry_flag"
wvCreateWindow
wvResizeWindow -win $_nWave3 55 320 960 407
wvOpenFile -win $_nWave3 {../rtl/rtl.fsdb}
wvSetPosition -win $_nWave3 {("G1" 0)}
wvAddSignal -win $_nWave3 "/system/i_cpu/i_ALUB/carry" "/system/i_cpu/i_ALUB/T2" \
           "/system/i_cpu/i_ALUB/carry_flag"
wvResizeWindow -win $_nWave3 20 309 876 224
wvResizeWindow -win $_nWave2 89 432 875 245
wvSyncWindow -win $_nWave3
wvSyncWindow -win $_nWave2
wvSetWindowTimeUnit -win $_nWave2 1.000000 ns
wvSetCursor -win $_nWave2 595.118217 -snap {("G1" 2)}
wvZoom -win $_nWave2 0.000000 1181.857370
wvSelectSignal -win $_nWave2 {( "G1" 4 )}
wvSelectSignal -win $_nWave3 {( "G1" 3 )}
