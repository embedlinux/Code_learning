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

if ( $TBENCH == "tb_assert_formal_pass_sim_wrapper" ) then
    set Optimized=1
else
    set Optimized=0
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
if ( $Optimized == 1 ) then
    vlog -f $VC -sv -vopt
else
    vlog -f $VC -sv
endif
#
if ( ! -d work/$TBENCH ) then
    echo ""
    echo "ERROR: compile failed!"
    echo ""
    exit
endif

# Run simulation
if ( $Optimized == 1 ) then
    vopt ${TBENCH} -o optimized_tbench
    vsim -l $LOG -do "run -all; quit -f" optimized_tbench
else
    vsim -l $LOG -do "run -all; quit -f" work.${TBENCH}
endif

# Add contents header to log
../../../bin/contents $LOG

# Tidy up
/bin/rm -rf work transcript vsim.wlf
