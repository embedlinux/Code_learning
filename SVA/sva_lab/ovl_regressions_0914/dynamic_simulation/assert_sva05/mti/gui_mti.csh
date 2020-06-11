#!/bin/csh

set ScriptName=`basename $0`

if ( $#argv > 1 ) then 
    echo "Error: too many arguments!"
    echo ""
    echo "Example 1: $ScriptName"
    echo "Example 2: $ScriptName tb_assert_formal_pass_sim_wrapper"
    echo ""
    exit 1
endif

if ( $#argv == 1 ) then
    set TBENCH="$1"
else
    set TBENCH="tb_assert_simulation"; # Default
endif

module load mentor/modelsim/6.1f

set LOG="log/${TBENCH}-MTI_SVA.log"
set VC="../${TBENCH}.vc"

# Backup old log
if ( -f ${LOG} ) then
     mv ${LOG} ${LOG}.BAK
endif

# Compile
/bin/rm -rf work
vlib work
#
vlog -f $VC -sv
#
if ( ! -d work/$TBENCH ) then
    echo ""
    echo "ERROR: compile failed!"
    echo ""
    exit
endif

# Run simulation
vsim -gui -l $LOG work.${TBENCH} -do "WaveActivateNextPane {} 0; add wave {DUT/clk}; add wave {DUT/reset_n}; run -all; wave zoomfull"

# Add contents header to log
../../../bin/contents $LOG

# Tidy up
/bin/rm -rf work transcript vsim.wlf
